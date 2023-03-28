import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/main_screens/home_screen.dart';

import '../Authentication/auth_screen.dart';
import '../public_tournament_files/All_public_tournament_showing_screen.dart';

class Option_Screen extends StatefulWidget {
  const Option_Screen({Key? key}) : super(key: key);

  @override
  State<Option_Screen> createState() => _Option_ScreenState();
}

class _Option_ScreenState extends State<Option_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    print("private");
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Home_screen()));
                  },
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Center(child: Text("Private"))],
                        )),
                  ),
                ),
                Container(
                  width: 10,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => All_Tournament_showing_screen()));

                  },
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Center(child: Text("Public"))],
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
            ),
            TextButton(onPressed: (){
              FirebaseAuth.instance.signOut().then((value){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Auth_screen()));
              });
            }, child:Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}
