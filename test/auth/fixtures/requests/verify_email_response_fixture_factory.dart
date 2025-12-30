import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/requests/verify_email/verify_email_request.dart';

extension VerifyEmailRequestFixture on VerifyEmailRequest {
  static VerifyEmailRequestFixtureFactory factory() => VerifyEmailRequestFixtureFactory();
}

class VerifyEmailRequestFixtureFactory extends JsonFixtureFactory<VerifyEmailRequest> {
  @override
  FixtureDefinition<VerifyEmailRequest> definition() => define(
        (faker) => const VerifyEmailRequest(),
  );

  @override
  JsonFixtureDefinition<VerifyEmailRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
