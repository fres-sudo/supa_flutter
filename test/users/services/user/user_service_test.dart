import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:supa_flutter/users/services/user/user_service.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  late UserService service;

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);

    service = UserService(dio);
  });

  //TODO: Test your methods
}
