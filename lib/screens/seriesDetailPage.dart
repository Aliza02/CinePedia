import 'dart:convert';

import 'package:cinepedia/model/details.dart';
import 'package:cinepedia/widgets/clipRRect.dart';
import 'package:cinepedia/widgets/divider.dart';
import 'package:cinepedia/widgets/shimmerContainer.dart';
import 'package:cinepedia/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class seriesDetailPage extends StatefulWidget {
  final String imagetitle;
  final String title;
  final String rating;
  final String seriesId;
  final int noOfGenres;
  const seriesDetailPage(
      {super.key,
      required this.imagetitle,
      required this.seriesId,
      required this.noOfGenres,
      required this.title,
      required this.rating});

  @override
  State<seriesDetailPage> createState() => _seriesDetailPageState();
}

class _seriesDetailPageState extends State<seriesDetailPage> {
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzllMGI1ZjU3NTM2NGMxNTcxOGQzMGUzYjhhMWYzNCIsInN1YiI6IjY1NzVlNDYzYzYwMDZkMDEwMjdjNDY5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eSiiMzHd8w1P3rWFCQFHxqQnzbsx-c-TAFaezaPA2x8';

  Future<details> loadingDetails() async {
    final result =
        Uri.parse("https://api.themoviedb.org/3/tv/${widget.seriesId}");
    final response = await http.get(result, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return details.fromJson(jsonDecode(response.body));
    } else {
      return details.fromJson(jsonDecode(response.body));
    }
  }

  @override
  void initState() {
    super.initState();
    loadingDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Hero(
                    tag: widget.imagetitle,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      height: Get.height * 0.4,
                      child: clipRRect(imageAddress: widget.imagetitle),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: Get.width * 0.7,
                      padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.01,
                      ),
                      child: text(
                        title: widget.title,
                        fontSize: Get.width * 0.06,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(Icons.star,
                        color: Color.fromARGB(255, 228, 206, 7)),
                    text(
                      title: "${widget.rating}/10",
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                FutureBuilder(
                  future: loadingDetails(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: List.generate(
                              widget.noOfGenres,
                              (index) => shimmerContainer(
                                height: Get.height * 0.045,
                                width: Get.width * 0.2,
                                horizontalMargin: 6.0,
                                verticalMargin: 0.0,
                              ),
                            ),
                          ),
                          shimmerContainer(
                            height: Get.height * 0.25,
                            width: Get.width,
                            horizontalMargin: 6.0,
                            verticalMargin: 10.0,
                          ),
                          shimmerContainer(
                            height: Get.height * .1,
                            width: Get.width,
                            horizontalMargin: 6.0,
                            verticalMargin: 10.0,
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            child: Row(
                              children: List.generate(
                                snapshot.data!.genres!.length,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  // height: Get.height * 0.06,
                                  padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.005,
                                    horizontal: Get.width * 0.03,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(Get.width * 0.06),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: text(
                                    title: snapshot.data!.genres![index].name
                                        .toString(),
                                    fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.03,
                              vertical: Get.height * 0.025,
                            ),
                            child: Text(
                              snapshot.data!.overview.toString(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.width * 0.04,
                              ),
                            ),
                          ),
                          const divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: text(
                                    title: 'Release Date',
                                    fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.3,
                                  child: text(
                                    title:
                                        snapshot.data!.releaseDate.toString(),
                                    fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: text(
                                    title: 'Original Language',
                                    fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.3,
                                  child: text(
                                    title: snapshot.data!.originalLanguage
                                        .toString(),
                                    fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: text(
                                    title: 'Production Companies',
                                    fontSize: Get.width * 0.04,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot
                                        .data!.productionCompanies!.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        // width: Get.width * 0.3,
                                        child: text(
                                          title: snapshot.data!
                                              .productionCompanies![index].name
                                              .toString(),
                                          fontSize: Get.width * 0.04,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const divider(),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
