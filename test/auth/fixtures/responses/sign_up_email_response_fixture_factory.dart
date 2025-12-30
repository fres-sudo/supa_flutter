import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/responses/sign_up_email/sign_up_email_response.dart';

extension SignUpEmailResponseFixture on SignUpEmailResponse {
  static SignUpEmailResponseFixtureFactory factory() => SignUpEmailResponseFixtureFactory();
}

class SignUpEmailResponseFixtureFactory extends JsonFixtureFactory<SignUpEmailResponse> {
  @override
  FixtureDefinition<SignUpEmailResponse> definition() => define(
        (faker) => const SignUpEmailResponse(),
  );

  @override
  JsonFixtureDefinition<SignUpEmailResponse> jsonDefinition() => defineJson(
      (object) => {},
  );
}
