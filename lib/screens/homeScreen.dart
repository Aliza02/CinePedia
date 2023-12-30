import 'package:cinepedia/bloc/categoryBloc.dart';
import 'package:cinepedia/widgets/appBar.dart';
import 'package:cinepedia/widgets/home/categories_chips.dart';
import 'package:cinepedia/widgets/home/homeMovies.dart';
import 'package:cinepedia/widgets/movies/movies.dart';
import 'package:cinepedia/widgets/series/series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class home_screen extends StatefulWidget {
  final String tag;
  const home_screen({super.key, required this.tag});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  List<String> chipTitle = ['Home', 'Movies', 'Series', 'Shows'];
  // List<popularMovies> popular_movies = [];
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzllMGI1ZjU3NTM2NGMxNTcxOGQzMGUzYjhhMWYzNCIsInN1YiI6IjY1NzVlNDYzYzYwMDZkMDEwMjdjNDY5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eSiiMzHd8w1P3rWFCQFHxqQnzbsx-c-TAFaezaPA2x8';

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
                  BlocBuilder<ButtonBloc, ButtonState>(
                    builder: (context, state) {
                      if (state is ButtonSelectedState &&
                          state.selectedButtonIndex == 0) {
                        return const Expanded(
                          child: homeMovies(),
                        );
                      } else if (state is ButtonSelectedState &&
                          state.selectedButtonIndex == 1) {
                        return const Expanded(
                          child: movies(),
                        );
                      } else if (state is ButtonSelectedState &&
                          state.selectedButtonIndex == 2) {
                        return const Expanded(
                          child: series(),
                        );
                      } else {
                        return Container();
                      }
                    },
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
