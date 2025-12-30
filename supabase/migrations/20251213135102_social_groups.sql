
  create table "public"."group_members" (
    "group_id" uuid not null,
    "user_id" uuid not null,
    "status" character varying(20) default 'joined'::character varying,
    "joined_at" timestamp with time zone default now()
      );


alter table "public"."group_members" enable row level security;


  create table "public"."group_plans" (
    "group_id" uuid not null,
    "route_geom" extensions.geography(LineString,4326),
    "distance_meters" integer,
    "elevation_gain_meters" integer,
    "estimated_duration_minutes" integer,
    "file_url" text
      );


alter table "public"."group_plans" enable row level security;


  create table "public"."groups" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "creator_id" uuid not null,
    "name" character varying(255) not null,
    "description" text,
    "sport_type" character varying(50) not null,
    "start_time" timestamp with time zone not null,
    "max_participants" integer,
    "is_private" boolean default false,
    "location_geom" extensions.geography(Point,4326) not null,
    "location_name" text,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now(),
    "deleted_at" timestamp with time zone
      );


alter table "public"."groups" enable row level security;

CREATE UNIQUE INDEX group_members_pkey ON public.group_members USING btree (group_id, user_id);

CREATE UNIQUE INDEX group_plans_pkey ON public.group_plans USING btree (group_id);

CREATE UNIQUE INDEX groups_pkey ON public.groups USING btree (id);

CREATE INDEX idx_group_members_user ON public.group_members USING btree (user_id);

CREATE INDEX idx_groups_creator ON public.groups USING btree (creator_id);

CREATE INDEX idx_groups_location ON public.groups USING gist (location_geom);

alter table "public"."group_members" add constraint "group_members_pkey" PRIMARY KEY using index "group_members_pkey";

alter table "public"."group_plans" add constraint "group_plans_pkey" PRIMARY KEY using index "group_plans_pkey";

alter table "public"."groups" add constraint "groups_pkey" PRIMARY KEY using index "groups_pkey";

alter table "public"."group_members" add constraint "group_members_group_id_fkey" FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE not valid;

alter table "public"."group_members" validate constraint "group_members_group_id_fkey";

alter table "public"."group_members" add constraint "group_members_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."group_members" validate constraint "group_members_user_id_fkey";

alter table "public"."group_plans" add constraint "group_plans_group_id_fkey" FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE not valid;

alter table "public"."group_plans" validate constraint "group_plans_group_id_fkey";

alter table "public"."groups" add constraint "groups_creator_id_fkey" FOREIGN KEY (creator_id) REFERENCES public.users(id) not valid;

alter table "public"."groups" validate constraint "groups_creator_id_fkey";

grant delete on table "public"."group_members" to "anon";

grant insert on table "public"."group_members" to "anon";

grant references on table "public"."group_members" to "anon";

grant select on table "public"."group_members" to "anon";

grant trigger on table "public"."group_members" to "anon";

grant truncate on table "public"."group_members" to "anon";

grant update on table "public"."group_members" to "anon";

grant delete on table "public"."group_members" to "authenticated";

grant insert on table "public"."group_members" to "authenticated";

grant references on table "public"."group_members" to "authenticated";

grant select on table "public"."group_members" to "authenticated";

grant trigger on table "public"."group_members" to "authenticated";

grant truncate on table "public"."group_members" to "authenticated";

grant update on table "public"."group_members" to "authenticated";

grant delete on table "public"."group_members" to "service_role";

grant insert on table "public"."group_members" to "service_role";

grant references on table "public"."group_members" to "service_role";

grant select on table "public"."group_members" to "service_role";

grant trigger on table "public"."group_members" to "service_role";

grant truncate on table "public"."group_members" to "service_role";

grant update on table "public"."group_members" to "service_role";

grant delete on table "public"."group_plans" to "anon";

grant insert on table "public"."group_plans" to "anon";

grant references on table "public"."group_plans" to "anon";

grant select on table "public"."group_plans" to "anon";

grant trigger on table "public"."group_plans" to "anon";

grant truncate on table "public"."group_plans" to "anon";

grant update on table "public"."group_plans" to "anon";

grant delete on table "public"."group_plans" to "authenticated";

grant insert on table "public"."group_plans" to "authenticated";

grant references on table "public"."group_plans" to "authenticated";

grant select on table "public"."group_plans" to "authenticated";

grant trigger on table "public"."group_plans" to "authenticated";

grant truncate on table "public"."group_plans" to "authenticated";

grant update on table "public"."group_plans" to "authenticated";

grant delete on table "public"."group_plans" to "service_role";

grant insert on table "public"."group_plans" to "service_role";

grant references on table "public"."group_plans" to "service_role";

grant select on table "public"."group_plans" to "service_role";

grant trigger on table "public"."group_plans" to "service_role";

grant truncate on table "public"."group_plans" to "service_role";

grant update on table "public"."group_plans" to "service_role";

grant delete on table "public"."groups" to "anon";

grant insert on table "public"."groups" to "anon";

grant references on table "public"."groups" to "anon";

grant select on table "public"."groups" to "anon";

grant trigger on table "public"."groups" to "anon";

grant truncate on table "public"."groups" to "anon";

grant update on table "public"."groups" to "anon";

grant delete on table "public"."groups" to "authenticated";

grant insert on table "public"."groups" to "authenticated";

grant references on table "public"."groups" to "authenticated";

grant select on table "public"."groups" to "authenticated";

grant trigger on table "public"."groups" to "authenticated";

grant truncate on table "public"."groups" to "authenticated";

grant update on table "public"."groups" to "authenticated";

grant delete on table "public"."groups" to "service_role";

grant insert on table "public"."groups" to "service_role";

grant references on table "public"."groups" to "service_role";

grant select on table "public"."groups" to "service_role";

grant trigger on table "public"."groups" to "service_role";

grant truncate on table "public"."groups" to "service_role";

grant update on table "public"."groups" to "service_role";


  create policy "Members viewable by everyone"
  on "public"."group_members"
  as permissive
  for select
  to public
using (true);



  create policy "Users can join groups"
  on "public"."group_members"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "Users can leave groups"
  on "public"."group_members"
  as permissive
  for delete
  to public
using ((auth.uid() = user_id));



  create policy "Group creators manage plans"
  on "public"."group_plans"
  as permissive
  for all
  to public
using ((EXISTS ( SELECT 1
   FROM public.groups
  WHERE ((groups.id = group_plans.group_id) AND (groups.creator_id = auth.uid())))));



  create policy "Plans viewable by everyone"
  on "public"."group_plans"
  as permissive
  for select
  to public
using (true);



  create policy "Authenticated users can create groups"
  on "public"."groups"
  as permissive
  for insert
  to public
with check ((auth.uid() = creator_id));



  create policy "Creators can manage their groups"
  on "public"."groups"
  as permissive
  for update
  to public
using ((auth.uid() = creator_id));



  create policy "Groups are viewable by everyone"
  on "public"."groups"
  as permissive
  for select
  to public
using (true);



