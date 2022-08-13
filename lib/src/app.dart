import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:masterclass_desafio/src/datasource/dio_todos_datasource.dart';
import 'package:masterclass_desafio/src/home/home_controller.dart';
import 'package:masterclass_desafio/src/repository/todos_repository_imp.dart';

import 'core/services/network/dio/dio_network_service_imp.dart';
import 'home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deasfio Masterclass',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        homeController: HomeController(
          DioNetworkServiceImp(dio: Dio()),
          TodosRepositoryImp(
            datasource: DioTodosDatasource(
              DioNetworkServiceImp(
                dio: Dio(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
