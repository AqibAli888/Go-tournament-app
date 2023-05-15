
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/all_tournament_showing_model.dart';
import '../../widgets/error_dialog.dart';


class Standing_screen extends StatefulWidget {
  final All_Tournament_Showing_model all_Tournament_Showing_model;
  const Standing_screen({Key? key, required this.all_Tournament_Showing_model,}) : super(key: key);

  @override
  State<Standing_screen> createState() => _Standing_screenState();
}

class _Standing_screenState extends State<Standing_screen> {



  @override
  Widget build(BuildContext context){
    final Stream<QuerySnapshot>teamdata=FirebaseFirestore.instance
        .collection("All_Tournaments").doc(widget.all_Tournament_Showing_model.Tournament_Name).
    collection("Teams_in_Tournament").orderBy("point",descending: true).snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: teamdata,
        builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.hasError){
            showDialog(context: context, builder: (c) {
              return Error_Dialog(message: "Something is wrong",path:"animation/95614-error-occurred.json");
            });

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
          return Container(
              child:SingleChildScrollView(
                  child: Table(
                    border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.white
                        , style: BorderStyle.solid)),
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

    );



  }
}
