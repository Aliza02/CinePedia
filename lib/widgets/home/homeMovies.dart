import 'dart:convert';
import 'package:cinepedia/bloc/addToFavouriteBloc.dart';
import 'package:cinepedia/model/popularMovies.dart';
import 'package:cinepedia/screens/detailPage.dart';
import 'package:cinepedia/widgets/clipRRect.dart';
import 'package:cinepedia/widgets/headings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:http/http.dart' as http;

class homeMovies extends StatefulWidget {
  const homeMovies({super.key});

  @override
  State<homeMovies> createState() => _homeMoviesState();
}

class _homeMoviesState extends State<homeMovies> {
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzllMGI1ZjU3NTM2NGMxNTcxOGQzMGUzYjhhMWYzNCIsInN1YiI6IjY1NzVlNDYzYzYwMDZkMDEwMjdjNDY5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eSiiMzHd8w1P3rWFCQFHxqQnzbsx-c-TAFaezaPA2x8';

  Future<popularMovies> getPopularMovies() async {
    final result = Uri.parse('https://api.themoviedb.org/3/movie/popular');
    final response = await http.get(result, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final finalResult = jsonDecode(response.body.toString());
      return popularMovies.fromJson(finalResult);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<popularMovies> upComingMovies() async {
    final result = Uri.parse('https://api.themoviedb.org/3/movie/upcoming');
    final response = await http.get(
      result,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final finalResult = jsonDecode(response.body.toString());
      return popularMovies.fromJson(finalResult);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  void initState() {
    super.initState();
    getPopularMovies();
    upComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          section_heading(
            title: 'Most Popular',
            leftMargin: Get.width * 0.015,
            topMargin: Get.height * 0.01,
          ),
          FutureBuilder(
            future: getPopularMovies(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: Get.height * 0.4,
                  width: Get.width,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                );
              } else {
                return ScaledList(
                  marginWidthRatio: 0.1,
                  showDots: false,
                  selectedCardHeightRatio: 0.38,
                  unSelectedCardHeightRatio: 0.25,
                  itemColor: (index) {
                    return Colors.transparent;
                  },
                  itemCount: snapshot.data!.results!.length,
                  itemBuilder: (index, Sindex) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => BlocProvider.value(
                            value: BlocProvider.of<FavoriteBloc>(context),
                            child: detailPage(
                              title: snapshot.data!.results![index].title
                                  .toString(),
                              rating: snapshot
                                  .data!.results![index].voteAverage!
                                  .round()
                                  .toString(),
                              movie_id:
                                  snapshot.data!.results![index].id!.toString(),
                              noOfGenres: snapshot
                                  .data!.results![index].genreIds!.length,
                              imagetitle:
                                  'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath}',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 0.2,
                              blurRadius: 0.9,
                            ),
                          ],
                        ),
                        child: clipRRect(
                          imageAddress:
                              'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath}',
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          section_heading(
            title: 'Upcoming Movies',
            leftMargin: Get.width * 0.015,
            topMargin: 0.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: upComingMovies(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    height: Get.height * 0.4,
                    width: Get.width,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        snapshot.data!.results!.length,
                        (index) => Container(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.28,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.025,
                                    vertical: Get.height * 0.01,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => BlocProvider.value(
                                          value: BlocProvider.of<FavoriteBloc>(
                                              context),
                                          child: detailPage(
                                            title: snapshot
                                                .data!.results![index].title
                                                .toString(),
                                            rating: snapshot.data!
                                                .results![index].voteAverage!
                                                .round()
                                                .toString(),
                                            movie_id: snapshot
                                                .data!.results![index].id!
                                                .toString(),
                                            noOfGenres: snapshot
                                                .data!
                                                .results![index]
                                                .genreIds!
                                                .length,
                                            imagetitle:
                                                'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath}',
                                          ),
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
                                width: Get.width * 0.3,
                                child: Text(
                                  snapshot.data!.results![index].title
                                      .toString(),
                                  softWrap: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
