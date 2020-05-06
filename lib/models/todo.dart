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



//  static List<Todo> fromJsonList(List<Map<String, dynamic>>) {
//
//  }
}


class Todos {
  final List<Todo> _list = List();

  void insert(Todo todo) {
    _list.insert(0, todo);
  }

  void _delete(int index) {
    _list.removeAt(index);
  }
  
}

