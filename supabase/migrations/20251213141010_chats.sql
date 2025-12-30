
  create table "public"."conversation_contexts" (
    "conversation_id" uuid not null,
    "group_id" uuid,
    "guide_activity_id" uuid,
    "guide_slot_start_time" timestamp with time zone
      );


alter table "public"."conversation_contexts" enable row level security;


  create table "public"."conversation_participants" (
    "conversation_id" uuid not null,
    "user_id" uuid not null,
    "last_read_at" timestamp with time zone default now(),
    "joined_at" timestamp with time zone default now()
      );


alter table "public"."conversation_participants" enable row level security;


  create table "public"."conversations" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "type" public.conversation_type not null,
    "title" character varying(255),
    "created_at" timestamp with time zone default now()
      );


alter table "public"."conversations" enable row level security;


  create table "public"."messages" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "conversation_id" uuid not null,
    "sender_id" uuid not null,
    "content" text,
    "attachment_url" text,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."messages" enable row level security;

CREATE UNIQUE INDEX conversation_contexts_group_id_key ON public.conversation_contexts USING btree (group_id);

CREATE UNIQUE INDEX conversation_contexts_guide_activity_id_guide_slot_start_ti_key ON public.conversation_contexts USING btree (guide_activity_id, guide_slot_start_time);

CREATE UNIQUE INDEX conversation_contexts_pkey ON public.conversation_contexts USING btree (conversation_id);

CREATE UNIQUE INDEX conversation_participants_pkey ON public.conversation_participants USING btree (conversation_id, user_id);

CREATE UNIQUE INDEX conversations_pkey ON public.conversations USING btree (id);

CREATE INDEX idx_messages_conversation ON public.messages USING btree (conversation_id, created_at DESC);

CREATE INDEX idx_participants_user ON public.conversation_participants USING btree (user_id);

CREATE UNIQUE INDEX messages_pkey ON public.messages USING btree (id);

alter table "public"."conversation_contexts" add constraint "conversation_contexts_pkey" PRIMARY KEY using index "conversation_contexts_pkey";

alter table "public"."conversation_participants" add constraint "conversation_participants_pkey" PRIMARY KEY using index "conversation_participants_pkey";

alter table "public"."conversations" add constraint "conversations_pkey" PRIMARY KEY using index "conversations_pkey";

alter table "public"."messages" add constraint "messages_pkey" PRIMARY KEY using index "messages_pkey";

alter table "public"."conversation_contexts" add constraint "check_context_exclusivity" CHECK ((((group_id IS NOT NULL) AND (guide_activity_id IS NULL)) OR ((group_id IS NULL) AND (guide_activity_id IS NOT NULL) AND (guide_slot_start_time IS NOT NULL)))) not valid;

alter table "public"."conversation_contexts" validate constraint "check_context_exclusivity";

alter table "public"."conversation_contexts" add constraint "conversation_contexts_conversation_id_fkey" FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE not valid;

alter table "public"."conversation_contexts" validate constraint "conversation_contexts_conversation_id_fkey";

alter table "public"."conversation_contexts" add constraint "conversation_contexts_group_id_fkey" FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE not valid;

alter table "public"."conversation_contexts" validate constraint "conversation_contexts_group_id_fkey";

alter table "public"."conversation_contexts" add constraint "conversation_contexts_group_id_key" UNIQUE using index "conversation_contexts_group_id_key";

alter table "public"."conversation_contexts" add constraint "conversation_contexts_guide_activity_id_fkey" FOREIGN KEY (guide_activity_id) REFERENCES public.guide_activities(id) not valid;

alter table "public"."conversation_contexts" validate constraint "conversation_contexts_guide_activity_id_fkey";

alter table "public"."conversation_contexts" add constraint "conversation_contexts_guide_activity_id_guide_slot_start_ti_key" UNIQUE using index "conversation_contexts_guide_activity_id_guide_slot_start_ti_key";

alter table "public"."conversation_participants" add constraint "conversation_participants_conversation_id_fkey" FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE not valid;

alter table "public"."conversation_participants" validate constraint "conversation_participants_conversation_id_fkey";

alter table "public"."conversation_participants" add constraint "conversation_participants_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."conversation_participants" validate constraint "conversation_participants_user_id_fkey";

alter table "public"."messages" add constraint "messages_conversation_id_fkey" FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_conversation_id_fkey";

alter table "public"."messages" add constraint "messages_sender_id_fkey" FOREIGN KEY (sender_id) REFERENCES public.users(id) not valid;

alter table "public"."messages" validate constraint "messages_sender_id_fkey";

grant delete on table "public"."conversation_contexts" to "anon";

grant insert on table "public"."conversation_contexts" to "anon";

grant references on table "public"."conversation_contexts" to "anon";

grant select on table "public"."conversation_contexts" to "anon";

grant trigger on table "public"."conversation_contexts" to "anon";

grant truncate on table "public"."conversation_contexts" to "anon";

grant update on table "public"."conversation_contexts" to "anon";

grant delete on table "public"."conversation_contexts" to "authenticated";

grant insert on table "public"."conversation_contexts" to "authenticated";

grant references on table "public"."conversation_contexts" to "authenticated";

grant select on table "public"."conversation_contexts" to "authenticated";

