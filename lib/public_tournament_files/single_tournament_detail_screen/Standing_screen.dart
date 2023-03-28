
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/all_tournament_showing_model.dart';


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
                    border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.orangeAccent, style: BorderStyle.solid)),
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



// Scaffold(
// appBar: AppBar(
// automaticallyImplyLeading: false,
// backgroundColor: Colors.white,
// title: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text("Teams",style: TextStyle(
// color: Colors.black
// ),),
// Text("Level",style: TextStyle(
// color: Colors.black
// ),),
// Text("Point",style: TextStyle(
// color: Colors.black
// ),),
// Text("Teams",style: TextStyle(
// color: Colors.black
// ),),
// ],
// ),
// ),
// body: FutureBuilder(
// future: getDocId(),
// builder: (context,index){
// return  ListView.builder(itemCount:docIds.length,
// itemBuilder: (context,index){
// return  ListTile(
// title: Get_User_name(Documentid:docIds[index], new_tournament_model: widget.new_tournament_model ,)
// );
// });
// }),
//
// );


//   ListTile(
//   title: Get_User_name(Documentid:docIds[index], new_tournament_model: widget.new_tournament_model ,)
//   );
// });




