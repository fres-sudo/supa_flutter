-- ======================================================================================
-- 4. BOOKINGS (Transactions)
-- ======================================================================================

CREATE TABLE public.bookings (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id),
    guide_activity_id UUID NOT NULL REFERENCES public.guide_activities(id),
    slot_start_time TIMESTAMPTZ NOT NULL, -- The specific date/time booked

    status public.booking_status NOT NULL DEFAULT 'pending',

    price_paid_cents INT NOT NULL,
    stripe_payment_intent_id VARCHAR(255),

    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),

    -- Prevent double booking the same slot
    UNIQUE(user_id, guide_activity_id, slot_start_time)
);

ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

-- RLS POLICIES for bookings
-- 1. Users can see their own bookings
CREATE POLICY "Users view own bookings" ON public.bookings
FOR SELECT USING (auth.uid() = user_id);

-- 2. Guides can see bookings for THEIR activities
CREATE POLICY "Guides view activity bookings" ON public.bookings
FOR SELECT USING (EXISTS (
    SELECT 1 FROM public.guide_activities
    WHERE id = bookings.guide_activity_id AND guide_id = auth.uid()
));

-- 3. Users can create bookings (Payment logic handles the rest)
CREATE POLICY "Users create bookings" ON public.bookings
FOR INSERT WITH CHECK (auth.uid() = user_id);


-- INDEXES
CREATE INDEX idx_bookings_user ON public.bookings(user_id);
CREATE INDEX idx_bookings_activity ON public.bookings(guide_activity_id, slot_start_time);
