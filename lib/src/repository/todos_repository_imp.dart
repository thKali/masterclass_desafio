import 'package:masterclass_desafio/src/datasource/dio_todos_datasource.dart';
import 'package:masterclass_desafio/src/datasource/todos_datasource_interface.dart';
import 'package:masterclass_desafio/src/model/todo_model.dart';
import 'package:masterclass_desafio/src/repository/todos_repository_interface.dart';

class TodosRepositoryImp implements ITodosRepository {
  TodosRepositoryImp({required ITodosDatasource datasource})
      : _datasource = datasource;

  final ITodosDatasource _datasource;

  @override
  Future<List<TodoModel>> getAllTodos() async {
    try {
      final response = await _datasource.getAllTodos();
      final list =
          (response.data as List).map((e) => TodoModel.fromMap(e)).toList();
      return list;
    } on DatasourceException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}

class RepositoryException implements Exception {
  final String message;
  RepositoryException(this.message);
}
