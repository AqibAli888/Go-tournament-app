// ok

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Global/global.dart';
import '../../models/all_tournament_showing_model.dart';

class Match_Detail_screen extends StatefulWidget {
  final All_Tournament_Showing_model all_tournament_showing_model;
  const Match_Detail_screen({Key? key, required this.all_tournament_showing_model,}) : super(key: key);

  @override
  State<Match_Detail_screen> createState() => _Match_Detail_screenState();
}

class _Match_Detail_screenState extends State<Match_Detail_screen> {

  Map<String, dynamic>? userdata;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    var document = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Map<String, dynamic>? value = document.data();
    setState(() {
      userdata = value;
    });
    print(userdata!['Name']);

    print(value!['Name']);
  }
  bool love=false;

  @override
  Widget build(BuildContext context) {
    return userdata == null
        ? Center(
        child: Text(
          "Loading",
          style: TextStyle(color: Colors.white),
        ))
        : Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03510,
                ),
                // detail about creator
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(child: Text("Tournament Details",style: TextStyle(
                        color: Colors.white
                    ),)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),

                // favorite and unfavorite ui
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("All_Tournaments")
                        .doc(widget.all_tournament_showing_model.Tournament_Name)
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GestureDetector(
                        onTap: (){
                          if(snapshot.data["fovorite"]=="true"){
                            FirebaseFirestore.instance
                                .collection("All_Tournaments")
                                .doc(widget.all_tournament_showing_model.Tournament_Name).update({
                              "fovorite":"false"

                            });

                          }
                          else{
                            FirebaseFirestore.instance
                                .collection("All_Tournaments")
                                .doc(widget.all_tournament_showing_model.Tournament_Name).update({
                              "fovorite":"true"

                            });
                          }


                        },
                        child: Center(
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Center(child: Text("Favorite :",style: TextStyle(
                                          color: Colors.white
                                      ),)),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.015,
                                      ),
                                      Center(child:snapshot.data["fovorite"]=="true"?Image.asset(
                                      height: MediaQuery.of(context).size.height*0.0350,

                              "animation/lover.png"):Icon(Icons.favorite_border,color: Colors.red,size: MediaQuery.of(context).size.height*0.0350 ),
                          )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),


                // tournament creator detail ui
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(firebaseAuth.currentUser!.uid)
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Center(
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height * 0.25,
                          width:
                          MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tournament Creator :",style: TextStyle(
                                color: Colors.white
                            ),),
                                    Text(snapshot.data["Name"],style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Email Address:",style: TextStyle(
                                    color: Colors.white
                                ),),
                                    Text(snapshot.data['useremail'],style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Phone Number :",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text(snapshot.data['Phone'],style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),


                // total and register team ui
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("All_Tournaments")
                        .doc(widget.all_tournament_showing_model.Tournament_Name)
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Center(
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height * 0.13,
                          width:
                          MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Teams :",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text(snapshot.data["Total_Teams"],style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Registered Teams :",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text(
                                        snapshot.data["Register_Teams"],style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),


                // tournament start and end date showing ui
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("All_Tournaments")
                        .doc(widget.all_tournament_showing_model.Tournament_Name)
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Center(
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height * 0.15,
                          width:
                          MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tournament Start Date :",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text(snapshot.data
                                        .data()["Start_tournament"]
                                        .toString()
                                        .split(" ")
                                        .first,style: TextStyle(
                                        color: Colors.white
                                    ),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Final Date :",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text(snapshot.data
                                        .data()["End_tournament"]
                                        .toString()
                                        .split(" ")
                                        .first,style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),



                //entry and registration fees design
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("All_Tournaments")
                        .doc(widget.all_tournament_showing_model.Tournament_Name)
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Center(
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height * 0.15,
                          width:
                          MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Entry Fees :",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text(snapshot.data["Entry_Fees"],style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Winning price :",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text(snapshot.data["Winning_price"],style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),


                // Location showing ui
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("All_Tournaments")
                        .doc(widget.all_tournament_showing_model.Tournament_Name)
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Center(
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(child: Text("Location :",style: TextStyle(
                                        color: Colors.white
                                    ),)),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.025,
                                    ),
                                    Center(child: Container(

                                      child: Text(snapshot.data["Location"],style: TextStyle(
                                          color: Colors.white
                                      ),),
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),

                // details about tournament showing screen
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("All_Tournaments")
                        .doc(widget.all_tournament_showing_model.Tournament_Name)
                        .snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Center(
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height * 0.35,
                          width:
                          MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(child: Text("Details",style: TextStyle(
                                        color: Colors.white
                                    ),)),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.025,
                                    ),
                                    Row(
                                      children: [
                                        Text(snapshot.data["Detail"],style: TextStyle(
                                            color: Colors.white
                                        ),),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

