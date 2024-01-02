import 'package:cinepedia/bloc/addToFavouriteBloc.dart';
import 'package:cinepedia/screens/favourites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  const appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
      child: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Cine",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Kalnia',
                ),
              ),
              TextSpan(
                text: "Pedia",
                style: TextStyle(
                  color: Color.fromARGB(255, 183, 33, 22),
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Kalnia',
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.to(() => BlocProvider.value(
                    value: BlocProvider.of<FavoriteBloc>(context),
                    child: favourites()));
              },
              child: const Icon(Icons.more_vert, color: Colors.white)),
          
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
