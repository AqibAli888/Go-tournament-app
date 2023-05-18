// need to change error image only


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/models/team_model.dart';

import '../Global/global.dart';
import '../models/Main_Player_model.dart';
import '../models/New_Tournament_create_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/text_form_field.dart';

class Teams_in_Tournament extends StatefulWidget {
  final New_Tournament_model new_tournament_model;
  const Teams_in_Tournament({Key? key, required this.new_tournament_model})
      : super(key: key);

  @override
  State<Teams_in_Tournament> createState() => _Teams_in_TournamentState();
}

class _Teams_in_TournamentState extends State<Teams_in_Tournament> {
  TextEditingController teamnamecontroller = TextEditingController();
  TextEditingController levelcontroller = TextEditingController();
  TextEditingController shirtnumber = TextEditingController();
  formvalidation() {
    if (teamnamecontroller.text.trim().isNotEmpty) {
      //login
      Adding_team();
    } else {
      showDialog(context: context, builder: (c) {
        return Error_Dialog(message: "Please Fill all the fields",path:"animation/95614-error-occurred.json");
      });
    }
  }

  Adding_team() async {
    showDialog(context: context, builder: (c) {
      return Loading_Dialog(message: 'Please wait',
        path:"animation/97930-loading.json" ,);
    });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Teams")
        .doc(teamnamecontroller.text)
        .set({
      "Name": teamnamecontroller.text,
      "level": levelcontroller.text,
      "Added": "Team not added to tournament"
    }).then((value) async {
      await sharedpreference!
          .setString("Team_Name", teamnamecontroller.text.trim());
      await sharedpreference!.setString("level", levelcontroller.text.trim());
      Navigator.pop(context);
    });
  }
  Updaate_team(String teamname,String result) async {
    showDialog(context: context, builder: (c) {
      return Loading_Dialog(message: 'Please wait',
        path:"animation/97930-loading.json" ,);
    });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(
        firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model
        .Tournament_Name)
        .collection("Teams_in_Tournament").doc(teamname)
        .update({
      "added":result
    }).then((value) async {
      await sharedpreference!
          .setString("Team_Name", teamnamecontroller.text.trim());
      await sharedpreference!.setString("level", levelcontroller.text.trim());
      Navigator.pop(context);
    });
  }

  double slidervalue = 20;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Text(
                      "Tap on The teams to add on the Tournament",
                        style: TextStyle(
                    color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    )
                    ),
                    Image.asset("animation/touch-screen.png",height:MediaQuery.of(context).size.height*0.1
                      ,width:MediaQuery.of(context).size.width*0.2 ,),
                  ],
                ),
              ),
            ),
          ),

          // for real time we use stream builder
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(firebaseAuth.currentUser!.uid)
                .collection("Teams")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Team team = Team.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 10,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  trailing: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.00057,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [],
                                    ),
                                  ),
                                  focusColor: Colors.red,
                                  title: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(team.Name.toString(),style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ))
                                    ],
                                  ),
                                  onTap: () {
                                    showDialog(context: context, builder: (c) {
                                      return Loading_Dialog(message: 'Please wait',
                                        path:"animation/97930-loading.json" ,);
                                    });

                                    FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(firebaseAuth.currentUser!.uid)
                                        .collection("Tournaments")
                                        .doc(widget.new_tournament_model
                                            .Tournament_Name)
                                        .collection("Teams_in_Tournament")
                                        .doc(team.Name)
                                        .set({
                                      "Team_Name": team.Name,
                                      "point": 0,
                                      "played": 0,
                                      "win": 0
                                    });
                                    FirebaseFirestore.instance
                                        .collection("All_Tournaments")
                                        .doc(widget.new_tournament_model
                                            .Tournament_Name)
                                        .collection("Teams_in_Tournament")
                                        .doc(team.Name)
                                        .set({
                                      "Team_Name": team.Name,
                                      "point": 0,
                                      "played": 0,
                                      "win": 0
                                    }).then((value) {
                                      Navigator.pop(context);
                                      showDialog(context: context, builder: (c) {
                                        return Error_Dialog(message: "added succefully",
                                            path:"animation/79952-successful.json");
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return Container();
              }
            },
          ),
// floating action button to add new team to the firebase
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey,
                          shadowColor: Colors.yellow,
                          elevation: 5,
                          scrollable: true,
                          title: Text('Add New Team',style: TextStyle(
                            color: Colors.white
                          ),),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(

                                        color: Colors.black,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(0, 1), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text_form_field(max: 15,
                                        texthint:"Enter Team Name",
                                        data: Icons.group,controller:teamnamecontroller),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                                child: Text("Add",style: TextStyle(
                                  color: Colors.black
                                ),),
                                onPressed: () {
                                  Navigator.pop(context);
                                  formvalidation();
                                  // your code
                                })
                          ],
                        );
                      });
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ),
    );
  }
}
