import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masterclass_desafio/src/core/services/network/dio/dio_network_service_imp.dart';
import 'package:masterclass_desafio/src/core/services/network/network_service_interface.dart';
import 'package:masterclass_desafio/src/datasource/dio_todos_datasource.dart';
import 'package:masterclass_desafio/src/datasource/todos_datasource_interface.dart';
import 'package:masterclass_desafio/src/model/todo_model.dart';
import 'package:masterclass_desafio/src/repository/todos_repository_interface.dart';
import 'package:masterclass_desafio/src/repository/todos_repository_imp.dart';

void main() {
  test('repository deve retornar uma lista de TodoModel', () async {
    INetworkService service = DioNetworkServiceImp(dio: Dio());
    ITodosDatasource datasource = DioTodosDatasource(service);
    ITodosRepository repository = TodosRepositoryImp(datasource: datasource);

    var response = await repository.getAllTodos();

    expect(response, isA<List<TodoModel>>());
  });
}
