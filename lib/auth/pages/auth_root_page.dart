import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hux/hux.dart';
import 'package:svg_flutter/svg.dart';
import 'package:supa_flutter/auth/blocs/sign_in/sign_in_bloc.dart';
import 'package:supa_flutter/core/enums/social_provider.dart';
import 'package:supa_flutter/core/gen/assets.gen.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/core/routes/app_router.gr.dart';
import 'package:supa_flutter/core/ui/device.dart';

@RoutePage()
class AuthRootPage extends StatefulWidget {
  const AuthRootPage({super.key});

  @override
  State<AuthRootPage> createState() => _AuthRootPageState();
}

class _AuthRootPageState extends State<AuthRootPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) => switch (state) {
        ErrorSignInState(:final message) => context.showHuxSnackbar(
          message: message,
          variant: HuxSnackbarVariant.error,
        ),
        SuccessEmailSignInState() => context.router.replaceAll([
          const RootRoute(),
        ]),
        SuccessSocialSignInState() => context.router.replaceAll([
          const RootRoute(),
        ]),
        _ => null,
      },
      builder: (context, state) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.edgeInsetsPhone,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            spacing: 16,
            children: [
              Text(
                "Continue with email".hardcoded(),
                style: Theme.of(context).textTheme.titleLarge?.bold,
              ),
              HuxInput(
                controller: _emailController,
                hint: 'Enter your email',
                prefixIcon: Icon(LucideIcons.mail),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required'.hardcoded();
                  }
                },
              ),
              HuxButton(
                onPressed: () => context.read<SignInBloc>().email(
                  email: _emailController.text,
                ),
                isLoading: state is LoadingEmailSignInState,
                width: HuxButtonWidth.expand,
                child: Text('Sign in'.hardcoded()),
              ),
              Row(
                spacing: Sizes.xl,
                children: [
                  Expanded(child: Divider()),
                  Text('or'.hardcoded()),
                  Expanded(child: Divider()),
                ],
              ),
              HuxButton(
                onPressed: () => context.read<SignInBloc>().social(
                  provider: SocialProvider.google,
                ),
                width: HuxButtonWidth.expand,
                variant: HuxButtonVariant.outline,
                isLoading: state is LoadingGoogleSignInState,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: Sizes.sm,
                  children: [
                    SvgPicture.asset(
                      Assets.brandIcons.googleLogo.path,
                      width: 20,
                      height: 20,
                    ),
                    Text('Continue with Google'.hardcoded()),
                  ],
                ),
              ),
              HuxButton(
                onPressed: () {},
                width: HuxButtonWidth.expand,
                variant: HuxButtonVariant.outline,
                isLoading: state is LoadingAppleSignInState,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: Sizes.sm,
                  children: [
                    SvgPicture.asset(
                      context.isDarkMode
                          ? Assets.brandIcons.appleDark.path
                          : Assets.brandIcons.appleLight.path,
                      width: 20,
                      height: 20,
                    ),
                    Text('Continue with Apple'.hardcoded()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
