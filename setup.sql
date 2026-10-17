-- Paste this whole file in Supabase: SQL Editor -> New query -> Run

create table articles (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(title) <= 150),
  author text not null default '',
  body text not null check (char_length(body) <= 12000),
  type text not null check (type in ('news','une','misc')),
  image text not null default '' check (char_length(image) <= 400000),
  admin boolean not null default false,
  ts bigint not null,
  day text not null
);
create index articles_day_idx on articles(day);
create table admins (uid uuid primary key);

alter table articles enable row level security;
alter table admins enable row level security;

create function is_admin() returns boolean
language sql security definer stable set search_path = public as
$$ select exists (select 1 from admins where uid = auth.uid()) $$;

-- The writer code lives HERE (change 'dngjournal' to change the code)
create function become_admin(code text) returns boolean
language plpgsql security definer set search_path = public as $$
begin
  if code = 'dngjournal' and auth.uid() is not null then
    insert into admins values (auth.uid()) on conflict do nothing;
    return true;
  end if;
  return false;
end $$;

create function resign_admin() returns void
language sql security definer set search_path = public as
$$ delete from admins where uid = auth.uid() $$;

create policy "anyone reads" on articles for select using (true);
create policy "visitors write miscellany, admins write all" on articles for insert
  with check (is_admin() or (admin = false and type = 'misc'));
create policy "admins edit" on articles for update using (is_admin());
-- admins delete anything; anyone can delete issues older than 7 days (auto-cleanup)
create policy "admins delete, anyone purges old" on articles for delete
  using (is_admin() or ts < (extract(epoch from now()) * 1000)::bigint - 604800000);
