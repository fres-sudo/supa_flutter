-- ======================================================================================
-- ENUMS
-- ======================================================================================

-- Custom Types (ENUMs)
CREATE TYPE public.user_role AS ENUM ('member', 'guide', 'brand', 'admin');
CREATE TYPE public.certification_status AS ENUM ('pending', 'approved', 'rejected');
CREATE TYPE public.schedule_type AS ENUM ('strict', 'flexible');
CREATE TYPE public.booking_status AS ENUM ('pending', 'confirmed', 'cancelled', 'completed');
CREATE TYPE public.conversation_type AS ENUM ('group', 'guide_activity', 'direct');
