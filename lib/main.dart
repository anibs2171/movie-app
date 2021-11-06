import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

void main() {
  runApp(MyApp());
  // getData();
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
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            getData();
          },
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
  final connection = PostgreSQLConnection('ec2-52-200-155-213.compute-1.amazonaws.com', 5432, 'dbca0g0f9vhbak',
      username: 'btkydjfodbmlon', password: '9f0e0882442218b55ad591c941c7ce472eef22addf02a30df9413864d2d318d0',useSSL: true);
  await connection.open();
  var a = await connection.query('select * from movie');
  print(a);
  print('works');
  await connection.close();
}
