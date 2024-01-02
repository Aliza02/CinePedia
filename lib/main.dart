import 'dart:convert';
// import 'package:cinepedia/bloc/categoriesBloc/categoriesBloc.dart';
import 'package:cinepedia/bloc/addToFavouriteBloc.dart';
import 'package:cinepedia/bloc/categoryBloc.dart';
import 'package:cinepedia/model/popularMovies.dart';
import 'package:cinepedia/screens/homeScreen.dart';
import 'package:cinepedia/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF2D2A2A),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF2D2A2A),
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ButtonBloc(),
          ),
          BlocProvider(
            create: (context) => FavoriteBloc(),
          ),
        ],
        child: home_screen(tag: 'dasd',)),
      // const home_screen(tag: 'add'),
    );
  }
}
