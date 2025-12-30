import 'package:supabase_flutter/supabase_flutter.dart';

enum SocialProvider {
  google,
  apple;

  String get label => switch (this) {
        SocialProvider.google => 'Google',
        SocialProvider.apple => 'Apple',
      };
}

extension SocialProviderExtension on SocialProvider {
  OAuthProvider get oauthProvider {
    switch (this) {
      case SocialProvider.google:
        return OAuthProvider.google;
      case SocialProvider.apple:
        return OAuthProvider.apple;
    }
  }
}
