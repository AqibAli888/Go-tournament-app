import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/public_tournament_files/single_tournament_detail_screen/Navigate_Screen_single_tournament_detail.dart';
import 'package:sports_app/public_tournament_files/single_tournament_detail_screen/result_screen_search.dart';
import '../models/all_tournament_showing_model.dart';

class All_Tournament_showing_screen extends StatefulWidget {

  const All_Tournament_showing_screen({Key? key,}) : super(key: key);

  @override
  State<All_Tournament_showing_screen> createState() =>
      _All_Tournament_showing_screenState();
}

class _All_Tournament_showing_screenState
    extends State<All_Tournament_showing_screen> {
  var _chosenValue;
  void _showDecline() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return AlertDialog(
              title: new Text("SEARCH TOURNAMENT WITH"),
              content: Container(
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                       Text("Search With"),
                     DropdownButton<String>(
                          hint: Text('Select one option'),
                          value: _chosenValue,
                          underline: Container(

                          ),
                          items: <String>[
                            'Tournament_Name',
                            'id',
                            'format',
                            'Entry_Fees'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.w200),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _chosenValue = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                TextButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: new Text("ok"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => tournament_SearchScreen( data:_chosenValue,)));
                  },
                ),
              ],
            );
          },

        );
      },
    );
  }




  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.black,
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _showDecline();
                      print(_chosenValue);


                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => tournament_SearchScreen()));
                    },
                    icon: Icon(Icons.search_outlined)),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("All_Tournaments")
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
                            All_Tournament_Showing_model new_tournamnent =
                                All_Tournament_Showing_model.fromJson(
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
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(706, 112, 107, 107),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                        trailing: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                          // to enter the
                                          // delete and updaate icon
                                          child: Row(
                                            children: [],
                                          ),
                                        ),
                                        focusColor: Colors.red,
                                        title: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text("Tournament Name"),
                                                Text(
                                                  new_tournamnent
                                                      .Tournament_Name
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.004,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.03,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text("Start Date"),
                                                Text(
                                                  new_tournamnent
                                                      .Start_tournament
                                                      .toString().split(" ").first,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.004,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Tournament Format"),
                                                Text(
                                                    new_tournamnent.format
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.004,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text("Final Date"),
                                                Text(
                                                    new_tournamnent.End_tournament
                                                        .toString().split(" ").first,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     Text("Start Date "),
                                            //     Text(new_tournamnent.time!
                                            //         .split(" 00:00:00.000 - ")
                                            //         .first),
                                            //   ],
                                            // ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.004,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),


                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Navigatetoscreen_tournament(
                                                        all_tournament_showing_model:
                                                            new_tournamnent,
                                                      )));

                                          // transfer data to new screen
                                          print(new_tournamnent.id);
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
            ],
          ),
        ),
      ),
    );
  }
}
