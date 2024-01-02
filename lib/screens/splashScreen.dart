import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cinepedia/bloc/addToFavouriteBloc.dart';
import 'package:cinepedia/bloc/categoryBloc.dart';
import 'package:cinepedia/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as GetTransitions;

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  double width = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(
          duration: const Duration(milliseconds: 800),
          transition: GetTransitions.Transition.leftToRightWithFade,
          () => MultiBlocProvider(providers: [
                BlocProvider(
                  create: (context) => ButtonBloc(),
                ),
                BlocProvider(
                  create: (context) => FavoriteBloc(),
                ),
              ], child: const home_screen()));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cine',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.width * 0.1,
                  fontFamily: 'Kalnia',
                  fontWeight: FontWeight.normal),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  cursor: String.fromCharCode(9612),
                  speed: const Duration(milliseconds: 200),
                  'pedia',
                  textStyle: TextStyle(
                      fontSize: Get.width * 0.1,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Kalnia',
                      color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
