import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key,required this.id}) : super(key: key);
  final int? id;
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(future: getData(widget.id),
      builder: (BuildContext context,AsyncSnapshot snapshot){
    List<Widget> children;
    if (snapshot.hasData) {
    return Column(
    children: [
      Text(snapshot.data!.toString())
    ],
    );
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
),
      );
  }
}


Future getData(int? id) async {
  final connection = PostgreSQLConnection('ec2-52-200-155-213.compute-1.amazonaws.com', 5432, 'dbca0g0f9vhbak',
      username: 'btkydjfodbmlon', password: '9f0e0882442218b55ad591c941c7ce472eef22addf02a30df9413864d2d318d0',useSSL: true);
  await connection.open();
  var a = await connection.query('select * from movie where m_id=${id}');
  // print(a);
  print('works');
  await connection.close();
  return a;
}