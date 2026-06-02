-- Fix: choices_public returned 0 rows for authenticated users because the view
-- used security_invoker = true and `choices` has RLS enabled with no SELECT policy.
-- Recreate as a security-definer view (owner = postgres) so it bypasses RLS.
-- Still safe: the view never exposes is_correct.
create or replace view choices_public
with (security_invoker = false) as
  select id, question_id, label, content, position
  from choices;

grant select on choices_public to authenticated;
