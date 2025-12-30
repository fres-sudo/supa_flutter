
  create table "public"."activity_subscribers" (
    "user_id" uuid not null,
    "guide_activity_id" uuid not null,
    "subscribed_at" timestamp with time zone default now()
      );


alter table "public"."activity_subscribers" enable row level security;


  create table "public"."bookings" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "user_id" uuid not null,
    "guide_activity_id" uuid not null,
    "slot_start_time" timestamp with time zone not null,
    "status" public.booking_status not null default 'pending'::public.booking_status,
    "price_paid_cents" integer not null,
    "stripe_payment_intent_id" character varying(255),
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
      );


alter table "public"."bookings" enable row level security;


  create table "public"."guide_activities" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "guide_id" uuid not null,
    "title" character varying(255) not null,
    "description" text,
    "price_cents" integer not null default 0,
    "currency" character(3) default 'USD'::bpchar,
    "duration_minutes" integer not null,
    "max_slots_per_session" integer not null,
    "location_geom" extensions.geography(Point,4326),
    "location_name" text,
    "schedule_type" public.schedule_type not null default 'strict'::public.schedule_type,
    "recurrence_rule" text,
    "frequency_label" character varying(100),
    "is_active" boolean default true,
    "created_at" timestamp with time zone default now(),
    "deleted_at" timestamp with time zone
      );


