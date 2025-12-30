import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker/talker.dart';
import 'package:supa_flutter/core/exceptions/repository_exception.dart';
import 'package:supa_flutter/core/misc/result.dart';

/// Base abstraction for services that interact with Supabase.
///
/// Mirrors the logging/error-reporting conventions used by `misc/repository.dart`:
/// - logs via Talker (if provided)
/// - reports exceptions to Sentry
/// - returns a `Result.error(RepositoryException)` to keep higher layers consistent
abstract class SupabaseService {
  const SupabaseService({SupabaseClient? supabase, this.logger})
    : _supabase = supabase;

  final SupabaseClient? _supabase;
  final Talker? logger;

  /// Supabase client instance. Defaults to the globally initialized client.
  SupabaseClient get client => _supabase ?? Supabase.instance.client;

  /// Shortcut to the auth client.
  GoTrueClient get auth => client.auth;

  /// Shortcut to current user (if signed in).
  User? get currentUser => auth.currentUser;

  /// Wraps Supabase calls to standardize logging + reporting.
  ///
  /// - [operation] should be a short identifier like `"get_profile"` or
  ///   `"[UsersService] fetchCurrentUser"`.
  Future<Result<T>> safe<T>(
    String operation,
    Future<T> Function() block,
  ) async {
    try {
      logger?.debug('[SupabaseService] $operation');
      final value = await block();
      logger?.debug(
        '[SupabaseService] $operation success: ${_safeToString(value)}',
      );
      return Result.ok(value);
    } catch (error, stack) {
      logger?.handle(error, stack, '[SupabaseService] $operation');
      return Result.error(_wrapError(error, stack));
    }
  }

  Future<Result<T>> safeAuthenticated<T>(
    String operation,
    Future<T> Function(User user) block,
  ) async {
    if (currentUser == null) {
      return Result.error(
        AuthException("User not authenticated", statusCode: "401"),
      );
    }
    try {
      logger?.debug('[SupabaseService] $operation');
      final value = await block(currentUser!);
      logger?.debug(
        '[SupabaseService] $operation success: ${_safeToString(value)}',
      );
      return Result.ok(value);
    } catch (error, stack) {
      logger?.handle(error, stack, '[SupabaseService] $operation');
      return Result.error(_wrapError(error, stack));
    }
  }

  /// Like [safe], but for code that already returns `Result<T>`.
  ///
  /// Useful when composing multiple `Result`-returning helpers without unwrapping.
  Future<Result<T>> safeResult<T>(
    String operation,
    Future<Result<T>> Function() block,
  ) async {
    try {
      logger?.debug('[SupabaseService] $operation');
      final result = await block();
      logger?.debug(
        '[SupabaseService] $operation result: ${_safeToString(result)}',
      );
      return result;
    } catch (error, stack) {
      try {
        logger?.handle(error, stack, '[SupabaseService] $operation');
      } catch (_) {
        // ignore logging failures
      }
      return Result.error(_wrapError(error, stack));
    }
  }

  static String _safeToString(Object? value) {
    try {
      return value.toString();
    } catch (e) {
      return '<unprintable ${value.runtimeType}: $e>';
    }
  }

  static Exception _wrapError(Object error, StackTrace stack) {
    if (error is Exception) return error;
    // Dart `Error`s (like JsonUnsupportedObjectError) are not `Exception`s,
    // but our Result type expects an `Exception`, so wrap them.
    final message = _safeToString(error);
    return Exception(message);
  }
}
