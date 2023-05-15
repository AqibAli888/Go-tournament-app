
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/models/New_Tournament_create_model.dart';

import '../Global/global.dart';

class Standing_tournament extends StatefulWidget {

  final New_Tournament_model new_tournament_model;
  const Standing_tournament({Key? key, required this.new_tournament_model}) : super(key: key);

  @override
  State<Standing_tournament> createState() => _Standing_tournamentState();
}

class _Standing_tournamentState extends State<Standing_tournament> {



  @override
  Widget build(BuildContext context){
    final Stream<QuerySnapshot>teamdata=FirebaseFirestore.instance.collection(
        "Users"
    ).doc(firebaseAuth.currentUser!.uid).collection(
        "Tournaments"
    ).doc(widget.new_tournament_model.Tournament_Name).
    collection("Teams_in_Tournament").orderBy("point",descending: true).snapshots();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: teamdata,
        builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasError){
            print("something is wrong");

          }
          if(snapshot.connectionState==ConnectionState.waiting){
             return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storedat=[];
          snapshot.data!.docs.map((DocumentSnapshot snapshot){
            Map a=snapshot.data() as Map<String,dynamic>;
            storedat.add(a);
          }).toList();
          print(storedat);
          return Container(
            child:SingleChildScrollView(
              child: Table(
                border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.white, style: BorderStyle.solid)),
                columnWidths: const <int,TableColumnWidth>{
                  0:FixedColumnWidth(130)
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: [
                  TableRow(
                      children:[
                        TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Teams",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ) ),
                        TableCell(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Played",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ) ),
                        TableCell(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "win",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ) ),
                        TableCell(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Points",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ) )
                      ]

                  ),

                  for(var i=0;i<storedat.length;i++)...[
                  TableRow(
                      children:[
                        TableCell(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            storedat[i]["Team_Name"],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,color: Colors.white
                            ),
                          ),
                        ) ),
                        TableCell(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            storedat[i]["played"].toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,color: Colors.white
                            ),
                          ),
                        ) ),
                        TableCell(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
          storedat[i]["win"].toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,color: Colors.white
                            ),
                          ),
                        ) ),
                        TableCell(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            storedat[i]["point"].toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,color: Colors.white
                            ),
                          ),
                        ) ),
                      ]

                  )
          ]
                ],
              )
            )
          );

        }

      ),
    );



    }
}


