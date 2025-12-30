import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hux/hux.dart';
import 'package:supa_flutter/auth/cubits/cubits.dart';
import 'package:supa_flutter/core/misc/extensions.dart';

class SessionAvatar extends StatelessWidget {
  const SessionAvatar({super.key, this.size = HuxAvatarSize.medium});

  final HuxAvatarSize size;

  @override
  Widget build(BuildContext context) {
    final iconPerson = Icon(Icons.person, size: size.toIconSizePx);
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) => switch (state) {
        Authenticated(:final user) => user.image != null
            ? HuxAvatar(imageUrl: user.image, size: size)
            : iconPerson,
        _ => iconPerson,
      },
    );
  }
}
