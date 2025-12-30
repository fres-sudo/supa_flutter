import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/responses/verify_email/verify_email_response.dart';

extension VerifyEmailResponseFixture on VerifyEmailResponse {
  static VerifyEmailResponseFixtureFactory factory() => VerifyEmailResponseFixtureFactory();
}

class VerifyEmailResponseFixtureFactory extends JsonFixtureFactory<VerifyEmailResponse> {
  @override
  FixtureDefinition<VerifyEmailResponse> definition() => define(
        (faker) => const VerifyEmailResponse(),
  );

  @override
  JsonFixtureDefinition<VerifyEmailResponse> jsonDefinition() => defineJson(
      (object) => {},
  );
}
