-- ======================================================================================
-- 1. USERS AND PROFILES (Linked to auth.users)
-- ======================================================================================

CREATE TABLE public.users (
    -- Primary key must reference the Supabase authentication user ID
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    role public.user_role NOT NULL DEFAULT 'member',

    -- Profile Data
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    bio TEXT,
    avatar_url TEXT,

    fcm_token TEXT,
    language TEXT NOT NULL DEFAULT 'en',
    timezone TEXT NOT NULL DEFAULT 'UTC',
    -- Geospatial Data (for "Nearby Friends" feature)
    location extensions.geography,
    liked_sports TEXT[],

    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    deleted_at TIMESTAMPTZ -- Soft Delete
);

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for users
-- 1. Public Profiles: Anyone can view basic profile info
CREATE POLICY "Public profiles are viewable by everyone"
ON public.users FOR SELECT USING (true);

-- 2. Self Update: Users can update their own profile
CREATE POLICY "Users can update own profile"
ON public.users FOR UPDATE USING (auth.uid() = id);


-- GUIDE CERTIFICATIONS
CREATE TABLE public.guide_certifications (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    document_url TEXT NOT NULL,
    status public.certification_status NOT NULL DEFAULT 'pending',
    rejection_reason TEXT,
    reviewed_by UUID REFERENCES public.users(id),
    reviewed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.guide_certifications ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for certifications
-- 1. Read: User sees their own. Admins would need an additional policy.
CREATE POLICY "Users view own certs" ON public.guide_certifications
FOR SELECT USING (auth.uid() = user_id);

-- 2. Create/Update: Users manage their own certification status/documents
CREATE POLICY "Users manage own certs" ON public.guide_certifications
FOR ALL USING (auth.uid() = user_id);
