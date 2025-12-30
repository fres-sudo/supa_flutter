import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/requests/send_verification_email/send_verification_email_request.dart';

extension SendVerificationEmailRequestFixture on SendVerificationEmailRequest {
  static SendVerificationEmailRequestFixtureFactory factory() => SendVerificationEmailRequestFixtureFactory();
}

class SendVerificationEmailRequestFixtureFactory extends JsonFixtureFactory<SendVerificationEmailRequest> {
  @override
  FixtureDefinition<SendVerificationEmailRequest> definition() => define(
        (faker) => const SendVerificationEmailRequest(),
  );

  @override
  JsonFixtureDefinition<SendVerificationEmailRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
