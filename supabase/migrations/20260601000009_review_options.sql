-- ============================================================
-- 20260601000009_review_options.sql — add an `options` column to the review
-- output so the AI explanation has the full question (all 4 choices).
-- Return type changes → must DROP before CREATE.
-- ============================================================

drop function if exists get_attempt_review(uuid);

create or replace function get_attempt_review(p_attempt_id uuid)
returns table (
  "position" int,
  stem text,
  level text,
  selected_label text,
  selected_content text,
  correct_label text,
  correct_content text,
  is_correct boolean,
  options jsonb
)
language sql
security definer
set search_path = public
as $$
  select
    q.position, q.stem, q.level,
    sc.label   as selected_label,
    sc.content as selected_content,
    cc.label   as correct_label,
    cc.content as correct_content,
    aa.is_correct,
    (select jsonb_agg(jsonb_build_object('label', c.label, 'content', c.content)
                      order by c.position)
       from choices c where c.question_id = q.id) as options
  from attempt_answers aa
  join attempts a   on a.id = aa.attempt_id and a.user_id = auth.uid()
  join questions q  on q.id = aa.question_id
  left join choices sc on sc.id = aa.selected_choice_id
  join choices cc   on cc.question_id = q.id and cc.is_correct = true
  where aa.attempt_id = p_attempt_id
  order by q.position;
$$;

revoke all on function get_attempt_review(uuid) from public;
grant execute on function get_attempt_review(uuid) to authenticated;
