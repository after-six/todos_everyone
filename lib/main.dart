import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    List<String> aaaa = ["blablalbla","blablalbla","blablalbla","blablalbla","blablalbla","blablalbla","blablalbla","blablalbla","blablalbla",]
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.red, secondaryHeaderColor: Colors.orange),
      home: Scaffold(
        appBar: AppBar(title: Text("After todo")),
        body: Column(
          children: <Widget>[
            TodoTextField(),
            Expanded(
              child: ListView(
                // TODO 이 하드코딩 된 부분을 리스트 빌더를 이용하여 예쁘게 하세요.
                children: <Widget>[
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("blablalbla"),
                  ),
                  ListTile(
                    title: Text("This is end"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TodoTextField extends StatelessWidget {
  const TodoTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 9,
            child: TextField(
              maxLength: 25,
              decoration: InputDecoration(
                counterStyle: TextStyle(fontSize: 0),
                hintText: "What do you gonna do?",
                border: InputBorder.none
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
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
