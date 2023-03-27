import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/todoItem.dart';
import 'package:todo_app/utils.dart';
import 'todoItemWidget.dart';
import './data/todoData.dart';

void main() {
  runApp(MaterialApp(
    home: ToDoApp(),
  ));
}

class ToDoApp extends StatefulWidget {
  ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  void initState() {
    getTodos();
    super.initState();
  }

  void getTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final vals = await prefs.getStringList('todos');
    setState(() {
      todos = vals == null
          ? [TodoItem(title: "not", body: "found")]
          : fromJsonList(vals);
    });
    print("after getting ================");
  }

  void setTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todos', toJsonList(todos));
    print("saved changes...");
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  void addTodoItem() {
    String? body, title;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Add new to-do!",
              style: TextStyle(
                fontFamily: 'DeliciousHandrawn',
              ),
            ),
            clipBehavior: Clip.antiAlias,
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      onChanged: (value) {
                        title = value;
                      },
                      style: const TextStyle(fontFamily: 'DeliciousHandrawn'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        hintText: "title",
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      body = value;
                    },
                    style: const TextStyle(fontFamily: 'DeliciousHandrawn'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: "body",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todos.insert(0, TodoItem(title: title!, body: body!));
                        Navigator.pop(context);
                      });
                      setTodos();
                    },
                    child: const Text("add"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "to-do",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              onPressed: addTodoItem,
              icon: const Icon(
                Icons.add,
                color: Colors.blue,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: ListView(
          children: todos
              .map((e) => TodoItemWidget(
                    todoItem: e,
                    onItemTap: () {
                      setState(() {
                        todos.remove(e);
                      });
                      setTodos();
                    },
                  ))
              .toList()),
    );
  }
}
