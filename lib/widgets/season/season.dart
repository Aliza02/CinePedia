import 'dart:convert';
import 'package:cinepedia/model/nowPlaying.dart';
import 'package:cinepedia/model/seasonDetail.dart';
import 'package:cinepedia/model/seriesList.dart';
import 'package:cinepedia/screens/detailPage.dart';
import 'package:cinepedia/screens/seasonDetail.dart';
import 'package:cinepedia/screens/seriesDetailPage.dart';
import 'package:cinepedia/widgets/clipRRect.dart';
import 'package:cinepedia/widgets/headings.dart';
import 'package:cinepedia/widgets/shimmerContainer.dart';
import 'package:cinepedia/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class season extends StatefulWidget {
  const season({super.key});

  @override
  State<season> createState() => _seasonState();
}

class _seasonState extends State<season> {
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzllMGI1ZjU3NTM2NGMxNTcxOGQzMGUzYjhhMWYzNCIsInN1YiI6IjY1NzVlNDYzYzYwMDZkMDEwMjdjNDY5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eSiiMzHd8w1P3rWFCQFHxqQnzbsx-c-TAFaezaPA2x8';

  Future<seasonDetail> getSeasons() async {
    final result = Uri.parse("https://api.themoviedb.org/3/discover/tv");
    final response = await http.get(result, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return seasonDetail.fromJson(jsonDecode(response.body));
    } else {
      return seasonDetail.fromJson(jsonDecode(response.body));
    }
  }

  @override
  void initState() {
    super.initState();
    getSeasons();
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
              title: 'Seasons',
              leftMargin: Get.width * 0.015,
              topMargin: Get.height * 0.01,
            ),
            Expanded(
              child: FutureBuilder(
                future: getSeasons(),
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
                                            () => seasonDetailPage(
                                                imagetitle:
                                                    'https://image.tmdb.org/t/p/w500${snapshot.data!.results![index].posterPath}',
                                                seriesId: snapshot
                                                    .data!.results![index].id
                                                    .toString(),
                                               overview: snapshot.data!.results![index].overview.toString(),
                                                title: snapshot
                                                    .data!.results![index].name
                                                    .toString(),
                                                    originalLanguage: snapshot.data!.results![index].originalLanguage.toString(),
                                                rating: '8'),
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