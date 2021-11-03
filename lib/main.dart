import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie App'),),
      body: Center(
        child: TextButton(
          onPressed: ()=>getData(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Test');
  }
}

void getData() async {
  var connection = PostgreSQLConnection(
      "localhost", 5432, "movie_ratings", username: "postgres", password: "postgres");
  await connection.open();
  print(connection.query("select * from movie"));
}
