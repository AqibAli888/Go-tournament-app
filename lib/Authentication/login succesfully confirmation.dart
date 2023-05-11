import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main_screens/option_screen_for_public_private.dart';
class Successfully_Login extends StatefulWidget {
  const Successfully_Login({Key? key}) : super(key: key);

  @override
  State<Successfully_Login> createState() => _Successfully_LoginState();
}

class _Successfully_LoginState extends State<Successfully_Login> {

  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Option_Screen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child:Lottie.asset("animation/96957-lock.json")
            ),
          )
        ],
      ),
    );;
  }
}
