import 'package:flutter/material.dart';
import 'package:get/get.dart';

class detailPage extends StatefulWidget {
  final String imagetitle;
  const detailPage({super.key, required this.imagetitle});

  @override
  State<detailPage> createState() => _detailPageState();
}

class _detailPageState extends State<detailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Hero(
              tag: widget.imagetitle,
              child: Container(
                height: Get.height * 0.5,
                width: Get.width,
                child: Image.network(widget.imagetitle),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
