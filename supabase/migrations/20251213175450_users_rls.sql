
  create policy "Users can insert own profile"
  on "public"."users"
  as permissive
  for insert
  to public
with check ((auth.uid() = id));



  create policy "Users can update own profile (check)"
  on "public"."users"
  as permissive
  for update
  to public
with check ((auth.uid() = id));



