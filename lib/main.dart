import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

TodoState todoState = new TodoState();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.red, secondaryHeaderColor: Colors.orange),
        home: TodoListWidget());
  }
}

class TodoState extends State<TodoListWidget> {
  List<String> todoItems = [
    "abababab",
    "blablalbla",
    "ababrbrb",
    "blablalbla",
    "rstbrstbrstbrstbrstb",
    "blablbrststbalbla",
    "blablalbla"
  ];

  String _newItemText = "";

  void insert() {
    if (_newItemText.isEmpty) return;

    todoItems.insert(0, _newItemText);
    setState(() {
      _newItemText = "";
    });
  }

  void remove(int index) {
    todoItems.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("After todo")),
      body: Column(
        children: <Widget>[
          AddTodoItemWidget(),
          TodoItemsWidget(),
        ],
      ),
    );
  }
}

class TodoItemsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoItemsState();
}

class TodoItemsState extends State<TodoItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todoState.todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoState.todoItems[index]),
            onTap: () => todoState.remove(index),
          );
        },
      ),
    );
  }
}

class AddTodoItemWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddTodoItemState();
}

class AddTodoItemState extends State<AddTodoItemWidget> {
  TextEditingController _textController = TextEditingController();

  TextField _textField;

  void insert() {
    _textController.clear();
    todoState.insert();
  }

  @override
  Widget build(BuildContext context) {
    _textField = TextField(
      onChanged: (text) => {
        setState(() => {todoState._newItemText = text}),
      },
      maxLength: 25,
      controller: _textController,
      onSubmitted: (text) => insert(),
      decoration: InputDecoration(
          counterStyle: TextStyle(fontSize: 0),
          hintText: "What do you gonna do?",
          border: InputBorder.none),
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

class TodoListWidget extends StatefulWidget {
  @override
  State<TodoListWidget> createState() => todoState;
}
