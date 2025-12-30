import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/requests/verify_otp/verify_otp_request.dart';

extension VerifyOtpRequestFixture on VerifyOtpRequest {
  static VerifyOtpRequestFixtureFactory factory() => VerifyOtpRequestFixtureFactory();
}

class VerifyOtpRequestFixtureFactory extends JsonFixtureFactory<VerifyOtpRequest> {
  @override
  FixtureDefinition<VerifyOtpRequest> definition() => define(
        (faker) => const VerifyOtpRequest(),
  );

  @override
  JsonFixtureDefinition<VerifyOtpRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
