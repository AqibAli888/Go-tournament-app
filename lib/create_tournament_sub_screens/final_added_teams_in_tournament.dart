import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Global/global.dart';
import '../models/New_Tournament_create_model.dart';
import '../models/final_added_teams_in_tournament_model.dart';
import '../models/match_detail_model.dart';
import '../models/team_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';

class Final_added_teams_in_tournament extends StatefulWidget {
  final New_Tournament_model new_tournament_model;
  const Final_added_teams_in_tournament({Key? key, required this.new_tournament_model}) : super(key: key);

  @override
  State<Final_added_teams_in_tournament> createState() => _Final_added_teams_in_tournamentState();
}

class _Final_added_teams_in_tournamentState extends State<Final_added_teams_in_tournament> {
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
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(firebaseAuth.currentUser!.uid)
            .collection("Tournaments").doc(widget.new_tournament_model.Tournament_Name).collection("Teams_in_Tournament")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Final_added_teams final_added_teams = Final_added_teams.fromJson(snapshot.data!.docs[index]
                        .data()! as Map<String, dynamic>);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 10,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(706, 112, 107, 107),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: ListTile(
                                trailing: SizedBox(
                                  width: MediaQuery.of(context).size.width*0.35,
                                  child:Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    
                                    child: TextButton(onPressed: ()async{
                                      await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(firebaseAuth.currentUser!.uid)
                                            .collection("Tournaments").
                                        doc(widget.new_tournament_model.
                                        Tournament_Name).collection("Teams_in_Tournament").doc(final_added_teams.Team_Name).delete();

                                    }, child:Text("Remove Team",style:  TextStyle(color: Colors.black),)),
                                  )
                                ),
                                focusColor: Colors.red,
                                title: Text(final_added_teams.Team_Name.toString()),
                                subtitle: Text(final_added_teams.Level.toString()),
                                onTap: () {
                                }),
                          ),
                        ],
                      ),
                    );
                  }
                  ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
