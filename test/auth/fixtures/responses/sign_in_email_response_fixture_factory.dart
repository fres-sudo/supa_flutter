import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/responses/sign_in_email/sign_in_email_response.dart';

extension SignInEmailResponseFixture on SignInEmailResponse {
  static SignInEmailResponseFixtureFactory factory() => SignInEmailResponseFixtureFactory();
}

class SignInEmailResponseFixtureFactory extends JsonFixtureFactory<SignInEmailResponse> {
  @override
  FixtureDefinition<SignInEmailResponse> definition() => define(
        (faker) => const SignInEmailResponse(),
  );

  @override
  JsonFixtureDefinition<SignInEmailResponse> jsonDefinition() => defineJson(
      (object) => {},
  );
}
