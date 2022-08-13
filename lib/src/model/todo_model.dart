class TodoModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoModel.fromMap(Map map) {
    return TodoModel(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      completed: map['completed'],
    );
  }
}


/** 
 * get(https://jsonplaceholder.typicode.com/todos);
 * map
 * 
 * todomodel(map)
 * todomodel.frommap(map)
**/