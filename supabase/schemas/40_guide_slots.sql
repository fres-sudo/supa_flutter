-- ======================================================================================
-- 3. GUIDE BUSINESS (Hybrid Scheduling)
-- ======================================================================================

-- The "Template" for a service (e.g., "Monday Ski Class" or "Monthly Expedition")
CREATE TABLE public.guide_activities (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    guide_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price_cents INT NOT NULL DEFAULT 0,
    currency CHAR(3) DEFAULT 'USD',
    duration_minutes INT NOT NULL,
    max_slots_per_session INT NOT NULL,
    location_geom GEOGRAPHY(POINT, 4326),
    location_name TEXT,

    -- Hybrid Logic
    schedule_type public.schedule_type NOT NULL DEFAULT 'strict',
    recurrence_rule TEXT,
    frequency_label VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMPTZ DEFAULT now(),
    deleted_at TIMESTAMPTZ,

    CONSTRAINT check_recurrence_logic CHECK (
        (schedule_type = 'strict' AND recurrence_rule IS NOT NULL) OR
        (schedule_type = 'flexible')
    )
);

ALTER TABLE public.guide_activities ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for activities
CREATE POLICY "Activities viewable by everyone" ON public.guide_activities FOR SELECT USING (true);

-- Guides manage own activities
CREATE POLICY "Guides manage own activities"
ON public.guide_activities FOR ALL
USING (auth.uid() = guide_id) WITH CHECK (auth.uid() = guide_id);


-- MANUAL SLOTS (For Flexible/Hybrid schedules)
CREATE TABLE public.manual_availability_slots (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    guide_activity_id UUID NOT NULL REFERENCES public.guide_activities(id) ON DELETE CASCADE,
    start_time TIMESTAMPTZ NOT NULL,
    override_max_slots INT,
    created_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(guide_activity_id, start_time)
);

ALTER TABLE public.manual_availability_slots ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for slots
CREATE POLICY "Slots viewable by everyone" ON public.manual_availability_slots FOR SELECT USING (true);
CREATE POLICY "Guides manage slots" ON public.manual_availability_slots FOR ALL
USING (EXISTS (SELECT 1 FROM public.guide_activities WHERE id = guide_activity_id AND guide_id = auth.uid()));


-- SUBSCRIBERS (Waitlist for Flexible schedules)
CREATE TABLE public.activity_subscribers (
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    guide_activity_id UUID NOT NULL REFERENCES public.guide_activities(id) ON DELETE CASCADE,
    subscribed_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (user_id, guide_activity_id)
);

ALTER TABLE public.activity_subscribers ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for subscribers
CREATE POLICY "Users manage own subscriptions" ON public.activity_subscribers
FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- Guide can see who subscribes to THEIR activity
CREATE POLICY "Guides view subscribers" ON public.activity_subscribers
FOR SELECT USING (EXISTS (SELECT 1 FROM public.guide_activities WHERE id = guide_activity_id AND guide_id = auth.uid()));


-- INDEXES
CREATE INDEX idx_guide_activities_location ON public.guide_activities USING GIST (location_geom);
CREATE INDEX idx_guide_activities_guide ON public.guide_activities(guide_id);
CREATE INDEX idx_manual_slots_range ON public.manual_availability_slots(guide_activity_id, start_time);
