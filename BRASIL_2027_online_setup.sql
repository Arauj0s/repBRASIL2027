-- BRASIL 2027 — backend online (Supabase). Execute no SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.brasil2027_profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 username text not null unique check (username=lower(username) and username ~ '^[a-z0-9_]{3,22}$'),
 display_name text not null check (char_length(display_name) between 1 and 30),
 avatar text not null default '👤', created_at timestamptz not null default now()
);
create table if not exists public.brasil2027_friendships (
 id uuid primary key default gen_random_uuid(), requester_id uuid not null references auth.users(id) on delete cascade,
 addressee_id uuid not null references auth.users(id) on delete cascade,
 status text not null default 'pending' check(status in ('pending','accepted','rejected')),
 created_at timestamptz not null default now(), check(requester_id<>addressee_id), unique(requester_id,addressee_id)
);
create table if not exists public.brasil2027_rooms (
 id uuid primary key default gen_random_uuid(), code text not null unique check(code ~ '^[A-Z0-9]{6}$'),
 mode text not null check(mode in ('duel','coop')), host_id uuid not null references auth.users(id) on delete cascade,
 guest_id uuid references auth.users(id) on delete set null,
 status text not null default 'waiting' check(status in ('waiting','active','finished')),
 shared_state jsonb, host_state jsonb, guest_state jsonb, last_actor_id uuid references auth.users(id) on delete set null,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create index if not exists brasil2027_friendships_requester_idx on public.brasil2027_friendships(requester_id);
create index if not exists brasil2027_friendships_addressee_idx on public.brasil2027_friendships(addressee_id);
create index if not exists brasil2027_rooms_host_idx on public.brasil2027_rooms(host_id);
create index if not exists brasil2027_rooms_guest_idx on public.brasil2027_rooms(guest_id);
alter table public.brasil2027_profiles enable row level security;
alter table public.brasil2027_friendships enable row level security;
alter table public.brasil2027_rooms enable row level security;
drop policy if exists "profiles visible for username search" on public.brasil2027_profiles;
create policy "profiles visible for username search" on public.brasil2027_profiles for select using(auth.uid() is not null);
drop policy if exists "user creates own profile" on public.brasil2027_profiles;
create policy "user creates own profile" on public.brasil2027_profiles for insert with check(id=auth.uid());
drop policy if exists "user updates own profile" on public.brasil2027_profiles;
create policy "user updates own profile" on public.brasil2027_profiles for update using(id=auth.uid()) with check(id=auth.uid());
drop policy if exists "friendship visible to participants" on public.brasil2027_friendships;
create policy "friendship visible to participants" on public.brasil2027_friendships for select using(requester_id=auth.uid() or addressee_id=auth.uid());
drop policy if exists "user sends friendship request" on public.brasil2027_friendships;
create policy "user sends friendship request" on public.brasil2027_friendships for insert with check(requester_id=auth.uid());
drop policy if exists "recipient answers friendship request" on public.brasil2027_friendships;
create policy "recipient answers friendship request" on public.brasil2027_friendships for update using(addressee_id=auth.uid()) with check(addressee_id=auth.uid());
drop policy if exists "rooms visible to participants or waiting lobby" on public.brasil2027_rooms;
create policy "rooms visible to participants or waiting lobby" on public.brasil2027_rooms for select using(auth.uid() is not null and (status='waiting' or host_id=auth.uid() or guest_id=auth.uid()));
drop policy if exists "authenticated users create rooms" on public.brasil2027_rooms;
create policy "authenticated users create rooms" on public.brasil2027_rooms for insert with check(host_id=auth.uid());
drop policy if exists "room participants update room" on public.brasil2027_rooms;
create policy "room participants update room" on public.brasil2027_rooms for update using(host_id=auth.uid() or guest_id=auth.uid() or (status='waiting' and (guest_id is null or guest_id=auth.uid()))) with check(host_id=auth.uid() or guest_id=auth.uid());
do $$ begin
 if exists (select 1 from pg_publication where pubname='supabase_realtime')
 and not exists (select 1 from pg_publication_tables where pubname='supabase_realtime' and schemaname='public' and tablename='brasil2027_rooms') then
  alter publication supabase_realtime add table public.brasil2027_rooms;
 end if;
end $$;
-- Confirme em Database -> Publications/Realtime se a tabela ficou habilitada.
-- A chave anon/public pode ser usada no navegador com RLS ativo. NUNCA exponha service_role.
