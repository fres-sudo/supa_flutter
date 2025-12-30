part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<ThemeCubit>(
    create: (context) =>
        ThemeCubit(persistenceService: context.read<PersistenceService>())
          ..load(),
  ),
  BlocProvider<VersionCheckerBloc>(
    create: (context) => VersionCheckerBloc(
        versionCheckerRepository: context.read<VersionCheckerRepository>()),
  ),
  BlocProvider<UrlLauncherBloc>(
    create: (context) => UrlLauncherBloc(
        urlLauncherRepository: context.read<UrlLauncherRepository>()),
  ),
  BlocProvider<SessionCubit>(
    create: (context) => SessionCubit(context.read<AuthRepository>()),
  ),
  BlocProvider<ProfileCubit>(
    create: (context) => ProfileCubit(
      usersRepository: context.read<UsersRepository>(),
      sessionCubit: context.read<SessionCubit>(),
    ),
  ),
  BlocProvider<SignInBloc>(
    create: (context) => SignInBloc(context.read<AuthRepository>()),
  ),
  BlocProvider<ExploreTypeCubit>(
    create: (context) => ExploreTypeCubit(),
  ),
  BlocProvider<ConfigCubit>(
    create: (context) =>
        ConfigCubit(configRepository: context.read<ConfigRepository>()),
  ),
];
