import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Global/global.dart';
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
    DocumentReference all_tournament_ref=FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name);

    DocumentReference pri_tournament_ref=FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              width:MediaQuery.of(context).size.width*0.9 ,
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
                          GestureDetector(
                            onTap:(){

                              pri_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team0"])
                                    .update({
                                  "point": FieldValue.increment(2),
                                  "played": FieldValue.increment(1)
                                });


                              pri_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team1"])
                                    .update({"played": FieldValue.increment(1)});

                                all_tournament_ref.collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team0"])
                                    .update({
                                  "point": FieldValue.increment(2),
                                  "win": FieldValue.increment(1),
                                  "played": FieldValue.increment(1)
                                });


                                all_tournament_ref
                                    .collection("Teams_in_Tournament")
                                    .doc(snapshot.data["team1"])
                                    .update({"played": FieldValue.increment(1)});



                              pri_tournament_ref
                                    .collection("Tournament_schedule")
                                    .doc(widget.match_detail_model.id)
                                    .update({"result":snapshot.data["team0"]+" win the match" });


                                all_tournament_ref
                                    .collection("Tournament_schedule")
                                    .doc(widget.match_detail_model.id)
                                    .update({"result":snapshot.data["team0"]+" win the match" });





                              }
   ,
                              child: Text(snapshot.data["team0"])),
                          GestureDetector(onTap:(){
                            pri_tournament_ref
                                .collection("Teams_in_Tournament")
                                .doc(snapshot.data["team1"])
                                .update({
                              "point": FieldValue.increment(2),
                              "win": FieldValue.increment(1),
                              "played": FieldValue.increment(1)
                            });


                            pri_tournament_ref
                                .collection("Teams_in_Tournament")
                                .doc(snapshot.data["team0"])
                                .update({"played": FieldValue.increment(1)});

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
                                .update({"played": FieldValue.increment(1)});



                            pri_tournament_ref
                                .collection("Tournament_schedule")
                                .doc(widget.match_detail_model.id)
                                .update({"result":snapshot.data["team1"]+" win the match" });


                            all_tournament_ref
                                .collection("Tournament_schedule")
                                .doc(widget.match_detail_model.id)
                                .update({"result":snapshot.data["team1"]+" win the match" });







                          },
                              child: Text(snapshot.data["team1"])),
                          GestureDetector(onTap:(){
                            pri_tournament_ref
                                .collection("Teams_in_Tournament")
                                .doc(snapshot.data["team1"])
                                .update({
                              "point": FieldValue.increment(1),
                              "played": FieldValue.increment(1)
                            });


                            pri_tournament_ref
                                .collection("Teams_in_Tournament")
                                .doc(snapshot.data["team0"])
                                .update({"played": FieldValue.increment(1),"point": FieldValue.increment(1),});

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
                                .update({"point": FieldValue.increment(1),
                              "played": FieldValue.increment(1)});



                            pri_tournament_ref
                                .collection("Tournament_schedule")
                                .doc(widget.match_detail_model.id)
                                .update({"result":"Draw " });


                            all_tournament_ref
                                .collection("Tournament_schedule")
                                .doc(widget.match_detail_model.id)
                                .update({"result":"Draw " });







                          },
                              child: Text("Draw")),
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
