import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masterclass_desafio/src/core/services/network/dio/dio_network_service_imp.dart';

void main() {
  test('Response.data retorna uma lista', () async {
    final service = DioNetworkServiceImp(dio: Dio());

    var response =
        await service.get('https://jsonplaceholder.typicode.com/todos');

    expect(response.data, isA<List>());
  });
}
