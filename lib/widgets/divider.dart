import 'package:flutter/material.dart';

class divider extends StatelessWidget {
  const divider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 10.0,
      endIndent: 10.0,
      color: Colors.grey,
    );
  }
}