alter table "public"."guide_activities" enable row level security;


  create table "public"."manual_availability_slots" (
    "id" uuid not null default extensions.uuid_generate_v4(),
    "guide_activity_id" uuid not null,
    "start_time" timestamp with time zone not null,
    "override_max_slots" integer,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."manual_availability_slots" enable row level security;

CREATE UNIQUE INDEX activity_subscribers_pkey ON public.activity_subscribers USING btree (user_id, guide_activity_id);

CREATE UNIQUE INDEX bookings_pkey ON public.bookings USING btree (id);

CREATE UNIQUE INDEX bookings_user_id_guide_activity_id_slot_start_time_key ON public.bookings USING btree (user_id, guide_activity_id, slot_start_time);

CREATE UNIQUE INDEX guide_activities_pkey ON public.guide_activities USING btree (id);

CREATE INDEX idx_bookings_activity ON public.bookings USING btree (guide_activity_id, slot_start_time);

CREATE INDEX idx_bookings_user ON public.bookings USING btree (user_id);

CREATE INDEX idx_guide_activities_guide ON public.guide_activities USING btree (guide_id);

CREATE INDEX idx_guide_activities_location ON public.guide_activities USING gist (location_geom);

CREATE INDEX idx_manual_slots_range ON public.manual_availability_slots USING btree (guide_activity_id, start_time);

CREATE UNIQUE INDEX manual_availability_slots_guide_activity_id_start_time_key ON public.manual_availability_slots USING btree (guide_activity_id, start_time);

CREATE UNIQUE INDEX manual_availability_slots_pkey ON public.manual_availability_slots USING btree (id);

alter table "public"."activity_subscribers" add constraint "activity_subscribers_pkey" PRIMARY KEY using index "activity_subscribers_pkey";

alter table "public"."bookings" add constraint "bookings_pkey" PRIMARY KEY using index "bookings_pkey";

alter table "public"."guide_activities" add constraint "guide_activities_pkey" PRIMARY KEY using index "guide_activities_pkey";

alter table "public"."manual_availability_slots" add constraint "manual_availability_slots_pkey" PRIMARY KEY using index "manual_availability_slots_pkey";

alter table "public"."activity_subscribers" add constraint "activity_subscribers_guide_activity_id_fkey" FOREIGN KEY (guide_activity_id) REFERENCES public.guide_activities(id) ON DELETE CASCADE not valid;

alter table "public"."activity_subscribers" validate constraint "activity_subscribers_guide_activity_id_fkey";

alter table "public"."activity_subscribers" add constraint "activity_subscribers_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."activity_subscribers" validate constraint "activity_subscribers_user_id_fkey";

alter table "public"."bookings" add constraint "bookings_guide_activity_id_fkey" FOREIGN KEY (guide_activity_id) REFERENCES public.guide_activities(id) not valid;

alter table "public"."bookings" validate constraint "bookings_guide_activity_id_fkey";

alter table "public"."bookings" add constraint "bookings_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."bookings" validate constraint "bookings_user_id_fkey";

alter table "public"."bookings" add constraint "bookings_user_id_guide_activity_id_slot_start_time_key" UNIQUE using index "bookings_user_id_guide_activity_id_slot_start_time_key";

alter table "public"."guide_activities" add constraint "check_recurrence_logic" CHECK ((((schedule_type = 'strict'::public.schedule_type) AND (recurrence_rule IS NOT NULL)) OR (schedule_type = 'flexible'::public.schedule_type))) not valid;

alter table "public"."guide_activities" validate constraint "check_recurrence_logic";

alter table "public"."guide_activities" add constraint "guide_activities_guide_id_fkey" FOREIGN KEY (guide_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."guide_activities" validate constraint "guide_activities_guide_id_fkey";

alter table "public"."manual_availability_slots" add constraint "manual_availability_slots_guide_activity_id_fkey" FOREIGN KEY (guide_activity_id) REFERENCES public.guide_activities(id) ON DELETE CASCADE not valid;

alter table "public"."manual_availability_slots" validate constraint "manual_availability_slots_guide_activity_id_fkey";

alter table "public"."manual_availability_slots" add constraint "manual_availability_slots_guide_activity_id_start_time_key" UNIQUE using index "manual_availability_slots_guide_activity_id_start_time_key";

grant delete on table "public"."activity_subscribers" to "anon";

grant insert on table "public"."activity_subscribers" to "anon";

grant references on table "public"."activity_subscribers" to "anon";

grant select on table "public"."activity_subscribers" to "anon";

grant trigger on table "public"."activity_subscribers" to "anon";

grant truncate on table "public"."activity_subscribers" to "anon";

grant update on table "public"."activity_subscribers" to "anon";

grant delete on table "public"."activity_subscribers" to "authenticated";

grant insert on table "public"."activity_subscribers" to "authenticated";

grant references on table "public"."activity_subscribers" to "authenticated";

grant select on table "public"."activity_subscribers" to "authenticated";

grant trigger on table "public"."activity_subscribers" to "authenticated";

grant truncate on table "public"."activity_subscribers" to "authenticated";

grant update on table "public"."activity_subscribers" to "authenticated";

grant delete on table "public"."activity_subscribers" to "service_role";

grant insert on table "public"."activity_subscribers" to "service_role";

grant references on table "public"."activity_subscribers" to "service_role";

grant select on table "public"."activity_subscribers" to "service_role";

grant trigger on table "public"."activity_subscribers" to "service_role";

grant truncate on table "public"."activity_subscribers" to "service_role";

grant update on table "public"."activity_subscribers" to "service_role";

grant delete on table "public"."bookings" to "anon";

grant insert on table "public"."bookings" to "anon";

grant references on table "public"."bookings" to "anon";

grant select on table "public"."bookings" to "anon";

grant trigger on table "public"."bookings" to "anon";

grant truncate on table "public"."bookings" to "anon";

grant update on table "public"."bookings" to "anon";

grant delete on table "public"."bookings" to "authenticated";

grant insert on table "public"."bookings" to "authenticated";

grant references on table "public"."bookings" to "authenticated";

grant select on table "public"."bookings" to "authenticated";

grant trigger on table "public"."bookings" to "authenticated";

grant truncate on table "public"."bookings" to "authenticated";

grant update on table "public"."bookings" to "authenticated";

grant delete on table "public"."bookings" to "service_role";

grant insert on table "public"."bookings" to "service_role";

grant references on table "public"."bookings" to "service_role";

grant select on table "public"."bookings" to "service_role";

grant trigger on table "public"."bookings" to "service_role";

grant truncate on table "public"."bookings" to "service_role";

grant update on table "public"."bookings" to "service_role";

grant delete on table "public"."guide_activities" to "anon";

grant insert on table "public"."guide_activities" to "anon";

grant references on table "public"."guide_activities" to "anon";

grant select on table "public"."guide_activities" to "anon";

grant trigger on table "public"."guide_activities" to "anon";

grant truncate on table "public"."guide_activities" to "anon";

grant update on table "public"."guide_activities" to "anon";

grant delete on table "public"."guide_activities" to "authenticated";

grant insert on table "public"."guide_activities" to "authenticated";

grant references on table "public"."guide_activities" to "authenticated";

grant select on table "public"."guide_activities" to "authenticated";

grant trigger on table "public"."guide_activities" to "authenticated";

grant truncate on table "public"."guide_activities" to "authenticated";

grant update on table "public"."guide_activities" to "authenticated";

grant delete on table "public"."guide_activities" to "service_role";

grant insert on table "public"."guide_activities" to "service_role";

grant references on table "public"."guide_activities" to "service_role";

grant select on table "public"."guide_activities" to "service_role";

grant trigger on table "public"."guide_activities" to "service_role";

grant truncate on table "public"."guide_activities" to "service_role";

grant update on table "public"."guide_activities" to "service_role";

grant delete on table "public"."manual_availability_slots" to "anon";

grant insert on table "public"."manual_availability_slots" to "anon";

grant references on table "public"."manual_availability_slots" to "anon";

grant select on table "public"."manual_availability_slots" to "anon";

grant trigger on table "public"."manual_availability_slots" to "anon";

grant truncate on table "public"."manual_availability_slots" to "anon";

grant update on table "public"."manual_availability_slots" to "anon";

grant delete on table "public"."manual_availability_slots" to "authenticated";

grant insert on table "public"."manual_availability_slots" to "authenticated";

grant references on table "public"."manual_availability_slots" to "authenticated";

grant select on table "public"."manual_availability_slots" to "authenticated";

grant trigger on table "public"."manual_availability_slots" to "authenticated";

grant truncate on table "public"."manual_availability_slots" to "authenticated";

grant update on table "public"."manual_availability_slots" to "authenticated";

grant delete on table "public"."manual_availability_slots" to "service_role";

grant insert on table "public"."manual_availability_slots" to "service_role";

grant references on table "public"."manual_availability_slots" to "service_role";

grant select on table "public"."manual_availability_slots" to "service_role";

grant trigger on table "public"."manual_availability_slots" to "service_role";

grant truncate on table "public"."manual_availability_slots" to "service_role";

grant update on table "public"."manual_availability_slots" to "service_role";


  create policy "Guides view subscribers"
  on "public"."activity_subscribers"
  as permissive
  for select
  to public
using ((EXISTS ( SELECT 1
   FROM public.guide_activities
  WHERE ((guide_activities.id = activity_subscribers.guide_activity_id) AND (guide_activities.guide_id = auth.uid())))));



  create policy "Users manage own subscriptions"
  on "public"."activity_subscribers"
  as permissive
  for all
  to public
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));



  create policy "Guides view activity bookings"
  on "public"."bookings"
  as permissive
  for select
  to public
using ((EXISTS ( SELECT 1
   FROM public.guide_activities
  WHERE ((guide_activities.id = bookings.guide_activity_id) AND (guide_activities.guide_id = auth.uid())))));



  create policy "Users create bookings"
  on "public"."bookings"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "Users view own bookings"
  on "public"."bookings"
  as permissive
  for select
  to public
using ((auth.uid() = user_id));



  create policy "Activities viewable by everyone"
  on "public"."guide_activities"
  as permissive
  for select
  to public
using (true);



  create policy "Guides manage own activities"
  on "public"."guide_activities"
  as permissive
  for all
  to public
using ((auth.uid() = guide_id))
with check ((auth.uid() = guide_id));



  create policy "Guides manage slots"
  on "public"."manual_availability_slots"
  as permissive
  for all
  to public
using ((EXISTS ( SELECT 1
   FROM public.guide_activities
  WHERE ((guide_activities.id = manual_availability_slots.guide_activity_id) AND (guide_activities.guide_id = auth.uid())))));



  create policy "Slots viewable by everyone"
  on "public"."manual_availability_slots"
  as permissive
  for select
  to public
using (true);



