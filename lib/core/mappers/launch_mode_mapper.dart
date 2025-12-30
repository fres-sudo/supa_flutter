import 'package:supa_flutter/core/enums/launch_mode.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:supa_flutter/core/misc/enum_mapper.dart';

class LaunchModeMapper extends EnumMapper<LaunchMode, url_launcher.LaunchMode> {
  LaunchModeMapper()
    : super({
        LaunchMode.externalApplication:
            url_launcher.LaunchMode.externalApplication,
        LaunchMode.externalNonBrowserApplication:
            url_launcher.LaunchMode.externalNonBrowserApplication,
        LaunchMode.inAppWebView: url_launcher.LaunchMode.inAppWebView,
        LaunchMode.platformDefault: url_launcher.LaunchMode.platformDefault,
      });
}
