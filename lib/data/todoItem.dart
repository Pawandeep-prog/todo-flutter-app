class TodoItem {
  String title, body;
  TodoItem({required this.title, required this.body});

  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body};
  }

  static TodoItem fromMap(Map<String, dynamic> m) {
    return TodoItem(title: m['title']!, body: m['body']!);
  }
}
