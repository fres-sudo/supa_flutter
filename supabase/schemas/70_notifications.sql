create table public.notifications (
  id uuid primary key default extensions.uuid_generate_v4(),
  user_id uuid not null references public.users(id),
  title text not null,
  body text not null,
  payload jsonb not null,
  created_at timestamptz not null default now()
);

alter table public.notifications enable row level security;

create policy "Users can view their own notifications" on public.notifications for select using (auth.uid() = user_id);
