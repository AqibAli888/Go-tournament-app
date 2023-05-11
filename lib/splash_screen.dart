import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_app/Global/global.dart';
import 'package:sports_app/main_screens/home_screen.dart';

import 'Authentication/auth_screen.dart';
import 'main_screens/option_screen_for_public_private.dart';
class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      if(firebaseAuth.currentUser!.emailVerified==false){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth_screen()));
      }
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Option_Screen()));
      }

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.height*0.8,
              child:Lottie.asset("animation/trophy.json")
          ),
          Center(
            child: Container(
              child: Text(
                "Go Tournament",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                "Tournament Scheduling App",
                style: TextStyle(fontSize: 10, color: Colors.black,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
