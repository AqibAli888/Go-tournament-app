import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/all_tournament_showing_model.dart';
import '../../models/final_added_teams_in_tournament_model.dart';
class Teams_added_in_Tournament extends StatefulWidget {
  final All_Tournament_Showing_model all_tournament_showing_model;
  const Teams_added_in_Tournament(
      {Key? key, required this.all_tournament_showing_model})
      : super(key: key);

  @override
  State<Teams_added_in_Tournament> createState() =>
      _Teams_added_in_TournamentState();
}

class _Teams_added_in_TournamentState extends State<Teams_added_in_Tournament> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("All_Tournaments")
                    .doc(widget.all_tournament_showing_model.Tournament_Name)
                    .collection("Teams_in_Tournament")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    // shows tournaments if the tournament exists
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Final_added_teams final_added_teams =
                                Final_added_teams.fromJson(
                                    snapshot.data!.docs[index].data()!
                                        as Map<String, dynamic>);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 10,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.125,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(706, 112, 107, 107),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: ListTile(
                                        trailing: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width*0.05,
                                          // to enter the
                                          // delete and updaate icon
                                          child: Row(
                                            children: [],
                                          ),
                                        ),
                                        focusColor: Colors.red,
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              final_added_teams.Team_Name.toString(),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              final_added_teams.Level.toString(),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
