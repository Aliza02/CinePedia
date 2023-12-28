import 'package:flutter/material.dart';

class text extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  const text({
    super.key,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        color: Color.fromARGB(255, 228, 222, 222),
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
