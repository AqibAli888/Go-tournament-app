import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Global/global.dart';
import '../create_tournament_sub_screens/tournament_match_detail.dart';
import '../models/New_Tournament_create_model.dart';
import '../models/match_detail_model.dart';

class Match_result_screen extends StatefulWidget {
  final New_Tournament_model new_tournament_model;
  final Match_Detail_model match_detail_model;
  const Match_result_screen(
      {Key? key,
      required this.new_tournament_model,
      required this.match_detail_model})
      : super(key: key);

  @override
  State<Match_result_screen> createState() => _Match_result_screenState();
}

class _Match_result_screenState extends State<Match_result_screen> {
  @override
  Widget build(BuildContext context) {
    DocumentReference all_tournament_ref = FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name);

    DocumentReference pri_tournament_ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Result"),
        elevation: 10,
        shadowColor: Colors.blue,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              child: StreamBuilder(
                  stream: pri_tournament_ref
                      .collection("Tournament_schedule")
                      .doc(widget.match_detail_model.id)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          // tap on the team that win title
                          Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 7), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Tap On The Team Who Won",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Image.asset(
                                        "animation/touch-screen.png"),
                                  )
                                ],
                              ),
                            ),
                          ),


                          

                          // if team0 win the match
                          GestureDetector(
                              onTap: () {
                                //  if team 0 win then it increase 2 points and played =1
                                //public
                                pri_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team0"])
                                    .update({
                                  "point": FieldValue.increment(2),
                                  "win": FieldValue.increment(1),
                                  "played": FieldValue.increment(1)
                                });

                                pri_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team1"])
                                    .update(
                                        {"played": FieldValue.increment(1)});

                                // in public

                                all_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team0"])
                                    .update({
                                  "point": FieldValue.increment(2),
                                  "win": FieldValue.increment(1),
                                  "played": FieldValue.increment(1)
                                });

                                all_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team1"])
                                    .update(
                                        {"played": FieldValue.increment(1)});

                                pri_tournament_ref
                                    .collection("Tournament_schedule")
                                    .doc(widget.match_detail_model.id)
                                    .update({
                                  "result":
                                      snapshot.data["team0"] + " win the match"
                                }).then((value) {
                                  Navigator.pop(context);
                                });

                                all_tournament_ref
                                    .collection("Tournament_schedule")
                                    .doc(widget.match_detail_model.id)
                                    .update({
                                  "result":
                                      snapshot.data["team0"] + " win the match"
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: Text(snapshot.data["team0"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic)))),
                              )),





                          // if team1 win the match
                          GestureDetector(
                              onTap: () {
                                // private part
                                pri_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team1"])
                                    .update({
                                  "point": FieldValue.increment(2),
                                  "win": FieldValue.increment(1),
                                  "played": FieldValue.increment(1)
                                }).then((value) {
                                  Navigator.pop(context);
                                });

                                pri_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team0"])
                                    .update(
                                        {"played": FieldValue.increment(1)});

                                // publicn part

                                all_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team1"])
                                    .update({
                                  "point": FieldValue.increment(2),
                                  "win": FieldValue.increment(1),
                                  "played": FieldValue.increment(1)
                                });

                                all_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team0"])
                                    .update(
                                        {"played": FieldValue.increment(1)});

                                pri_tournament_ref
                                    .collection("Tournament_schedule")
                                    .doc(widget.match_detail_model.id)
                                    .update({
                                  "result":
                                      snapshot.data["team1"] + " win the match"
                                });

                                all_tournament_ref
                                    .collection("Tournament_schedule")
                                    .doc(widget.match_detail_model.id)
                                    .update({
                                  "result":
                                      snapshot.data["team1"] + " win the match"
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(snapshot.data["team1"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic)),
                                    )),
                              )),







                          // if the match is draw
                          GestureDetector(
                              onTap: () {

                                // public
                                pri_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team1"])
                                    .update({
                                  "point": FieldValue.increment(1),
                                  "played": FieldValue.increment(1)
                                }).then((value) {
                                  Navigator.pop(context);
                                });

                                pri_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team0"])
                                    .update({
                                  "played": FieldValue.increment(1),
                                  "point": FieldValue.increment(1),
                                });




                                //public
                                all_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team1"])
                                    .update({
                                  "point": FieldValue.increment(1),
                                  "played": FieldValue.increment(1)
                                });

                                all_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team0"])
                                    .update({
                                  "point": FieldValue.increment(1),
                                  "played": FieldValue.increment(1)
                                });

                                pri_tournament_ref
                                    .collection("Tournament_schedule")
                                    .doc(widget.match_detail_model.id)
                                    .update({"result": "Draw "});

                                all_tournament_ref
                                    .collection("Tournament_schedule")
                                    .doc(widget.match_detail_model.id)
                                    .update({"result": "Draw "});
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Draw",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    )),
                              )),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
