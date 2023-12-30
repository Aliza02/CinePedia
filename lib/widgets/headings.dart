import 'package:flutter/material.dart';
import 'package:get/get.dart';

class section_heading extends StatelessWidget {
  final String title;
  final double leftMargin;
  final double topMargin;
  const section_heading(
      {super.key,
      required this.title,
      required this.leftMargin,
      required this.topMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: leftMargin,
        top: topMargin,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: Get.width * 0.06,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
