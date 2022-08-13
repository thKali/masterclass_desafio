import 'package:flutter/material.dart';
import 'package:masterclass_desafio/src/home/home_controller.dart';
import 'package:masterclass_desafio/src/model/todo_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.homeController}) : super(key: key);

  final HomeController homeController;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Status status;
  late HomeController controller;
  @override
  void initState() {
    controller = widget.homeController;
    controller.addListener(() {
      status = controller.status;
      setState(() {});
    });
    controller.getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio'),
        actions: [
          IconButton(
              onPressed: () {
                controller.getTodos();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          if (status == Status.loading) {
            return const Center(
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator()));
          }
          if (status == Status.error) {
            return Center(child: Text('Error: ${controller.errorMessage}'));
          }
          if (status == Status.empty) {
            return const Center(child: Text('Nenhuma Todo foi encontrada'));
          }
          if (status == Status.sucess) {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  TodoModel todo = controller.todos[index];
                  return _buildListTile(todo);
                });
          }
          return const Center(child: Text('nada'));
        },
      ),
    );
  }

  _buildListTile(TodoModel todo) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(onChanged: (value) {}, value: todo.completed),
    );
  }
}
