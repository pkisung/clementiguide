-- 사이트에서 후기 등록이 안 될 때 SQL Editor에서 이것만 실행하세요.

drop policy if exists "Anyone can submit reviews" on public.reviews;
create policy "Anyone can submit reviews"
  on public.reviews
  for insert
  with check (is_visible = true);
