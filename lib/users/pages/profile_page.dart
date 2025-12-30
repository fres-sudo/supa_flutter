import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hux/hux.dart';
import 'package:supa_flutter/auth/cubits/session/session_cubit.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/users/blocs/blocs.dart';
import 'package:supa_flutter/users/cubits/cubits.dart';
import 'package:supa_flutter/users/domain/domain.dart';
import 'package:supa_flutter/users/repositories/users_repository.dart';
import 'package:supa_flutter/users/services/requests/requests.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuideApplicationBloc(
        usersRepository: context.read<UsersRepository>(),
      ),
      child: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, sessionState) {
          final uid = switch (sessionState) {
            Authenticated(:final user) => user.id,
            _ => null,
          };

          return BlocListener<GuideApplicationBloc, GuideApplicationState>(
            listener: (context, state) => switch (state) {
              SuccessGuideApplicationState() => () {
                context.showHuxSnackbar(
                  message: 'Application submitted. Waiting for review.'
                      .hardcoded(),
                );
                // if (uid != null) context.profileCubit.load(uid: uid);
              }(),
              ErrorGuideApplicationState(:final message) =>
                context.showHuxSnackbar(message: message),
              _ => null,
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(switch (sessionState) {
                  Authenticated(:final user) => '${user.name} (${user.email})',
                  Unauthenticated() => "Login".hardcoded(),
                  _ => "Profile".hardcoded(),
                }),
                actions: [
                  IconButton(
                    onPressed: () => context.read<SessionCubit>().signOut(),
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              body: uid == null
                  ? Center(child: Text('Not signed in'.hardcoded()))
                  : BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) => switch (state) {
                        LoadingProfileState() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        ErrorProfileState(:final message) => Center(
                          child: Text(message),
                        ),
                        LoadedProfileState(:final user) => _ProfileBody(
                          user: user,
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                        ),
                        _ => const SizedBox.shrink(),
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({
    required this.user,
    required this.firstNameController,
    required this.lastNameController,
  });

  final UserEntity user;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  bool get _needsOnboarding =>
      (user.firstName == null || user.firstName!.isEmpty) ||
      (user.lastName == null || user.lastName!.isEmpty);

  @override
  Widget build(BuildContext context) {
    firstNameController.text = user.firstName ?? firstNameController.text;
    lastNameController.text = user.lastName ?? lastNameController.text;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Role: ${user.role.name}'.hardcoded(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          if (_needsOnboarding) ...[
            Text(
              'Complete your profile'.hardcoded(),
              style: Theme.of(context).textTheme.titleLarge?.bold,
            ),
            HuxInput(
              controller: firstNameController,
              hint: 'First name'.hardcoded(),
            ),
            HuxInput(
              controller: lastNameController,
              hint: 'Last name'.hardcoded(),
            ),
            HuxButton(
              onPressed: () => context.profileCubit.updateProfile(
                uid: user.id,
                data: UpdateProfileRequest(
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                ),
              ),
              isLoading: context.watchProfileCubit.state.isLoading,
              width: HuxButtonWidth.expand,
              child: Text('Save'.hardcoded()),
            ),
          ] else ...[
            Text(
              'Profile'.hardcoded(),
              style: Theme.of(context).textTheme.titleLarge?.bold,
            ),
            Text('${user.firstName ?? ''} ${user.lastName ?? ''}'.hardcoded()),
          ],
        ],
      ),
    );
  }
}