grant trigger on table "public"."conversation_contexts" to "authenticated";

grant truncate on table "public"."conversation_contexts" to "authenticated";

grant update on table "public"."conversation_contexts" to "authenticated";

grant delete on table "public"."conversation_contexts" to "service_role";

grant insert on table "public"."conversation_contexts" to "service_role";

grant references on table "public"."conversation_contexts" to "service_role";

grant select on table "public"."conversation_contexts" to "service_role";

grant trigger on table "public"."conversation_contexts" to "service_role";

grant truncate on table "public"."conversation_contexts" to "service_role";

grant update on table "public"."conversation_contexts" to "service_role";

grant delete on table "public"."conversation_participants" to "anon";

grant insert on table "public"."conversation_participants" to "anon";

grant references on table "public"."conversation_participants" to "anon";

grant select on table "public"."conversation_participants" to "anon";

grant trigger on table "public"."conversation_participants" to "anon";

grant truncate on table "public"."conversation_participants" to "anon";

grant update on table "public"."conversation_participants" to "anon";

grant delete on table "public"."conversation_participants" to "authenticated";

grant insert on table "public"."conversation_participants" to "authenticated";

grant references on table "public"."conversation_participants" to "authenticated";

grant select on table "public"."conversation_participants" to "authenticated";

grant trigger on table "public"."conversation_participants" to "authenticated";

grant truncate on table "public"."conversation_participants" to "authenticated";

grant update on table "public"."conversation_participants" to "authenticated";

grant delete on table "public"."conversation_participants" to "service_role";

grant insert on table "public"."conversation_participants" to "service_role";

grant references on table "public"."conversation_participants" to "service_role";

grant select on table "public"."conversation_participants" to "service_role";

grant trigger on table "public"."conversation_participants" to "service_role";

grant truncate on table "public"."conversation_participants" to "service_role";

grant update on table "public"."conversation_participants" to "service_role";

grant delete on table "public"."conversations" to "anon";

grant insert on table "public"."conversations" to "anon";

grant references on table "public"."conversations" to "anon";

grant select on table "public"."conversations" to "anon";

grant trigger on table "public"."conversations" to "anon";

grant truncate on table "public"."conversations" to "anon";

grant update on table "public"."conversations" to "anon";

grant delete on table "public"."conversations" to "authenticated";

grant insert on table "public"."conversations" to "authenticated";

grant references on table "public"."conversations" to "authenticated";

grant select on table "public"."conversations" to "authenticated";

grant trigger on table "public"."conversations" to "authenticated";

grant truncate on table "public"."conversations" to "authenticated";

grant update on table "public"."conversations" to "authenticated";

grant delete on table "public"."conversations" to "service_role";

grant insert on table "public"."conversations" to "service_role";

grant references on table "public"."conversations" to "service_role";

grant select on table "public"."conversations" to "service_role";

grant trigger on table "public"."conversations" to "service_role";

grant truncate on table "public"."conversations" to "service_role";

grant update on table "public"."conversations" to "service_role";

grant delete on table "public"."messages" to "anon";

grant insert on table "public"."messages" to "anon";

grant references on table "public"."messages" to "anon";

grant select on table "public"."messages" to "anon";

grant trigger on table "public"."messages" to "anon";

grant truncate on table "public"."messages" to "anon";

grant update on table "public"."messages" to "anon";

grant delete on table "public"."messages" to "authenticated";

grant insert on table "public"."messages" to "authenticated";

grant references on table "public"."messages" to "authenticated";

grant select on table "public"."messages" to "authenticated";

grant trigger on table "public"."messages" to "authenticated";

grant truncate on table "public"."messages" to "authenticated";

grant update on table "public"."messages" to "authenticated";

grant delete on table "public"."messages" to "service_role";

grant insert on table "public"."messages" to "service_role";

grant references on table "public"."messages" to "service_role";

grant select on table "public"."messages" to "service_role";

grant trigger on table "public"."messages" to "service_role";

grant truncate on table "public"."messages" to "service_role";

grant update on table "public"."messages" to "service_role";


  create policy "Contexts viewable by everyone"
  on "public"."conversation_contexts"
  as permissive
  for select
  to public
using (true);



  create policy "Users manage own participation"
  on "public"."conversation_participants"
  as permissive
  for all
  to public
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));



  create policy "Users view chat peers"
  on "public"."conversation_participants"
  as permissive
  for select
  to public
using ((EXISTS ( SELECT 1
   FROM public.conversation_participants cp
  WHERE ((cp.conversation_id = conversation_participants.conversation_id) AND (cp.user_id = auth.uid())))));



  create policy "Participants send messages"
  on "public"."messages"
  as permissive
  for insert
  to public
with check (((auth.uid() = sender_id) AND (EXISTS ( SELECT 1
   FROM public.conversation_participants
  WHERE ((conversation_participants.conversation_id = messages.conversation_id) AND (conversation_participants.user_id = auth.uid()))))));



  create policy "Participants view messages"
  on "public"."messages"
  as permissive
  for select
  to public
using ((EXISTS ( SELECT 1
   FROM public.conversation_participants
  WHERE ((conversation_participants.conversation_id = messages.conversation_id) AND (conversation_participants.user_id = auth.uid())))));



