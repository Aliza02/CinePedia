import 'package:cinepedia/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  double width = 0.0;
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => home_screen()));
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
  }

  void setWidth() {
    setState(() {
      width = 100.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF2D2A2A),
      // backgroundColor: Colors.red,

      body: Hero(
        tag:'logo',
        child: InkWell(
          onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => home_screen(tag: 'logo',)));

            // Future.delayed(Duration(milliseconds: 300));
            // Navigator.of(context).push(PageRouteBuilder(
            //   transitionDuration: Duration(milliseconds: 500),
            //     pageBuilder: (context,_,__) => home_screen(
            //           tag: "logo",
            //         )));
          },
          child:Center(
            child: Image.asset('assets/images/Capture.PNG',
            height: 100,
            width: 100,
            ),
          )
        ),
      ),
    );
  }
}
