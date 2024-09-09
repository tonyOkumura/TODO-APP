// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_app/pages/widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  final List todoList = [
    ['Buy Bread', false],
    ['Buy Milk', false],
    ['Buy Egg', true],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(
            'Todo App',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskCompleted: todoList[index][1],
                title: todoList[index][0],
                onChanged: (value) {
                  checkboxChanged(index, value);
                },
                onDeleted: () {
                  setState(() {
                    todoList.removeAt(index);
                  });
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTask(context);
          },
          child: Icon(Icons.add),
        ));
  }

  Future<dynamic> createNewTask(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: controller,
              onPressedAdd: () {
                setState(() {
                  todoList.add([controller.text, false]);
                });
                Navigator.pop(context);
                controller.clear();
              });
        });
  }

  void checkboxChanged(int index, bool? value) {
    return setState(() {
      todoList[index][1] = value!;
    });
  }
}

class DialogBox extends StatelessWidget {
  const DialogBox({
    Key? key,
    required this.controller,
    required this.onPressedAdd,
  }) : super(key: key);
  final TextEditingController? controller;
  final void Function() onPressedAdd;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey.shade500,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'Enter Task', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.blueGrey.shade700)),
              ),
              SizedBox(
                width: 10,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.blueGrey.shade700)),
                onPressed: () {
                  onPressedAdd();
                },
                child: Text('Add'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
