import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Authentication/auth_screen.dart';
import 'package:sports_app/Global/global.dart';

import '../Authentication/login.dart';
import '../Authentication/registration.dart';
import '../home_sub_screens/player_screen.dart';
import '../home_sub_screens/private_tournament_search_screen.dart';
import '../home_sub_screens/teams_screen.dart';
import '../home_sub_screens/tournament_showing_screen.dart';
import '../home_sub_screens/vanue_screen.dart';
import '../models/user_detail_model.dart';

class Home_screen extends StatefulWidget {

  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  var _chosenValue;
  void _showDecline() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return AlertDialog(
              title: new Text("SEARCH TOURNAMENT WITH"),
              content: Container(
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Text("Search With"),
                        DropdownButton<String>(
                          hint: Text('Select one option'),
                          value: _chosenValue,
                          underline: Container(

                          ),
                          items: <String>[
                            'Tournament_Name',
                            'id',
                            'format',
                            'Entry_Fees'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.w200),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _chosenValue = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                TextButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: new Text("ok"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Private_Tournament_search_screen(data: _chosenValue,)));
                  },
                ),
              ],
            );
          },

        );
      },
    );
  }
  User? currentuser;
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(length:3,
        child: Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _showDecline();

                      },
                      icon: Icon(Icons.search_outlined)),
                ],
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.black26,
            title: Text("Go Tournamentt",
            ),centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "Tournaments",icon: Icon(Icons.celebration),),
                Tab(text: "Team",icon: Icon(Icons.group),),
                // Tab(text: "Players",icon: Icon(Icons.person),),
                Tab(text: "Place",icon: Icon(Icons.place),)
              ],
            ),),
          body: Container(
            child: TabBarView(
              children: [
                Tournament_home_screen(),
                Teams_screen(),
                // player_screen(),
                Vanue_screen()
              ],
            ),
          ),
        ));
  }
}
