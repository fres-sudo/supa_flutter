part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<Talker>(create: (_) => Talker()),
  Provider<VersionCheckerService>(create: (_) => VersionCheckerServiceImpl()),
  Provider<UrlLauncherService>(
      create: (context) => UrlLauncherServiceImpl(
            launchModeMapper: context.read<LaunchModeMapper>(),
          )),
  Provider<PersistenceService>(create: (_) => PersistenceServiceImpl()),
  Provider<FlutterSecureStorage>(
    create: (_) => const FlutterSecureStorage(),
  ),
  // Provider<Dio>(
  //   create: (context) {
  //     final dio = Dio(BaseOptions(contentType: 'application/json'));
  //     final interceptor = AuthInterceptor(
  //       context.read<TokenStorage>(),
  //       context.read<Talker>(),
  //     );
  //     final talkerDioLogger = TalkerDioLogger(
  //         settings: TalkerDioLoggerSettings(
  //       printRequestHeaders: true,
  //       printResponseHeaders: true,
  //       printResponseData: true,
  //     ));
  //     interceptor.dio = dio;
  //     dio.interceptors.addAll([interceptor, talkerDioLogger]);
  //     return dio;
  //   },
  // ),
  Provider<AuthService>(create: (context) => AuthServiceImpl()),
  Provider<UsersService>(
    create: (context) => UsersServiceImpl(logger: context.read<Talker>()),
  ),
  Provider<ConfigService>(create: (context) => ConfigServiceImpl()),
  Provider<NotificationService>(create: (context) => NotificationServiceImpl()),
];
