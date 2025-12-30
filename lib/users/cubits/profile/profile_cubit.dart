import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supa_flutter/auth/cubits/session/session_cubit.dart';
import 'package:supa_flutter/core/misc/result.dart';
import 'package:supa_flutter/users/domain/user_entity.dart';
import 'package:supa_flutter/users/repositories/users_repository.dart';
import 'package:supa_flutter/users/services/requests/requests.dart';

part 'profile_state.dart';
part 'profile_state_utils.dart';

part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required UsersRepository usersRepository,
    required SessionCubit sessionCubit,
  })  : _usersRepository = usersRepository,
        _sessionCubit = sessionCubit,
        super(const ProfileState.initial()) {
    _sessionSubscription = _sessionCubit.stream.listen((sessionState) {
      final uid = switch (sessionState) {
        Authenticated(:final user) => user.id,
        _ => null,
      };
      if (uid == null) {
        emit(const ProfileState.initial());
      } else {
        load(uid: uid);
      }
    });

    // Load immediately if already authenticated.
    final uid = switch (_sessionCubit.state) {
      Authenticated(:final user) => user.id,
      _ => null,
    };
    if (uid != null) load(uid: uid);
  }

  final UsersRepository _usersRepository;
  final SessionCubit _sessionCubit;
  late final StreamSubscription<SessionState> _sessionSubscription;

  FutureOr<void> load({required String uid}) async {
    emit(const ProfileState.loading());
    (await _usersRepository.getProfile(uid)).when(
      success: (user) => emit(ProfileState.loaded(user: user)),
      error: (error) => emit(ProfileState.error(error.toString())),
    );
  }

  FutureOr<void> updateProfile({
    required String uid,
    required UpdateProfileRequest data,
  }) async {
    emit(const ProfileState.loading());
    (await _usersRepository.updateProfile(uid, data)).when(
      success: (user) => emit(ProfileState.loaded(user: user)),
      error: (error) => emit(ProfileState.error(error.toString())),
    );
  }

  @override
  Future<void> close() {
    _sessionSubscription.cancel();
    return super.close();
  }
}

extension ProfileCubitExtension on BuildContext {
  ProfileCubit get profileCubit => read<ProfileCubit>();
  ProfileCubit get watchProfileCubit => watch<ProfileCubit>();
}
