import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
 MovieCard({required this.id, required this.date, required this.movie_name,required this.rating,});
  final int? id;
  final String? movie_name;
  // final String? genre;
  final DateTime? date;
  final String? rating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Container(
          // color: Colors.grey,
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white70,
          borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.add_a_photo,size: 60,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(id.toString()),
                    Text(movie_name!),
                    // Text(genre!),
                    Text(date.toString()),
                    Text(rating!),
                  ],
                ),
              ],
            ),
          ),
      ),
      ),
    );
  }
}


// class MovieCard extends StatelessWidget {
//   const MovieCard(
//       {this.movieName,
//       this.genre,
//       this.starring,
//       this.director,
//       this.image,
//       this.pageViews,
//       this.votedBy,
//       this.language,
//       this.voting,
//       this.runtime,
//       this.time});
//   final String? movieName;
//   final String? genre;
//   final List? starring;
//   final List? director;
//   final String? image;
//   final int? pageViews;
//   final int? votedBy;
//   final String? language;
//   final int? voting;
//   final int? runtime;
//   final int? time;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Color(0xFFF1C085),
//           borderRadius: BorderRadius.circular(10.0),
//           border: Border.all(color: Colors.white, width: 1.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               offset: const Offset(
//                 5.0,
//                 5.0,
//               ),
//               blurRadius: 10.0,
//               spreadRadius: 2.0,
//             ), //BoxShadow
//             BoxShadow(
//               color: Colors.white,
//               offset: const Offset(0.0, 0.0),
//               blurRadius: 0.0,
//               spreadRadius: 0.0,
//             ), //BoxShadow
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Column(
//                     children: [
//                       Icon(
//                         Icons.arrow_drop_up_outlined,
//                         size: 30.0,
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Text(
//                         "$voting",
//                         style: TextStyle(fontSize: 25),
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Icon(
//                         Icons.arrow_drop_down_outlined,
//                         size: 30.0,
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Text(
//                         "Votes",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Container(
//                     //height: 160,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25.0),
//                       // image: DecorationImage(
//                       //   fit: BoxFit.fill,
//                       //   image: NetworkImage("${image!}"),
//                       // ),
//                     ),
//                     child: Image.network(image!),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "$movieName",
//                           style: TextStyle(fontSize: 30),
//                         ),
//                         SizedBox(
//                           height: 5.0,
//                         ),
//                         Text(
//                           "Genre: $genre",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 3.0,
//                         ),
//                         Text(
//                           "Director: ${director!.join(' , ')}",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 3.0,
//                         ),
//                         Text(
//                           "Starring: ${starring!.join(', ')}",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 3.0,
//                         ),
//                         Text(
//                           "$runtime Mins  |  $language  |  ${DateTime.fromMicrosecondsSinceEpoch(time!).day} ",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 3.0,
//                         ),
//                         Text(
//                           "$pageViews views | Voted by $votedBy people",
//                           style: TextStyle(fontSize: 15, color: Colors.blue),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: new Container(
//                   width: double.infinity,
//                   height: 50.0,
//                   decoration: new BoxDecoration(
//                     color: Colors.blue,
//                     border: new Border.all(color: Colors.white, width: 2.0),
//                     borderRadius: new BorderRadius.circular(15.0),
//                   ),
//                   child: new Center(
//                     child: new Text(
//                       'Watch Trailer',
//                       style: new TextStyle(
//                           fontSize: 25.0,
//                           color: Color(0xFFF1C085),
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
