import 'package:flutter/material.dart';
import 'package:todo_app/data/todoData.dart';
import './data/todoItem.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItem todoItem;
  final VoidCallback onItemTap;
  const TodoItemWidget(
      {super.key, required this.todoItem, required this.onItemTap});

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onItemTap,
        child: Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.todoItem.title,
                style: const TextStyle(
                  fontFamily: 'DeliciousHandrawn',
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              Text(widget.todoItem.body,
                  style: const TextStyle(
                    fontFamily: 'DeliciousHandrawn',
                    fontWeight: FontWeight.normal,
                    fontSize: 21,
                    color: Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
