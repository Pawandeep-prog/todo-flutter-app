import './data/todoItem.dart';
import 'dart:convert' as json;

List<String> toJsonList(List<TodoItem> todos) {
  return todos.map((e) => json.jsonEncode(e.toMap())).toList();
}

List<TodoItem> fromJsonList(List<String> todos) {
  return todos.map((e) => TodoItem.fromMap(json.jsonDecode(e))).toList();
}
