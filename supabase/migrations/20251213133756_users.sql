create extension if not exists "pg_net" with schema "extensions";

create type "public"."booking_status" as enum ('pending', 'confirmed', 'cancelled', 'completed');

create type "public"."certification_status" as enum ('pending', 'approved', 'rejected');

create type "public"."conversation_type" as enum ('group', 'guide_activity', 'direct');

create type "public"."schedule_type" as enum ('strict', 'flexible');

create type "public"."user_role" as enum ('member', 'guide', 'brand', 'admin');


  create table "public"."guide_certifications" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "user_id" uuid not null,
    "document_url" text not null,
    "status" public.certification_status not null default 'pending'::public.certification_status,
    "rejection_reason" text,
    "reviewed_by" uuid,
    "reviewed_at" timestamp with time zone,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."guide_certifications" enable row level security;


  create table "public"."users" (
    "id" uuid not null,
    "role" public.user_role not null default 'member'::public.user_role,
    "first_name" character varying(100),
    "last_name" character varying(100),
    "bio" text,
    "avatar_url" text,
    "fcm_token" text,
    "language" text not null default 'en'::text,
    "timezone" text not null default 'UTC'::text,
    "location" extensions.geography,
    "liked_sports" text[],
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now(),
    "deleted_at" timestamp with time zone
      );


alter table "public"."users" enable row level security;

CREATE UNIQUE INDEX guide_certifications_pkey ON public.guide_certifications USING btree (id);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

alter table "public"."guide_certifications" add constraint "guide_certifications_pkey" PRIMARY KEY using index "guide_certifications_pkey";

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."guide_certifications" add constraint "guide_certifications_reviewed_by_fkey" FOREIGN KEY (reviewed_by) REFERENCES public.users(id) not valid;

alter table "public"."guide_certifications" validate constraint "guide_certifications_reviewed_by_fkey";

alter table "public"."guide_certifications" add constraint "guide_certifications_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."guide_certifications" validate constraint "guide_certifications_user_id_fkey";

alter table "public"."users" add constraint "users_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."users" validate constraint "users_id_fkey";

grant delete on table "public"."guide_certifications" to "anon";

grant insert on table "public"."guide_certifications" to "anon";

grant references on table "public"."guide_certifications" to "anon";

grant select on table "public"."guide_certifications" to "anon";

grant trigger on table "public"."guide_certifications" to "anon";

grant truncate on table "public"."guide_certifications" to "anon";

grant update on table "public"."guide_certifications" to "anon";

grant delete on table "public"."guide_certifications" to "authenticated";

grant insert on table "public"."guide_certifications" to "authenticated";

grant references on table "public"."guide_certifications" to "authenticated";

grant select on table "public"."guide_certifications" to "authenticated";

grant trigger on table "public"."guide_certifications" to "authenticated";

grant truncate on table "public"."guide_certifications" to "authenticated";

grant update on table "public"."guide_certifications" to "authenticated";

grant delete on table "public"."guide_certifications" to "service_role";

grant insert on table "public"."guide_certifications" to "service_role";

grant references on table "public"."guide_certifications" to "service_role";

grant select on table "public"."guide_certifications" to "service_role";

grant trigger on table "public"."guide_certifications" to "service_role";

grant truncate on table "public"."guide_certifications" to "service_role";

grant update on table "public"."guide_certifications" to "service_role";

grant delete on table "public"."users" to "anon";

grant insert on table "public"."users" to "anon";

grant references on table "public"."users" to "anon";

grant select on table "public"."users" to "anon";

grant trigger on table "public"."users" to "anon";

grant truncate on table "public"."users" to "anon";

grant update on table "public"."users" to "anon";

grant delete on table "public"."users" to "authenticated";

grant insert on table "public"."users" to "authenticated";

grant references on table "public"."users" to "authenticated";

grant select on table "public"."users" to "authenticated";

grant trigger on table "public"."users" to "authenticated";

grant truncate on table "public"."users" to "authenticated";

grant update on table "public"."users" to "authenticated";

grant delete on table "public"."users" to "service_role";

grant insert on table "public"."users" to "service_role";

grant references on table "public"."users" to "service_role";

grant select on table "public"."users" to "service_role";

grant trigger on table "public"."users" to "service_role";

grant truncate on table "public"."users" to "service_role";

grant update on table "public"."users" to "service_role";


  create policy "Users manage own certs"
  on "public"."guide_certifications"
  as permissive
  for all
  to public
using ((auth.uid() = user_id));



  create policy "Users view own certs"
  on "public"."guide_certifications"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "Public profiles are viewable by everyone"
  on "public"."users"
  as permissive
  for select
  to public
using (true);



  create policy "Users can update own profile"
  on "public"."users"
  as permissive
  for update
  to public
using ((auth.uid() = id));



