import 'package:dio/dio.dart';
import 'package:masterclass_desafio/src/core/services/network/network_error.dart';
import 'package:masterclass_desafio/src/datasource/todos_datasource_interface.dart';
import 'package:masterclass_desafio/src/utils/app_constants.dart';

import '../core/services/network/network_service_interface.dart';

class DioTodosDatasource implements ITodosDatasource {
  DioTodosDatasource(this.service);
  final INetworkService service;

  @override
  Future getAllTodos() async {
    try {
      final Response response = await service.get(AppConstants.serverDB);
      return response;
    } on NetworkException catch (e) {
      throw DatasourceException(
          '${e.message}\n ${e.statusCode != null ? 'StatusCode: ${e.statusCode}' : ''}');
    }
  }
}

class DatasourceException implements Exception {
  final String message;
  DatasourceException(this.message);
}
