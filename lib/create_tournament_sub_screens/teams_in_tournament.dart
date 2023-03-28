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

class Teams_in_Tournament extends StatefulWidget {
  final New_Tournament_model new_tournament_model;
  const Teams_in_Tournament({Key? key, required this.new_tournament_model}) : super(key: key);

  @override
  State<Teams_in_Tournament> createState() => _Teams_in_TournamentState();
}

class _Teams_in_TournamentState extends State<Teams_in_Tournament> {





  TextEditingController teamnamecontroller = TextEditingController();
  TextEditingController levelcontroller = TextEditingController();
  TextEditingController shirtnumber = TextEditingController();
  formvalidation() {
    if (teamnamecontroller.text.trim().isNotEmpty &&
        levelcontroller.text.isNotEmpty) {
      //login
      Adding_team();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please Enter All textfields',
            );
          });
    }
  }
  Adding_team() async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(
            message: 'Adding Player please wait',
          );
        });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Players")
        .doc(shirtnumber.text)
        .set({
      "shirt_Number":shirtnumber.text,
      "Name": teamnamecontroller.text,
      "level": levelcontroller.text
    }).then((value) async {
      await sharedpreference!.setString("Team_Name", teamnamecontroller.text.trim());
      await sharedpreference!.setString("level", levelcontroller.text.trim());
      Navigator.pop(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                  height: MediaQuery.of(context).size.height * 0.6,
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
                                height: 10,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: ListTile(
                                    trailing: SizedBox(
                                      width: MediaQuery.of(context).size.width*0.57,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:  [

                                          TextButton(onPressed: (){
                                            FirebaseFirestore.instance
                                                .collection("Users")
                                                .doc(firebaseAuth.currentUser!.uid)
                                                .collection("Tournaments").
                                            doc(widget.new_tournament_model.Tournament_Name).collection("Teams_in_Tournament").doc(team.Name).set({
                                              "Team_Name":team.Name,
                                              "Level":team.level,
                                              "point":0,
                                              "played":0,
                                              "win":0
                                            });
                                            FirebaseFirestore.instance
                                                .collection("All_Tournaments").doc(widget.new_tournament_model.Tournament_Name).collection("Teams_in_Tournament")
                                                .doc(team.Name).set({
                                              "Team_Name":team.Name,
                                              "Level":team.level,
                                              "point":0,
                                              "played":0,
                                              "win":0
                                            });

                                          }, child:Text("ADD Team To Tournament",style:  TextStyle(color: Colors.black),)),
                                          // TextButton(onPressed: ()async {
                                          //  await FirebaseFirestore.instance
                                          //       .collection("Users")
                                          //       .doc(firebaseAuth.currentUser!.uid)
                                          //       .collection("Tournaments").
                                          //   doc(widget.new_tournament_model.
                                          //   Tournament_Name).collection("Teams_in_Tournament").doc(team.Name).delete();
                                          //
                                          // }, child:Text("remove")),

                                        ],
                                      ),
                                    ),
                                    focusColor: Colors.red,
                                    title: Text(team.Name.toString()),
                                    subtitle: Text(team.level.toString()),
                                    onTap: () {
                                    }),
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
                          scrollable: true,
                          title: Text('Add New Team'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: teamnamecontroller,
                                    decoration: InputDecoration(
                                      labelText: 'Name of the team',
                                      icon: Icon(Icons.account_box),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: levelcontroller,
                                    decoration: InputDecoration(
                                      labelText: 'level  of the team',
                                      icon: Icon(Icons.email),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: shirtnumber,
                                    decoration: InputDecoration(
                                      labelText: 'Shirt Number',
                                      icon: Icon(Icons.email),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                                child: Text("Submit"),
                                onPressed: () {
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
