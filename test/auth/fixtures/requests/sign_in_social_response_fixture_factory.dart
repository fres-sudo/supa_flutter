import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/requests/sign_in_social/sign_in_social_request.dart';

extension SignInSocialRequestFixture on SignInSocialRequest {
  static SignInSocialRequestFixtureFactory factory() => SignInSocialRequestFixtureFactory();
}

class SignInSocialRequestFixtureFactory extends JsonFixtureFactory<SignInSocialRequest> {
  @override
  FixtureDefinition<SignInSocialRequest> definition() => define(
        (faker) => const SignInSocialRequest(),
  );

  @override
  JsonFixtureDefinition<SignInSocialRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
