import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import "movie_card.dart";

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
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          List<Widget> children;
      if (snapshot.hasData) {
        return ListView.builder(itemBuilder: (context,index){
          return MovieCard(
            id: snapshot.data[index][0],
            date: DateTime.fromMicrosecondsSinceEpoch(snapshot.data[index][2]),
            movie_name: snapshot.data[index][1],
            rating: snapshot.data[index][3].toString(),
          );
        },itemCount: snapshot.data.length,);
        // <Widget>[
        //   const Icon(
        //     Icons.check_circle_outline,
        //     color: Colors.green,
        //     size: 60,
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.only(top: 16),
        //     child: Text('Result: ${snapshot.data}'),
        //   )
        // ];
      }
      else if (snapshot.hasError) {
        children = <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: ${snapshot.error}'),
          )
        ];
      }
      else{
        children = const <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
          )
        ];
      }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      )
    );
  }
}

// class MovieCard extends StatelessWidget {
//   const MovieCard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text('Test');
//   }
// }

Future getData() async {
  final connection = PostgreSQLConnection('ec2-52-200-155-213.compute-1.amazonaws.com', 5432, 'dbca0g0f9vhbak',
      username: 'btkydjfodbmlon', password: '9f0e0882442218b55ad591c941c7ce472eef22addf02a30df9413864d2d318d0',useSSL: true);
  await connection.open();
  var a = await connection.query('select * from movie');
  // print(a);
  print('works');
  await connection.close();
  return a;
}
