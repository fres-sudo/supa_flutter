import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:supa_flutter/core/services/config/config_service.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  late ConfigService service;

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);

    service = ConfigService(dio);
  });

  //TODO: Test your methods
}
