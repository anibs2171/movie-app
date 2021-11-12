import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import "movie_card.dart";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.uid});
  int? uid;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOrdered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movie App'),
          backgroundColor: Colors.black54,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isOrdered = !isOrdered;
                  });
                },
                icon: Icon(Icons.sort))
          ],
        ),
        backgroundColor: Colors.grey,
        body: isOrdered ? FutureOrdered() : FutureNotOrdered());
  }
}

Future getData() async {
  final connection = PostgreSQLConnection(
      'ec2-52-200-155-213.compute-1.amazonaws.com', 5432, 'dbca0g0f9vhbak',
      username: 'btkydjfodbmlon',
      password:
          '9f0e0882442218b55ad591c941c7ce472eef22addf02a30df9413864d2d318d0',
      useSSL: true);
  await connection.open();
  var a = await connection.query('select * from movie order by rating');
  print(a);
  print('works');
  await connection.close();
  return a;
}

Future orderData() async {
  final connection = PostgreSQLConnection(
      'ec2-52-200-155-213.compute-1.amazonaws.com', 5432, 'dbca0g0f9vhbak',
      username: 'btkydjfodbmlon',
      password:
          '9f0e0882442218b55ad591c941c7ce472eef22addf02a30df9413864d2d318d0',
      useSSL: true);
  await connection.open();
  var a = await connection.query('select * from movie order by rating desc');
  print(a);
  print('works');
  await connection.close();
  return a;
}

class FutureOrdered extends StatefulWidget {
  const FutureOrdered({Key? key}) : super(key: key);

  @override
  _FutureOrderedState createState() => _FutureOrderedState();
}

class _FutureOrderedState extends State<FutureOrdered> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: orderData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return MovieCard(
                id: snapshot.data[index][0],
                date: snapshot.data[index][2].toString(),
                movie_name: snapshot.data[index][1],
                rating: snapshot.data[index][3].toString(),
                //snapshot.data[index][3].toString(),
                image: snapshot.data[index][10],
              );
              //HOW TO ADD BGCOLOR TO CARD
            },
            itemCount: snapshot.data.length,
          );
        } else if (snapshot.hasError) {
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
        } else {
          children = const <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Loading...'),
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
    );
  }
}

class FutureNotOrdered extends StatefulWidget {
  const FutureNotOrdered({Key? key}) : super(key: key);

  @override
  _FutureNotOrderedState createState() => _FutureNotOrderedState();
}

class _FutureNotOrderedState extends State<FutureNotOrdered> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return MovieCard(
                id: snapshot.data[index][0],
                date: snapshot.data[index][2].toString(),
                movie_name: snapshot.data[index][1],
                rating: snapshot.data[index][3].toString(),
                //snapshot.data[index][3].toString(),
                image: snapshot.data[index][10],
              );
              //HOW TO ADD BGCOLOR TO CARD
            },
            itemCount: snapshot.data.length,
          );
        } else if (snapshot.hasError) {
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
        } else {
          children = const <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Loading...'),
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
    );
  }
}

FutureBuilder<dynamic> orderedData() {
  return FutureBuilder(
    future: orderData(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      List<Widget> children;
      if (snapshot.hasData) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return MovieCard(
              id: snapshot.data[index][0],
              date: snapshot.data[index][2].toString(),
              movie_name: snapshot.data[index][1],
              rating: snapshot.data[index][3].toString(),
              //snapshot.data[index][3].toString(),
              image: snapshot.data[index][10],
            );
            //HOW TO ADD BGCOLOR TO CARD
          },
          itemCount: snapshot.data.length,
        );
      } else if (snapshot.hasError) {
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
      } else {
        children = const <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Loading...'),
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
  );
}
