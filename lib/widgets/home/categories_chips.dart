import 'package:cinepedia/bloc/categoryBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class categories_chips extends StatefulWidget {
  final String title;
  final int index;
  final String categoryKey;
  const categories_chips({
    super.key,
    required this.title,
    required this.index,
    required this.categoryKey,
  });

  @override
  State<categories_chips> createState() => _categories_chipsState();
}

class _categories_chipsState extends State<categories_chips> {
  ButtonEvent getEvent(int index) {
    switch (index) {
      case 0:
        return ButtonEvent.ButtonEvent1;
      case 1:
        return ButtonEvent.ButtonEvent2;
      case 2:
        return ButtonEvent.ButtonEvent3;
      case 3:
        return ButtonEvent.ButtonEvent4;
      default:
        throw Exception('Invalid index');
    }
  }

  void initState(){
    super.initState();
    BlocProvider.of<ButtonBloc>(context).add(getEvent(0));
  }

  @override
  Widget build(BuildContext context) {
    //  final selected=( widget.state is ButtonSelectedState ==widget.index)
    return BlocBuilder<ButtonBloc, ButtonState>(
        // stream: null,
        builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: (state is ButtonSelectedState) &&
                    widget.index == state.selectedButtonIndex
                ? Colors.red
                : Colors.transparent,
            elevation: 20.0,
            shape: RoundedRectangleBorder(
              side: (state is ButtonSelectedState) &&
                      widget.index == state.selectedButtonIndex
                  ? BorderSide.none
                  : const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
          ),
          onPressed: () {
            // print('add');
            BlocProvider.of<ButtonBloc>(context).add(getEvent(widget.index));
          },
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
