-- QUESTOS SUPABASE SCHEMA
-- Run this in Supabase SQL Editor after creating a project.

create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text not null,
  points integer not null default 0,
  public boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  time text,
  category text default 'General',
  days text[] not null default '{}',
  completed text[] not null default '{}',
  created_at timestamptz not null default now()
);

create table if not exists quests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  category text default 'Other',
  desc text,
  reward integer not null check (reward > 0),
  created_at timestamptz not null default now()
);

create table if not exists shop_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  name text not null,
  desc text,
  cost integer not null check (cost > 0),
  icon text default '🎁'
);

create table if not exists purchases (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  cost integer not null,
  date date not null default current_date,
  created_at timestamptz not null default now()
);

create table if not exists point_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null default current_date,
  delta integer not null,
  type text not null,
  label text,
  ref text,
  created_at timestamptz not null default now()
);

alter table profiles enable row level security;
alter table tasks enable row level security;
alter table quests enable row level security;
alter table shop_items enable row level security;
alter table purchases enable row level security;
alter table point_logs enable row level security;

create policy "own profile" on profiles for all using (auth.uid()=id) with check (auth.uid()=id);
create policy "public profiles readable" on profiles for select using (public=true or auth.uid()=id);
create policy "own tasks" on tasks for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "own quests" on quests for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "shop readable" on shop_items for select using (user_id is null or auth.uid()=user_id);
create policy "own shop" on shop_items for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "own purchases" on purchases for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "own logs" on point_logs for all using (auth.uid()=user_id) with check (auth.uid()=user_id);

-- Add global shop items manually, for example:
insert into shop_items (user_id,name,desc,cost,icon) values
(null,'Dopamine Scroll','20 minutes of intentional scrolling',100,'📱'),
(null,'Gaming Session','45 minutes',250,'🎮'),
(null,'Movie / Episode','One guilt-free episode',400,'🎬')
on conflict do nothing;
