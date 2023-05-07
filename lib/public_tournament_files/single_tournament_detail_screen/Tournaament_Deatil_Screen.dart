import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Global/global.dart';
import '../../models/New_Tournament_create_model.dart';
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
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(child: Text("Tournament Details")),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
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
                                    Text("Tournament Creator :"),
                                    Text(snapshot.data["Name"])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Email Address:"),
                                    Text(snapshot.data['useremail'])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Phone Number :"),
                                    Text(snapshot.data['Phone'])
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
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
                                    Text("Total Teams :"),
                                    Text(snapshot.data["Total_Teams"])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Registered Teams :"),
                                    Text(
                                        snapshot.data["Register_Teams"])
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
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
                                    Text("Tournament Start Date :"),
                                    Text(snapshot.data
                                        .data()["Start_tournament"]
                                        .toString()
                                        .split(" ")
                                        .first)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Final Date :"),
                                    Text(snapshot.data
                                        .data()["End_tournament"]
                                        .toString()
                                        .split(" ")
                                        .first)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
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
                                    Text("Entry Fees :"),
                                    Text(snapshot.data["Entry_Fees"])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Winning price :"),
                                    Text(snapshot.data["Winning_price"])
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
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
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
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
                                    Center(child: Text("Location :")),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.025,
                                    ),
                                    Center(child: Text("qazipur"))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
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
                                    Center(child: Text("Details")),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.025,
                                    ),
                                    Row(
                                      children: [
                                        Text(snapshot.data["Detail"]),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

