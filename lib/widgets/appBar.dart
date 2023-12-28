import 'package:flutter/material.dart';

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
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profileImage.jpg',
            
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
