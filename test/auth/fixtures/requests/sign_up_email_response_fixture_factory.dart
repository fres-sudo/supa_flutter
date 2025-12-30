import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/requests/sign_up_email/sign_up_email_request.dart';

extension SignUpEmailRequestFixture on SignUpEmailRequest {
  static SignUpEmailRequestFixtureFactory factory() => SignUpEmailRequestFixtureFactory();
}

class SignUpEmailRequestFixtureFactory extends JsonFixtureFactory<SignUpEmailRequest> {
  @override
  FixtureDefinition<SignUpEmailRequest> definition() => define(
        (faker) => const SignUpEmailRequest(),
  );

  @override
  JsonFixtureDefinition<SignUpEmailRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
