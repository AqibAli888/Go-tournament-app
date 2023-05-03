import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/all_tournament_showing_model.dart';
import '../../models/match_detail_model.dart';
class Match_schedule_result_screen_public extends StatefulWidget {
  final All_Tournament_Showing_model all_Tournament_Showing_model;
  const Match_schedule_result_screen_public({Key? key, required this.all_Tournament_Showing_model}) : super(key: key);

  @override
  State<Match_schedule_result_screen_public> createState() => _Match_schedule_result_screen_publicState();
}

class _Match_schedule_result_screen_publicState extends State<Match_schedule_result_screen_public> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          StreamBuilder(
            stream:FirebaseFirestore.instance
                .collection("All_Tournaments").doc(widget.all_Tournament_Showing_model.Tournament_Name).
            collection("Tournament_schedule")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                // shows tournaments if the tournament exists
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Match_Detail_model match_detail_model =Match_Detail_model.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 10,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.25,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: ListTile(
                                    trailing: SizedBox(
                                      width: MediaQuery.of(context).size.width*0.00001,
                                      child: Row(
                                        children:  [

                                        ],
                                      ),
                                    ),
                                    focusColor: Colors.red,
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(match_detail_model.team0.toString()),

                                        Text("VS"),
                                        Text(match_detail_model.team1.toString()),

                                      ],
                                    ),
                                    subtitle: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(match_detail_model.Date.toString()),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("At "),
                                                Text(match_detail_model.Time.toString()),
                                                SizedBox(width: 10,),
                                                Icon(Icons.access_time)
                                              ],
                                            ),
                                          ),

                                          Text(match_detail_model.result.toString()==null.toString()?"Result not added":match_detail_model.result.toString()),
                                          Row(
                                            children: [

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                )
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
    );
  }
}
