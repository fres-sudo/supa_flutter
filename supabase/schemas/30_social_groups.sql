-- ======================================================================================
-- 2. SOCIAL GROUPS (User-Generated, Free)
-- ======================================================================================

CREATE TABLE public.groups (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    creator_id UUID NOT NULL REFERENCES public.users(id),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    sport_type VARCHAR(50) NOT NULL,
    start_time TIMESTAMPTZ NOT NULL,
    max_participants INT,
    is_private BOOLEAN DEFAULT FALSE,
    location_geom extensions.geography(POINT, 4326) NOT NULL,
    location_name TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

ALTER TABLE public.groups ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for groups
CREATE POLICY "Groups are viewable by everyone"
ON public.groups FOR SELECT USING (true);

CREATE POLICY "Authenticated users can create groups"
ON public.groups FOR INSERT WITH CHECK (auth.uid() = creator_id);

CREATE POLICY "Creators can manage their groups"
ON public.groups FOR UPDATE USING (auth.uid() = creator_id);


-- ROUTE PLANS
CREATE TABLE public.group_plans (
    group_id UUID PRIMARY KEY REFERENCES public.groups(id) ON DELETE CASCADE,
    route_geom extensions.geography(LINESTRING, 4326),
    distance_meters INT,
    elevation_gain_meters INT,
    estimated_duration_minutes INT,
    file_url TEXT
);

ALTER TABLE public.group_plans ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for group_plans
-- Plans viewable by everyone, access to CRUD is checked against the parent group creator
CREATE POLICY "Plans viewable by everyone" ON public.group_plans FOR SELECT USING (true);
CREATE POLICY "Group creators manage plans" ON public.group_plans FOR ALL
USING (EXISTS (SELECT 1 FROM public.groups WHERE id = group_plans.group_id AND creator_id = auth.uid()));


-- GROUP MEMBERS
CREATE TABLE public.group_members (
    group_id UUID NOT NULL REFERENCES public.groups(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'joined',
    joined_at TIMESTAMPTZ DEFAULT now(),
    PRIMARY KEY (group_id, user_id)
);

ALTER TABLE public.group_members ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for group_members
CREATE POLICY "Members viewable by everyone" ON public.group_members FOR SELECT USING (true);
CREATE POLICY "Users can join groups" ON public.group_members FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can leave groups" ON public.group_members FOR DELETE USING (auth.uid() = user_id);


-- INDEXES
CREATE INDEX idx_groups_location ON public.groups USING GIST (location_geom);
CREATE INDEX idx_groups_creator ON public.groups(creator_id);
CREATE INDEX idx_group_members_user ON public.group_members(user_id);
