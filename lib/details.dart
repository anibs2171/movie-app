import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:postgres/postgres.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key, required this.id}) : super(key: key);
  final int? id;
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black45,
        /*actions: <Widget>[
          IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.movie))
        ],*/
      ),
      body: FutureBuilder(
        future: getData(widget.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(snapshot.data![0][1].toString(),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      snapshot.data![0][10],
                      height: 500,
                      width: 400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Actor: ${snapshot.data![0][13]}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Genre: ${snapshot.data![0][12]}",
                        style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Language: ${snapshot.data![0][16]}",
                        style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Director: ${snapshot.data![0][12]}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Production House: ${snapshot.data![0][18]}",
                        style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Avg Rating: ${snapshot.data![0][3]}",
                        style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Rate it:",
                        style: TextStyle(fontSize: 20, color: Colors.green)),
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      update(rating, widget.id);
                    },
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  //HOW TO MAKE THIS BG?
                  new Image(image: NetworkImage("https://www.clipartmax.com/png/small/8-87550_free-to-use-popcorn-clip-art-movie-popcorn-clip-art.png")),
                ],
              ),
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
              ),

            ];
          }
          /*return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                      "https://www.pngall.com/wp-content/uploads/1/Film-High-Quality-PNG.png"
                  ),
                   //fit: BoxFit.w,
                )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,

              ),
            ),
          );*/
          return Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                    "https://www.pngall.com/wp-content/uploads/1/Film-High-Quality-PNG.png"
                  ),
                  fit: BoxFit.cover,
                )
            ),

          );
        },
      ),
    );
  }
}

Future getData(int? id) async {
  final connection = PostgreSQLConnection(
      'ec2-52-200-155-213.compute-1.amazonaws.com', 5432, 'dbca0g0f9vhbak',
      username: 'btkydjfodbmlon',
      password:
          '9f0e0882442218b55ad591c941c7ce472eef22addf02a30df9413864d2d318d0',
      useSSL: true);
  await connection.open();
  var a = await connection
      .query('''select * from movie,genre,actor,lang,productionhouse
      where movie.m_id=${id} and 
      movie.genrid= genre.g_id and 
      movie.actorid = actor.a_id and 
      movie.lang_id = lang.l_id and
      movie.prodid = productionhouse.p_id
      ''');
  print(a);
  print('works');
  await connection.close();
  return a;
}

void update(double? val, int? mvid) async {
  final connection = PostgreSQLConnection(
      'ec2-52-200-155-213.compute-1.amazonaws.com', 5432, 'dbca0g0f9vhbak',
      username: 'btkydjfodbmlon',
      password:
          '9f0e0882442218b55ad591c941c7ce472eef22addf02a30df9413864d2d318d0',
      useSSL: true);
  await connection.open();
  var a = await connection.query('''
      update users set idvsrating = idvsrating || '{"${mvid}":${val}}'::jsonb where u_id=2;
      ''');
  print(a);
  var b = await connection.query('''
      update movie set rating = (select cast(avg(cast(idvsrating -> '${mvid}' as integer)) as numeric(2,1)) from users) where m_id = ${mvid} ;
      ''');
  print(b);
  print('works');
  await connection.close();
}
