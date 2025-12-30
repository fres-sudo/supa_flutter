import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hux/hux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supa_flutter/core/cubits/cubits.dart';
import 'package:supa_flutter/core/i18n/strings.g.dart';
import 'package:supa_flutter/core/services/persistence/persistence_service.dart';
import 'package:supa_flutter/core/routes/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supa_flutter/di/dependency_injector.dart';
import 'package:supa_flutter/firebase_options.dart';

void main() async {
  await runZonedGuarded(
    () async {
      final binding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: binding);

      LocaleSettings.useDeviceLocale();

      PersistenceServiceImpl.instance = await SharedPreferences.getInstance();

      await Supabase.initialize(
        url: const String.fromEnvironment("SUPABASE_URL"),
        anonKey: const String.fromEnvironment("SUPABASE_ANONKEY"),
      );

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (!kDebugMode) {
        await SentryFlutter.init(
          (options) => options
            ..dsn = const String.fromEnvironment("SENTRY_DSN")
            ..tracesSampleRate = 0.25,
        );
      }

      FlutterNativeSplash.remove();
      runApp(TranslationProvider(child: SupaFlutterApp()));
    },
    (error, stackTrace) async {
      await Sentry.captureException(error, stackTrace: stackTrace);
      log('[ZonedGuarded] $error$stackTrace');
    },
  );
}

class SupaFlutterApp extends StatefulWidget {
  const SupaFlutterApp({super.key});

  @override
  State<SupaFlutterApp> createState() => _SupaFlutterAppState();
}

class _SupaFlutterAppState extends State<SupaFlutterApp> {
  AppRouter? _router;

  @override
  Widget build(BuildContext context) {
    return DependencyInjector(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          _router ??= AppRouter(persistenceService: context.read());
          final themeMode = switch (state) {
            SettedThemeState() => state.mode,
            _ => ThemeMode.system,
          };

          return MaterialApp.router(
            title: "SupaFlutter",
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: HuxTheme.lightTheme,
            darkTheme: HuxTheme.darkTheme,
            routerDelegate: _router?.delegate(),
            routeInformationParser: _router?.defaultRouteParser(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
          );
        },
      ),
    );
  }
}
