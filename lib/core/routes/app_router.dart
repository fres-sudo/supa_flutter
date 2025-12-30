import 'package:auto_route/auto_route.dart';
import 'package:supa_flutter/core/services/persistence/persistence_service.dart';
import 'package:supa_flutter/core/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({required this.persistenceService}) : super();

  final PersistenceService persistenceService;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: AuthRootRoute.page),
    AutoRoute(page: VerifyOtpRoute.page),
    AutoRoute(
      page: RootRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
  ];
}
