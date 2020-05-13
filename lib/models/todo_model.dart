import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:todoseveryone/models/todo.dart';

class TodoModel extends ChangeNotifier {
  List<Todo> _todos = [];
  bool initialize = true;

  UnmodifiableListView<Todo> get items => UnmodifiableListView(_todos);

  get isInit => this.initialize;

  void setItems(List<Todo> todos) {
    if (initialize) {
      initialize = false;
      _todos.insertAll(0, todos);
      notifyListeners();
    }
  }

  void add(Todo todo) {
    _todos.insert(0, todo);
    notifyListeners();
  }

  void remove(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void removeAt(int i) {
    _todos.removeAt(i);
    notifyListeners();
  }
}
