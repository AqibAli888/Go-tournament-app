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

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.35,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(0, 5), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(5)
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
                                          Text(match_detail_model.team0.toString(),style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),),

                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            height: MediaQuery.of(context).size.height * 0.08,
                                            child: Image.asset("animation/election.png"),),
                                          Text(match_detail_model.team1.toString(),style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),),

                                        ],
                                      ),
                                      subtitle: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 25),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.25,
                                                    height: MediaQuery.of(context).size.height * 0.05,
                                                    child: Image.asset("animation/calendar(1).png"),),
                                                  Text(match_detail_model.Date.toString(),style: TextStyle(
                                                      color: Colors.white
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                      height: MediaQuery.of(context).size.height * 0.05,
                                                      child: Image.asset("animation/clock.png"),),
                                                    Text("At ",style: TextStyle(
                                                        color: Colors.white
                                                    )),
                                                    Text(match_detail_model.Time.toString(),style: TextStyle(
                                                        color: Colors.white
                                                    )),
                                                    SizedBox(width: 10,),

                                                  ],
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 25),
                                              child: Text(match_detail_model.result.toString()==null.toString()?"Result not added":match_detail_model.result.toString(),style: TextStyle(
                                                  color: Colors.white
                                              )),
                                            ),
                                            Row(
                                              children: [

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  )
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
    );
  }
}
