import 'package:supa_flutter/core/misc/result.dart';
import 'package:supa_flutter/core/services/supabase/supabase_service.dart';
import 'package:supa_flutter/users/dtos/dtos.dart';
import 'package:supa_flutter/users/services/requests/requests.dart';

abstract class UsersService {
  Future<Result<UserProfileDto>> getProfile(String uid);
  Future<Result<UserProfileDto>> getCurrentProfile();
  Future<Result<UserProfileDto>> updateProfile(
    String uid,
    UpdateProfileRequest data,
  );
}

class UsersServiceImpl extends SupabaseService implements UsersService {
  const UsersServiceImpl({super.logger, super.supabase});

  @override
  Future<Result<UserProfileDto>> getProfile(String uid) =>
      safe('[UsersService] getProfile', () async {
        final json = await client.from('users').select().eq('id', uid).single();
        return UserProfileDto.fromJson(json);
      });

  @override
  Future<Result<UserProfileDto>> updateProfile(
    String uid,
    UpdateProfileRequest data,
  ) => safe('[UsersService] updateProfile', () async {
    final json = await client
        .from('users')
        .update(data.toJson())
        .eq('id', uid)
        .select()
        .single();
    return UserProfileDto.fromJson(json);
  });

  @override
  Future<Result<UserProfileDto>> getCurrentProfile() =>
      safeAuthenticated("getCurrentProfile", (user) async {
        final json = await client
            .from('users')
            .select()
            .eq('id', user.id)
            .single();
        return UserProfileDto.fromJson(json);
      });
}
