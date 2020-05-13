import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'models/todo.dart';
import 'models/todo_model.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => TodoModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red, secondaryHeaderColor: Colors.orange),
      home: Scaffold(
        appBar: AppBar(title: Text("After todo")),
        body: TodoListWidget(),
      ),
    );
  }
}

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddItemWidget(),
        ItemListWidget()
      ],
    );
  }
}

class AddItemWidget extends StatelessWidget {
  TodoModel todoModel;

  TextEditingController _textController = TextEditingController();

  TextField _textField;

  String _newItemText = "";

  Future<Todo> addTodos(String title) async {
    final http.Response response = await http.post(
      'https://jsonplaceholder.typicode.com/todos',
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, Object>{
          "userId": 1,
          "title": title,
        },
      ),
    );

    if (response.statusCode == 201) {
      print(response.body);
      todoModel.add(Todo.fromJson(jsonDecode(response.body)));
      _textController.clear();
      _newItemText = "";
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  void insert() {
    if (_newItemText.isEmpty) return;
    addTodos(_newItemText);
  }

  @override
  Widget build(BuildContext context) {
    todoModel = Provider.of<TodoModel>(context);

    _textField = TextField(
      onChanged: (text) => _newItemText = text,
      maxLength: 25,
      controller: _textController,
      onSubmitted: (text) => insert(),
      decoration: InputDecoration(counterStyle: TextStyle(fontSize: 0), hintText: "What do you gonna do?", border: InputBorder.none),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Row(
        children: <Widget>[
          Flexible(flex: 9, child: _textField),
          Flexible(
            flex: 1,
            child: IconButton(
              onPressed: insert,
              icon: Icon(
                Icons.send,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  TodoModel todoModel;

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/todos');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("ablaorsluboarnsoyntaonrstnyarso");
      final todos = json.decode(response.body).map<Todo>((item) => Todo.fromJson(item)).toList();
      print(todos);
      todoModel.setItems(todos);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {
    todoModel = Provider.of<TodoModel>(context);
    if (todoModel.isInit) fetchTodos();

    return Expanded(
      child: Consumer<TodoModel>(
        builder: (context, todo, child) {
          return ListView.builder(
            itemCount: todo.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todo.items[index].title),
                onTap: () => todo.removeAt(index),
              );
            },
          );
        },
      ),
    );
  }
}
