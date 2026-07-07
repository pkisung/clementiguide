
create table if not exists public.reviews (
  id bigint generated always as identity primary key,
  name text not null,
  location text not null,
  service_type text not null,
  content text not null,
  is_visible boolean not null default true,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table public.reviews enable row level security;

drop policy if exists "Public can read visible reviews" on public.reviews;
create policy "Public can read visible reviews"
  on public.reviews
  for select
  using (is_visible = true);

drop policy if exists "Anyone can submit reviews" on public.reviews;
create policy "Anyone can submit reviews"
  on public.reviews
  for insert
  with check (is_visible = true);

-- 기존 하드코딩 후기 시드 
do $$
begin
  if not exists (select 1 from public.reviews limit 1) then
    insert into public.reviews (name, location, service_type, content, sort_order) values
      ('김**', '중국 광저우', '캔톤페어 비즈니스 통역', '전시회 미팅마다 통역사가 동행해 협상이 매끄러웠습니다. 전문 용어도 정확하게 전달해주셨어요.', 1),
      ('이**', '싱가포르', '프라이빗 시티 투어', '동선을 직접 짜주셔서 짧은 일정에도 다 둘러봤습니다. 비용도 미리 투명하게 안내받아 마음 편했어요.', 2),
      ('박**', '일본 오사카', '가족 프라이빗 투어', '아이들 페이스에 맞춰 일정을 조정해주셔서 가족 모두 편하게 다녔습니다. 다음에도 부탁드리고 싶어요.', 3),
      ('최**', '대만 타이베이', '제조 파트너 미팅 통역', '기술 용어가 많은 미팅이었는데 정확하게 전달해주셨습니다. 덕분에 협상이 잘 마무리됐어요.', 4),
      ('정**', '베트남 호찌민', '공장 실사 통역', '현지 사정을 잘 아셔서 미팅 외 이동도 수월했습니다. 통역 품질이 기대 이상이었어요.', 5),
      ('강**', '태국 방콕', 'THAIFEX 비즈니스 통역', '바이어 상담 통역에 집중해주셔서 효율적이었습니다. 다음 출장에도 함께하고 싶어요.', 6),
      ('윤**', '호주 시드니', '프라이빗 투어', '멜버른까지 이동 동선을 무리 없이 짜주셨어요. 현지 가이드라 알찬 곳을 많이 알게 됐습니다.', 7),
      ('장**', '인도네시아 발리', '커플 프라이빗 투어', '원하는 분위기를 말씀드리니 거기에 맞게 코스를 구성해주셨어요. 잊지 못할 여행이었습니다.', 8),
      ('임**', '미국 뉴욕', '바이어 미팅 통역', '미팅 자리에서 의사소통이 정확했습니다. 통역사 덕분에 자신감 있게 상담했어요.', 9),
      ('한**', '말레이시아 쿠알라룸푸르', '비즈니스 통역 + 투어', '오전 미팅 통역, 오후 시내 투어를 한 가이드와 진행해 편했습니다. 일정 조율이 유연했어요.', 10),
      ('오**', '헝가리 부다페스트', '유럽 진출 미팅 통역', '짧은 출장이었는데 통역과 동선을 알차게 잡아주셨습니다. 비용도 합의된 대로만 진행돼 깔끔했어요.', 11),
      ('서**', '필리핀 세부', '프라이빗 투어', '현지 가이드라 숨은 장소까지 잘 안내받았습니다. 가족 여행으로 완벽했어요.', 12);
  end if;
end $$;
