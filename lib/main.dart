import 'dart:io';

import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";

import 'package:shared_preferences/shared_preferences.dart';


import 'Global/global.dart';
import 'new_splash_screen.dart';
class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Future main() async {
  HttpOverrides.global = new PostHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();


  sharedpreference=await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
final navigatorKey=GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: New_splsh_Screen(),
    );
  }
}




