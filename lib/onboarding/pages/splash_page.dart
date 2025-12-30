import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hux/hux.dart';
import 'package:supa_flutter/auth/cubits/session/session_cubit.dart';
import 'package:supa_flutter/core/cubits/cubits.dart';
import 'package:supa_flutter/core/gen/assets.gen.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/core/routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // context.read<ConfigCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listener: (BuildContext context, SessionState state) => switch (state) {
        // Authenticated() => context.router.replaceAll([const RootRoute()]),
        // Unauthenticated() => context.router.replaceAll([const AuthRootRoute()]),
        _ => null,
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            spacing: 16,
            children: [
              Assets.images.climbing.image(),
              HuxButton(
                onPressed: () => context.router.push(const AuthRootRoute()),
                child: Text('Continue'.hardcoded()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
