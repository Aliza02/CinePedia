import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinepedia/bloc/categoryBloc.dart';
import 'package:cinepedia/model/popularMovies.dart';
import 'package:cinepedia/screens/detailPage.dart';
import 'package:cinepedia/widgets/appBar.dart';
import 'package:cinepedia/widgets/clipRRect.dart';
import 'package:cinepedia/widgets/headings.dart';
import 'package:cinepedia/widgets/home/categories_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scaled_list/scaled_list.dart';

class home_screen extends StatefulWidget {
  final String tag;
  const home_screen({super.key, required this.tag});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  List<String> chipTitle = ['Home', 'Movies', 'Series', 'Shows'];
  List<popularMovies> popular_movies = [];
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNWJjMGE0Njc4ZTA3YzYxODdlNmVlMjZlYTI3NDRkMiIsInN1YiI6IjY1NzVlNDYzYzYwMDZkMDEwMjdjNDY5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.guF3X4pUfdGX3Dy19x7n6jRkjc6wNQsB_0PboH9qVMM';

  Future<popularMovies> getPopularMovies() async {
    final result = Uri.parse('https://api.themoviedb.org/3/movie/popular');
    final response = await http.get(result, headers: {
      'Authorization': 'Bearer ${accessToken}',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final finalResult = jsonDecode(response.body.toString());
      return popularMovies.fromJson(finalResult);
    } else {
      throw Exception('Failed to load movies');
    }

    // print(result);
  }

  Future<popularMovies> nowPlayingMovies() async {
    final result = Uri.parse('https://api.themoviedb.org/3/movie/upcoming');
    final response = await http.get(result, headers: {
      'Authorization': 'Bearer ${accessToken}',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final finalResult = jsonDecode(response.body.toString());
      return popularMovies.fromJson(finalResult);
    } else {
      throw Exception('Failed to load movies');
    }

    // print(result);
  }

  @override
  void initState() {
    super.initState();
    getPopularMovies();
    nowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const appBar(),
        body: BlocProvider(
          create: (context) => ButtonBloc(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: Get.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        4,
                        (index) {
                          return categories_chips(
                            title: chipTitle[index],
                            index: index,
                            categoryKey: chipTitle[index],
                          );
                        },
                      ),
                    ),
                  ),
                  section_heading(
                    title: 'Most Popular',
                    leftMargin: Get.width * 0.015,
                    topMargin: Get.height * 0.01,
                  ),
                  FutureBuilder(
                    future: getPopularMovies(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
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
                            return Container(
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
                      future: nowPlayingMovies(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
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
                                              print('goto');
                                              Get.to(
                                                () => detailPage(
                                                  imagetitle:
                                                      'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath}',
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
            ),
          ),
        ),
      ),
    );
  }
}
