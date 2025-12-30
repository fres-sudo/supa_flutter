import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hux/hux.dart';
import 'package:supa_flutter/auth/cubits/session/session_cubit.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/core/routes/app_router.gr.dart';
import 'package:supa_flutter/core/ui/widgets/session_avatar.dart';

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listener: (BuildContext context, SessionState state) => switch (state) {
        Unauthenticated() => context.router.replaceAll([const AuthRootRoute()]),
        _ => null,
      },
      child: AutoTabsRouter(
        homeIndex: 0,
        routes: const [ExploreRoute(), ProfileRoute()],
        builder: (context, child) => Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            type: .fixed,
            landscapeLayout: .linear,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(LucideIcons.search),
                label: 'Explore'.hardcoded(),
              ),
              BottomNavigationBarItem(
                icon: const SessionAvatar(size: HuxAvatarSize.small),
                label: 'Profile'.hardcoded(),
              ),
            ],
            currentIndex: context.tabsRouter.activeIndex,
            onTap: (index) => context.tabsRouter.setActiveIndex(index),
          ),
        ),
      ),
    );
  }
}
