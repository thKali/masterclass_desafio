import 'package:masterclass_desafio/src/model/todo_model.dart';

abstract class ITodosRepository {
  Future<List<TodoModel>> getAllTodos();
}
