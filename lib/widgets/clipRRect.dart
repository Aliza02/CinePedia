
import 'package:flutter/material.dart';

class clipRRect extends StatelessWidget {
  final String imageAddress;
  const clipRRect({super.key, required this.imageAddress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(

        cacheWidth: 372,
        cacheHeight: 558,
        imageAddress,
        fit: BoxFit.cover,
      ),
    );
  }
}
