-- Run this entire script in Supabase Dashboard -> SQL Editor -> New query.
create extension if not exists pgcrypto;

create table if not exists public.subjects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (char_length(name) between 1 and 70),
  timetable text not null default '',
  created_at timestamptz not null default now()
);

create table if not exists public.attendance (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  subject_id uuid not null references public.subjects(id) on delete cascade,
  attendance_date date not null,
  status text not null check (status in ('present','absent','leave')),
  created_at timestamptz not null default now(),
  unique (user_id, subject_id, attendance_date)
);

create index if not exists subjects_user_id_idx on public.subjects(user_id);
create index if not exists attendance_user_date_idx on public.attendance(user_id, attendance_date);

alter table public.subjects enable row level security;
alter table public.attendance enable row level security;

drop policy if exists "Users manage their own subjects" on public.subjects;
create policy "Users manage their own subjects" on public.subjects
  for all to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users manage their own attendance" on public.attendance;
create policy "Users manage their own attendance" on public.attendance
  for all to authenticated
  using (auth.uid() = user_id)
  with check (
    auth.uid() = user_id
    and exists (
      select 1 from public.subjects s
      where s.id = subject_id and s.user_id = auth.uid()
    )
  );
