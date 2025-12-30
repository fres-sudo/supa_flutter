part of 'dependency_injector.dart';

final List<SingleChildWidget> _mappers = [
  Provider<LaunchModeMapper>(create: (context) => LaunchModeMapper()),
  Provider<Mapper<supabase.User, AppUser>>(
      create: (context) => AppUserMapper()),
  Provider<Mapper<UserProfileDto, UserEntity>>(
    create: (context) => UserEntityMapper(),
  ),
  Provider<Mapper<GuideCertificationDto, GuideCertificationEntity>>(
    create: (context) => GuideCertificationEntityMapper(),
  ),
];
