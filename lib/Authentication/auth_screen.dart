import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Authentication/registration.dart';

import '../models/user_detail_model.dart';
import 'login.dart';
class Auth_screen extends StatefulWidget {
  const Auth_screen({Key? key}) : super(key: key);

  @override
  State<Auth_screen> createState() => _Auth_screenState();
}

class _Auth_screenState extends State<Auth_screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length:2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 5,
            backgroundColor: Colors.transparent,
            title: Text("Go Tournament"),centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "login",icon: Container(child: Icon(Icons.lock)),),
              Tab(text: "Signup",icon: Icon(Icons.app_registration),)
            ],
          ),),
          body: Container(
            child: TabBarView(
              children: [
                Login(),
                Registration()
              ],
            ),
          ),
        ));
  }
}
