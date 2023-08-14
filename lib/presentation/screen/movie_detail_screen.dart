import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_booking_ui_flutter/config/constant.dart';
import 'package:cinema_booking_ui_flutter/entities/movie.dart';
import 'package:cinema_booking_ui_flutter/presentation/screen/reservation_screen.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Movie Detail'),
          centerTitle: true,
          // leading: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.58,
                        child: Hero(
                          tag: movie.title,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              key: UniqueKey(),
                              fit: BoxFit.cover,
                              imageUrl: movie.poster,
                              errorWidget: (context, url, error) =>
                                  const Center(child: Text("Error IMG")),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                          value: progress.progress)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      _Category(movie: movie)
                    ]),
              ),
              const SizedBox(height: 20),
              _Description(movie: movie)
            ],
          ),
        ));
  }
}

class _Description extends StatefulWidget {
  const _Description({required this.movie});

  final Movie movie;

  @override
  State<_Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<_Description> {
  var moreText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.movie.title,
          style: const TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(indent: 2, color: white),
        const Text(
          "Description",
          style: TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Stack(children: [
          Text(
            widget.movie.synopsis,
            style: const TextStyle(color: white),
            maxLines: moreText ? null : 20,
          ),
          moreText
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                ),
          moreText
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    child: FilledButton(
                      onPressed: () {
                        // setState(() {
                        //   moreText = true;
                        // });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReservationScreen(),
                            ));
                      },
                      child: const Text("More Text"),
                    ),
                  ),
                )
        ])
      ],
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final Decoration boxDecoration = BoxDecoration(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      border: Border.all(color: white),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 90,
          height: 90,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera, color: white),
              const SizedBox(height: 4),
              const Text("genre", style: TextStyle(color: white)),
              const SizedBox(height: 4),
              Text(movie.genre, style: const TextStyle(color: white)),
            ],
          ),
        ),
        Container(
          width: 90,
          height: 90,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera, color: white),
              const SizedBox(height: 4),
              const Text("genre", style: TextStyle(color: white)),
              const SizedBox(height: 4),
              Text(movie.genre, style: const TextStyle(color: white)),
            ],
          ),
        ),
        Container(
          width: 90,
          height: 90,
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera, color: white),
              const SizedBox(height: 4),
              const Text("genre", style: TextStyle(color: white)),
              const SizedBox(height: 4),
              Text(movie.genre, style: const TextStyle(color: white)),
            ],
          ),
        ),
      ],
    );
  }
}

// class _Category extends StatelessWidget {
//   const _Category({required this.movie});

//   final Movie movie;

//   @override
//   Widget build(BuildContext context) {
//     final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
//       backgroundColor: Colors.white,
//       padding: const EdgeInsets.all(5),
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//         Radius.circular(15),
//       )),
//       side: const BorderSide(color: white),
//     );

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         OutlinedButton(
//           style: buttonStyle,
//           onPressed: () {},
//           child: Column(
//             children: [
//               const Icon(Icons.camera),
//               const SizedBox(height: 4),
//               const Text("genre"),
//               const SizedBox(height: 4),
//               Text(movie.genre)
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         OutlinedButton(
//           style: buttonStyle,
//           onPressed: () {},
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//               children: [
//                 const Icon(Icons.camera),
//                 const SizedBox(height: 4),
//                 const Text("duration"),
//                 const SizedBox(height: 4),
//                 Text('${movie.duration}')
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         OutlinedButton(
//           style: buttonStyle,
//           onPressed: () {},
//           child: Column(
//             children: [
//               const Icon(Icons.camera),
//               const SizedBox(height: 4),
//               const Text("rating"),
//               const SizedBox(height: 4),
//               Text('${movie.rating}')
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
