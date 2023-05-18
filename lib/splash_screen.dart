// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'Authentication/auth_screen.dart';
// class Splash_screen extends StatefulWidget {
//   const Splash_screen({Key? key}) : super(key: key);
//   //
//   @override
//   State<Splash_screen> createState() => _Splash_screenState();
// }
//
// class _Splash_screenState extends State<Splash_screen> {
//
//
//   @override
//
//   // void initState() {
//   //   super.initState();
//   //   Timer(
//   //       Duration(seconds: 3),
//   //           () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//   //           builder: (BuildContext context) => Auth_screen())));
//   // }
//
//
//
//
//   void initState() {
//     Future.delayed(const Duration(seconds: 4), () {
//
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Auth_screen()));
//       // if(firebaseAuth.currentUser==null){
//       //
//       // }
//       // else {
//       //   Navigator.push(
//       //       context, MaterialPageRoute(builder: (context) => Option_Screen()));
//       // }
//
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//               height: MediaQuery.of(context).size.height*0.8,
//               child:Lottie.asset("animation/trophy.json")
//           ),
//           Center(
//             child: Container(
//               child: Text(
//                 "Go Tournament",
//                 style: TextStyle(fontSize: 30, color: Colors.black),
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               child: Text(
//                 "Tournament Scheduling App",
//                 style: TextStyle(fontSize: 10, color: Colors.black,),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
