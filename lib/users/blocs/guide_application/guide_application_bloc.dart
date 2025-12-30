import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supa_flutter/core/misc/result.dart';
import 'package:supa_flutter/users/domain/guide_certification_entity.dart';
import 'package:supa_flutter/users/repositories/users_repository.dart';

part 'guide_application_event.dart';
part 'guide_application_state.dart';
part 'guide_application_state_utils.dart';

part 'guide_application_bloc.freezed.dart';

class GuideApplicationBloc
    extends Bloc<GuideApplicationEvent, GuideApplicationState> {
  GuideApplicationBloc({required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(const GuideApplicationState.initial()) {
    on<ApplyGuideApplicationEvent>(_onApply);
  }

  final UsersRepository _usersRepository;

  void apply({required String uid, required File file}) =>
      add(GuideApplicationEvent.apply(uid: uid, file: file));

  FutureOr<void> _onApply(
    ApplyGuideApplicationEvent event,
    Emitter<GuideApplicationState> emit,
  ) async {
    emit(const GuideApplicationState.loading());
    (await _usersRepository.applyToBecomeGuide(event.uid, event.file)).when(
      success: (cert) =>
          emit(GuideApplicationState.success(certification: cert)),
      error: (error) => emit(GuideApplicationState.error(error.toString())),
    );
  }
}

extension GuideApplicationBlocExtension on BuildContext {
  GuideApplicationBloc get guideApplicationBloc => read<GuideApplicationBloc>();
  GuideApplicationBloc get watchGuideApplicationBloc =>
      watch<GuideApplicationBloc>();
}
