import 'dart:convert';
import 'package:cinepedia/bloc/addToFavouriteBloc.dart';
import 'package:cinepedia/model/seriesList.dart';
import 'package:cinepedia/screens/seriesDetailPage.dart';
import 'package:cinepedia/widgets/clipRRect.dart';
import 'package:cinepedia/widgets/headings.dart';
import 'package:cinepedia/widgets/shimmerContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class series extends StatefulWidget {
  const series({super.key});

  @override
  State<series> createState() => _seriesState();
}

class _seriesState extends State<series> {
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzllMGI1ZjU3NTM2NGMxNTcxOGQzMGUzYjhhMWYzNCIsInN1YiI6IjY1NzVlNDYzYzYwMDZkMDEwMjdjNDY5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eSiiMzHd8w1P3rWFCQFHxqQnzbsx-c-TAFaezaPA2x8';

  Future<seriesList> getSeries() async {
    final result = Uri.parse('https://api.themoviedb.org/3/tv/airing_today');
    final response = await http.get(result, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final finalResult = jsonDecode(response.body.toString());
      return seriesList.fromJson(finalResult);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    super.initState();
    getSeries();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section_heading(
              title: 'Series',
              leftMargin: Get.width * 0.015,
              topMargin: Get.height * 0.01,
            ),
            Expanded(
              child: FutureBuilder(
                future: getSeries(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.63,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              shimmerContainer(
                                height: Get.height * 0.3,
                                width: Get.width * 0.5,
                                horizontalMargin: Get.width * 0.01,
                                verticalMargin: Get.height * 0.01,
                              ),
                              shimmerContainer(
                                height: Get.height * 0.05,
                                width: Get.width * 0.5,
                                horizontalMargin: Get.width * 0.01,
                                verticalMargin: Get.height * 0.01,
                              )
                            ],
                          );
                        });
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        height: Get.height,
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.63,
                              // crossAxisSpacing: 20.0,
                            ),
                            itemCount: snapshot.data!.results!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    // height: Get.height * 0.28,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.025,
                                        vertical: Get.height * 0.01,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => BlocProvider.value(
                                              value:
                                                  BlocProvider.of<FavoriteBloc>(
                                                      context),
                                              child: seriesDetailPage(
                                                  imagetitle:
                                                      'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath}',
                                                  seriesId: snapshot
                                                      .data!.results![index].id
                                                      .toString(),
                                                  noOfGenres: snapshot
                                                      .data!
                                                      .results![index]
                                                      .genreIds!
                                                      .length,
                                                  title: snapshot.data!
                                                      .results![index].name
                                                      .toString(),
                                                  rating: snapshot
                                                      .data!
                                                      .results![index]
                                                      .voteAverage!
                                                      .round()
                                                      .toString()),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag:
                                              'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath}',
                                          child: clipRRect(
                                            imageAddress:
                                                'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath}',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.5,
                                    child: Text(
                                      snapshot.data!.results![index].name
                                          .toString(),
                                      softWrap: true,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Get.width * 0.04,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
