import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Authentication/auth_screen.dart';
import 'Global/global.dart';
import 'main_screens/option_screen_for_public_private.dart';

class New_splsh_Screen extends StatefulWidget {
  const New_splsh_Screen({Key? key}) : super(key: key);

  @override
  State<New_splsh_Screen> createState() => _New_splsh_ScreenState();
}

class _New_splsh_ScreenState extends State<New_splsh_Screen> {

  void initState() {
    Future.delayed(const Duration(seconds: 3), () {


      if(firebaseAuth.currentUser!=null){
        if(firebaseAuth.currentUser!.emailVerified==true){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Option_Screen()));

        }
        else
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Auth_screen()));

        }



      }
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth_screen()));
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
