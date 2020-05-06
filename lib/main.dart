import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', theme: ThemeData(primarySwatch: Colors.red, secondaryHeaderColor: Colors.orange), home: TodoListWidget());
  }
}

class TodoState extends State<TodoListWidget> {
  List<String> todoItems = [];

  List<Todo> todos = List();

  TextEditingController _textController = TextEditingController();

  TextField _textField;

  String _newItemText = "";

  Future<Todo> futureTodo;

  Todo todo = Todo();

  @override
  void initState() {
    super.initState();
    fetchTodos().then((value) => setState(() {
          todos = value;
        }));
  }

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/todos');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return json.decode(response.body).map<Todo>((item) => Todo.fromJson(item)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Todo> addTodos(String title) async {
    print(title);

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

    if(response.statusCode == 201) {
      print(response.body);
      todos.insert(0, Todo.fromJson(jsonDecode(response.body)));
      setState(() {
        print(_newItemText);
        _textController.clear();
        _newItemText = "";
      });
    } else {
      print(response.statusCode);
      print(response.body);
    }

  }

  void insert() {
    if (_newItemText.isEmpty) return;
    addTodos(_newItemText);


  }

  void remove(int index) {
//    todoItems.removeAt(index);
    print(index);
    setState(() {});
  }

  Future<Todo> fetchTodo() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/todos/1');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Todo.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    _textField = TextField(
      onChanged: (text) => setState(() => {_newItemText = text}),
      maxLength: 25,
      controller: _textController,
      onSubmitted: (text) => insert(),
      decoration: InputDecoration(counterStyle: TextStyle(fontSize: 0), hintText: "What do you gonna do?", border: InputBorder.none),
    );

    return Scaffold(
      appBar: AppBar(title: Text("After todo")),
      body: Column(
        children: <Widget>[
          Container(
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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                  onTap: () => remove(index),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TodoListWidget extends StatefulWidget {
  @override
  State<TodoListWidget> createState() => TodoState();
}
