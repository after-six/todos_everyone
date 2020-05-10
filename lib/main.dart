import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/todo.dart';
import 'models/todo_models.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoModel(),
      child:MyApp()
    )
  );
}

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

class TodoListWidget extends StatelessWidget {
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

class TodoItemsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var todo = Provider.of<TodoModel>(context);

    return Expanded(
      child: ListView.builder(
        itemCount: todo.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todo.items[index].title),
            onTap: () => todo.remove(index),
          );
        },
      ),
    );
  }
}

class AddTodoItemWidget extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  TextField _textField;

  void addItem(TodoModel todo) {
    todo.add(Todo(title: _textController.text));
    _textController.clear();
  }


  @override
  Widget build(BuildContext context) {
    var todo = Provider.of<TodoModel>(context);

    _textField = TextField(
      maxLength: 25,
      controller: _textController,
      onSubmitted: (text) => addItem(todo),
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
              onPressed: () => addItem(todo),
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
