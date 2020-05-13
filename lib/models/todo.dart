class Todo {
  final int userId;
  final int id;
  final String title;
  final bool done;

  Todo({this.userId, this.id, this.title, this.done});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        done: json['done']
    );
  }
}

