import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:pine/pine.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/users/models/app_user/app_user.dart';
import 'package:supa_flutter/core/enums/user_roles.dart';

class AppUserMapper extends Mapper<supabase.User, AppUser> {
  @override
  AppUser from(supabase.User from) => AppUser(
    id: from.id,
    email: from.email ?? '',
    name: from.userMetadata?['name'] as String? ?? '',
    role:
        UserRole.values.firstWhereOrNull(
          (role) => role.name == from.userMetadata?['role'],
        ) ??
        UserRole.member,
    image: from.userMetadata?['image'] as String? ?? '',
    createdAt: DateTime.tryParse(from.createdAt) ?? DateTime.now(),
  );

  @override
  supabase.User to(AppUser to) => throw UnimplementedError();
}
