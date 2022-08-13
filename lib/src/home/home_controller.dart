import 'package:flutter/cupertino.dart';
import 'package:masterclass_desafio/src/core/services/network/network_error.dart';
import 'package:masterclass_desafio/src/repository/todos_repository_imp.dart';
import 'package:masterclass_desafio/src/repository/todos_repository_interface.dart';
import 'package:masterclass_desafio/src/utils/app_constants.dart';

import '../core/services/network/network_service_interface.dart';
import '../model/todo_model.dart';

class HomeController extends ChangeNotifier {
  final INetworkService _service;
  final ITodosRepository _repository;

  HomeController(this._service, this._repository);

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => List.unmodifiable(_todos);

  String errorMessage = '';

  Status status = Status.empty;

  bool getByService = false;

  void getTodos() {
    if (getByService) {
      getAllTodosByService();
    } else {
      getAllTodosByRepository();
    }
  }

  getAllTodosByService() async {
    status = Status.loading;
    notifyListeners();
    var result;
    try {
      result = await _service.get(AppConstants.serverDB);
    } on NetworkException catch (e) {
      errorMessage = e.message;
      changeState(Status.error);
      return;
    }
    if (result.data.isEmpty) {
      _todos = [];
      changeState(Status.empty);
    } else if (result.data.isNotEmpty) {
      List r = result.data;
      _todos = r.map((e) => TodoModel.fromMap(e)).toList();
      changeState(Status.sucess);
    }
  }

  Future<void> getAllTodosByRepository() async {
    status = Status.loading;
    notifyListeners();
    var result;
    try {
      result = await _repository.getAllTodos();
    } on RepositoryException catch (e) {
      errorMessage = e.message;
      changeState(Status.error);
      return;
    }

    if (result.isEmpty) {
      _todos = [];
      changeState(Status.empty);
    } else if (result.isNotEmpty) {
      _todos = result;
      changeState(Status.sucess);
    }
  }

  void changeState(Status newState) {
    status = newState;
    notifyListeners();
  }
}

enum Status {
  loading,
  sucess,
  empty,
  error,
}
