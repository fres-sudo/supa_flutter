-- Self Insert: Users can create their own profile row (needed for first sign-in upserts)
CREATE POLICY "Users can insert own profile"
ON public.users FOR INSERT WITH CHECK (auth.uid() = id);

-- Optional but explicit: ensure updated rows still belong to the user
CREATE POLICY "Users can update own profile (check)"
ON public.users FOR UPDATE WITH CHECK (auth.uid() = id);
