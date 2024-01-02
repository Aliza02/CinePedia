import 'package:cinepedia/bloc/addToFavouriteBloc.dart';
import 'package:cinepedia/bloc/addToFavouriteEvent.dart';
import 'package:cinepedia/bloc/addToFavouritesState.dart';
import 'package:cinepedia/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class favourites extends StatefulWidget {
  const favourites({super.key});

  @override
  State<favourites> createState() => _favouritesState();
}

class _favouritesState extends State<favourites> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                top: Get.height * 0.02,
                left: Get.width * 0.03,
              ),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: Get.width * 0.06,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: Get.height * 0.02,
                left: Get.width * 0.06,
                bottom: Get.height * 0.02,
              ),
              alignment: Alignment.centerLeft,
              child: text(
                  title: 'Favourites',
                  fontSize: Get.width * 0.08,
                  fontWeight: FontWeight.w400),
            ),
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state is FavoritesLoading) {
                  return const CircularProgressIndicator();
                } else if (state is FavoritesLoaded) {
                  if (state.favoriteItems.isEmpty) {
                    return Expanded(
                      child: SizedBox(
                        height: Get.height,
                        child: Center(
                          child: text(
                              title: 'No Favourites',
                              fontSize: Get.width * 0.05,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.favoriteItems.length,
                        itemBuilder: (context, index) {
                          final itemId = state.favoriteItems[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.width * 0.01),
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.04),
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 139, 134, 134)
                                      .withOpacity(0.2),
                              textColor: Colors.white,
                              trailing: InkWell(
                                onTap: () {
                                  BlocProvider.of<FavoriteBloc>(context).add(
                                    RemoveFromFavorites(index),
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.03),
                              ),
                              title: Text(itemId.title),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else if (state is FavoritesError) {
                  return Text('Error: ${state.error}');
                } else {
                  return const Text('Unknown State');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
