import 'dart:convert';
// import 'package:cinepedia/bloc/categoriesBloc/categoriesBloc.dart';
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
      home: home_screen(tag: 'dasd',),
      // const home_screen(tag: 'add'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final String apiKey = 'de828dd972c053cdd5bf277e051748fd';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZmFjODc2NTRhMWU4NDFjMDU0N2YzMGYzMmIyYThhZSIsInN1YiI6IjY1NzVlNDYzYzYwMDZkMDEwMjdjNDY5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C8MJebw1CqYSdqBXaub9efKGVJ_qgD8hVAG7QUD_gk0';

  Future<popularMovies> loadingMovies() async {
    final result = Uri.parse('https://api.themoviedb.org/3/movie/popular');
    final response = await http.get(result, headers: {
      'Authorization': 'Bearer ${readAccessToken}',
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
    loadingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder(
            future: loadingMovies(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.results!.length,
                    itemBuilder: (context, index) {
                      return Text(
                        snapshot.data!.results![index].title.toString(),
                      );
                    });
              }
            }),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
