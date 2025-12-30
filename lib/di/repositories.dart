part of 'dependency_injector.dart';

final List<RepositoryProvider<dynamic>> _repositories = [
  RepositoryProvider<VersionCheckerRepository>(
    create: (context) => VersionCheckerRepositoryImpl(
      versionCheckerService: context.read<VersionCheckerService>(),
    ),
  ),
  RepositoryProvider<UrlLauncherRepository>(
    create: (context) => UrlLauncherRepositoryImpl(
      urlLauncherService: context.read<UrlLauncherService>(),
    ),
  ),
  RepositoryProvider<AuthRepository>(
    create: (context) => AuthRepositoryImpl(
      authService: context.read<AuthService>(),
      logger: context.read<Talker>(),
      appUserMapper: context.read<Mapper<supabase.User, AppUser>>(),
      notificationService: context.read<NotificationService>(),
      userService: context.read<UsersService>(),
    ),
  ),
  RepositoryProvider<UsersRepository>(
    create: (context) => UsersRepositoryImpl(
      usersService: context.read<UsersService>(),
      logger: context.read<Talker>(),
      userEntityMapper: context.read<Mapper<UserProfileDto, UserEntity>>(),
      guideCertificationEntityMapper: context
          .read<Mapper<GuideCertificationDto, GuideCertificationEntity>>(),
    ),
  ),
  RepositoryProvider<ConfigRepository>(
      create: (context) => ConfigRepositoryImpl(
          logger: context.read<Talker>(),
          service: context.read<ConfigService>()))
];
