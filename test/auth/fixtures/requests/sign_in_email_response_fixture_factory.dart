import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/requests/sign_in_email/sign_in_email_request.dart';

extension SignInEmailRequestFixture on SignInEmailRequest {
  static SignInEmailRequestFixtureFactory factory() => SignInEmailRequestFixtureFactory();
}

class SignInEmailRequestFixtureFactory extends JsonFixtureFactory<SignInEmailRequest> {
  @override
  FixtureDefinition<SignInEmailRequest> definition() => define(
        (faker) => const SignInEmailRequest(),
  );

  @override
  JsonFixtureDefinition<SignInEmailRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
