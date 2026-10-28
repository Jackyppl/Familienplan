-- Einmal im Supabase SQL Editor ausführen.
create table if not exists public.family_plan (
  owner_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.family_plan enable row level security;
create policy "Only the signed-in family account can read its plan"
  on public.family_plan for select to authenticated
  using (auth.uid() = owner_id);
create policy "Only the signed-in family account can create its plan"
  on public.family_plan for insert to authenticated
  with check (auth.uid() = owner_id);
create policy "Only the signed-in family account can update its plan"
  on public.family_plan for update to authenticated
  using (auth.uid() = owner_id)
  with check (auth.uid() = owner_id);
