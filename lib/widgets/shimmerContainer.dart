import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class shimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final double horizontalMargin;
  final double verticalMargin;
  const shimmerContainer({
    super.key,
    required this.height,
    required this.width,
    required this.horizontalMargin,
    required this.verticalMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: const Color.fromARGB(255, 132, 125, 125),
      highlightColor: const Color.fromARGB(255, 96, 93, 93),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 116, 111, 111),
          borderRadius: BorderRadius.circular(Get.width * 0.06),
        ),
      ),
    );
  }
}
