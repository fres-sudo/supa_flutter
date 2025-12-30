-- ======================================================================================
-- EXTENSIONS required by local/declarative schemas
--
-- Note: `supabase db diff` builds a local/shadow DB. Extensions enabled in the Supabase
-- dashboard do NOT automatically exist in that local DB.
-- ======================================================================================

CREATE SCHEMA IF NOT EXISTS extensions;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA extensions;
