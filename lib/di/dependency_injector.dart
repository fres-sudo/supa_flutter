import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:supa_flutter/core/blocs/url_launcher/url_launcher_bloc.dart';
import 'package:supa_flutter/core/blocs/version_checker/version_checker_bloc.dart';
import 'package:supa_flutter/core/mappers/launch_mode_mapper.dart';
import 'package:supa_flutter/core/repositories/url_launcher_repository.dart';
import 'package:supa_flutter/core/repositories/version_checker_repository.dart';
import 'package:supa_flutter/core/services/url_launcher/url_launcher_service.dart';
import 'package:supa_flutter/core/services/version_checker/version_checker_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:talker/talker.dart';
import 'package:supa_flutter/auth/blocs/sign_in/sign_in_bloc.dart';
import 'package:supa_flutter/auth/cubits/session/session_cubit.dart';
import 'package:supa_flutter/auth/mappers/user_dto_mapper.dart';
import 'package:supa_flutter/auth/repositories/auth_repository.dart';
import 'package:supa_flutter/auth/services/auth_service.dart';
import 'package:supa_flutter/core/cubits/cubits.dart';
import 'package:supa_flutter/core/services/persistence/persistence_service.dart';
import 'package:supa_flutter/core/repositories/config_repository.dart';
import 'package:supa_flutter/core/services/config/config_service.dart';
import 'package:supa_flutter/notification/services/notification_service.dart';
import 'package:supa_flutter/users/models/app_user/app_user.dart';
import 'package:supa_flutter/users/cubits/cubits.dart';
import 'package:supa_flutter/users/dtos/dtos.dart';
import 'package:supa_flutter/users/domain/domain.dart';
import 'package:supa_flutter/users/mappers/mappers.dart';
import 'package:supa_flutter/users/repositories/repositories.dart';
import 'package:supa_flutter/users/services/services.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

part 'blocs.dart';
part 'mappers.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  const DependencyInjector({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
    blocs: _blocs,
    mappers: _mappers,
    providers: _providers,
    repositories: _repositories,
    child: child,
  );
}
