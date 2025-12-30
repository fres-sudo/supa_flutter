import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/responses/sign_in_social/sign_in_social_response.dart';

extension SignInSocialResponseFixture on SignInSocialResponse {
  static SignInSocialResponseFixtureFactory factory() => SignInSocialResponseFixtureFactory();
}

class SignInSocialResponseFixtureFactory extends JsonFixtureFactory<SignInSocialResponse> {
  @override
  FixtureDefinition<SignInSocialResponse> definition() => define(
        (faker) => const SignInSocialResponse(),
  );

  @override
  JsonFixtureDefinition<SignInSocialResponse> jsonDefinition() => defineJson(
      (object) => {},
  );
}
