-- ============================================================
-- 20260601000006_import_exam.sql — bulk-import an exam from CSV.
-- One transaction: exam + questions + choices. Mirrors submit_attempt security.
-- ============================================================

-- p_questions: jsonb array, one object per question:
--   [{"position":1,"level":"D","stem":"...",
--     "options":[{"label":"A","content":"...","position":0}, ...],
--     "answer":"B"}, ...]
create or replace function import_exam(
  p_title       text,
  p_description text,
  p_questions   jsonb
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid    uuid := auth.uid();
  v_exam   uuid;
  v_qid    uuid;
  v_total  int;
  v_levels jsonb;
  q        jsonb;
  opt      jsonb;
  v_pos    int;
  v_level  text;
  v_stem   text;
  v_answer text;
  v_seen_correct boolean;
begin
  if v_uid is null then
    raise exception 'Not authenticated';
  end if;

  if p_title is null or btrim(p_title) = '' then
    raise exception 'Title is required';
  end if;

  v_total := jsonb_array_length(coalesce(p_questions, '[]'::jsonb));
  if v_total = 0 then
    raise exception 'No questions provided';
  end if;

  -- level counts -> {"D":x,"TB":y,"K":z}
  select jsonb_object_agg(lvl, cnt)
    into v_levels
  from (
    select (e->>'level') as lvl, count(*)::int as cnt
    from jsonb_array_elements(p_questions) e
    group by (e->>'level')
  ) s;

  insert into exams (title, description, total_questions, levels)
  values (
    btrim(p_title),
    nullif(btrim(coalesce(p_description, '')), ''),
    v_total,
    coalesce(v_levels, '{}'::jsonb)
  )
  returning id into v_exam;

  for q in select * from jsonb_array_elements(p_questions) loop
    v_pos    := (q->>'position')::int;
    v_level  := q->>'level';
    v_stem   := q->>'stem';
    v_answer := upper(btrim(q->>'answer'));

    if v_level not in ('D','TB','K') then
      raise exception 'Invalid level "%" at position %', v_level, v_pos;
    end if;
    if v_stem is null or btrim(v_stem) = '' then
      raise exception 'Empty stem at position %', v_pos;
    end if;
    if v_answer not in ('A','B','C','D') then
      raise exception 'Invalid answer "%" at position %', v_answer, v_pos;
    end if;

    insert into questions (exam_id, position, stem, level)
    values (v_exam, v_pos, v_stem, v_level)
    returning id into v_qid;

    v_seen_correct := false;
    for opt in select * from jsonb_array_elements(q->'options') loop
      insert into choices (question_id, label, content, is_correct, position)
      values (
        v_qid,
        opt->>'label',
        opt->>'content',
        (upper(btrim(opt->>'label')) = v_answer),
        (opt->>'position')::int
      );
      if upper(btrim(opt->>'label')) = v_answer then
        v_seen_correct := true;
      end if;
    end loop;

    if not v_seen_correct then
      raise exception 'Answer "%" not found among options at position %', v_answer, v_pos;
    end if;
  end loop;

  return v_exam;
end;
$$;

revoke all on function import_exam(text, text, jsonb) from public;
grant execute on function import_exam(text, text, jsonb) to authenticated;
