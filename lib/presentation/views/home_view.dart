import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_booking_ui_flutter/entities/category.dart';
import 'package:cinema_booking_ui_flutter/entities/movie.dart';
import 'package:cinema_booking_ui_flutter/presentation/screen/movie_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booking_ui_flutter/config/constant.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Container(
    //     color: Colors.blue,
    //     child: Column(
    //       children: [
    //         Row(
    //           // crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               width: 100,
    //               height: 240,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(15),
    //                 color: Colors.red,
    //               ),
    //             ),
    //             const SizedBox(width: 20),
    //             const Expanded(
    //               child: Column(children: [
    //                 Text(
    //                     "text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1text 1"),
    //                 Text("text 1text 1text 1text 1"),
    //               ]),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverPadding(padding: EdgeInsets.only(top: 10)),
        SliverAppBar(
          centerTitle: false,
          backgroundColor: transparent,
          floating: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome to my app", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text("Let relax and watch movie!",
                        style: TextStyle(fontSize: 12))
                  ],
                ),
                const Spacer(),
                Container(
                  height: 50,
                  width: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/1.gif'),
                    image: AssetImage('assets/profile.jpg'),
                  ),
                )
              ],
            ),
          ),
        ),
        const _TextFormField(),
        const _Category(),
        const _Slide(),
      ],
    );
  }
}

class _Slide extends StatefulWidget {
  const _Slide();

  @override
  State<_Slide> createState() => _SlideState();
}

class _SlideState extends State<_Slide> {
  PageController? controller;
  double viewPortFraction = 0.65;
  double? pageOffset = 1;
  int currentMovie = 1;

  @override
  void initState() {
    super.initState();

    controller = PageController(
      initialPage: currentMovie,
      viewportFraction: viewPortFraction,
    )..addListener(() {
        setState(() {
          pageOffset = controller!.page;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(26, 20, 26, 20),
          child: Row(children: [
            const Text("Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: white,
                )),
            const Spacer(),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios, size: 15),
                label: const Text('See All'),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 400,
          child: Stack(alignment: AlignmentDirectional.center, children: [
            PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  currentMovie = value % movies.length;
                });
              },

              //loop scroll
              // itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index % movies.length];

                double scale = max(viewPortFraction,
                    (1 - (pageOffset! - index).abs() + viewPortFraction));
                double angle = 0;
                if (controller!.position.haveDimensions) {
                  angle = index.toDouble() - (controller!.page ?? 0);
                  angle = (angle * 5).clamp(-5, 5);
                } else {
                  angle = index.toDouble() - 1;
                  angle = (angle * 5).clamp(-5, 5);
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 100 - (scale / (1 + viewPortFraction) * 100)),
                    child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Transform.rotate(
                            angle: angle * pi / 100,
                            child: SizedBox(
                              height: 300,
                              child: Hero(
                                tag: movie.title,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  clipBehavior: Clip.antiAlias,
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
                          ),
                        ]),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 50,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ...List.generate(movies.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: currentMovie == index ? 30 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentMovie == index
                          ? const Color.fromARGB(255, 54, 82, 244)
                          : white,
                    ),
                  );
                }),
              ]),
            )
          ]),
        ),
      ]),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      sliver: SliverToBoxAdapter(
        child: Column(children: [
          Row(children: [
            const Text("Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: white,
                )),
            const Spacer(),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios, size: 15),
                label: const Text('See All'),
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ...List.generate(
              categories.length,
              (index) => Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/emoticons/${categories[index].emoticon}',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    categories[index].name,
                    style: const TextStyle(color: white),
                  )
                ],
              ),
            ),
          ])
        ]),
      ),
    );
  }
}

class _TextFormField extends StatelessWidget {
  const _TextFormField();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
      sliver: SliverToBoxAdapter(
        child: TextFormField(
          style: const TextStyle(color: white),
          decoration: InputDecoration(
            hintText: "Search ...",
            hintStyle: const TextStyle(color: white),
            filled: true,
            fillColor: white.withOpacity(.05),
            prefixIcon: const Icon(Icons.search, color: white),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
