import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];
  final myBox = Hive.box('mybox');

  void createInitialData() {
    todoList.addAll([
      ['Task 1', false],
      ['Task 2', true],
    ]);
  }

  Future<void> loadData() async {
    todoList = await myBox.get('TODOLIST');

    if (todoList.isEmpty) {
      createInitialData();
    }
  }

  Future<void> updateDataBase() async {
    await myBox.put('TODOLIST', todoList);
  }
}
