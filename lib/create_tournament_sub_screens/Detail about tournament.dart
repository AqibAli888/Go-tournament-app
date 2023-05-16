import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/create_tournament_sub_screens/pick_location.dart';
import '../Global/global.dart';
import '../models/New_Tournament_create_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/text_form_field.dart';

class Tournament_Deatail_Screen extends StatefulWidget {
  final New_Tournament_model new_tournament_model;

  const Tournament_Deatail_Screen({
    Key? key,
    required this.new_tournament_model,
  }) : super(key: key);
  @override
  State<Tournament_Deatail_Screen> createState() =>
      _Tournament_Deatail_ScreenState();
}

class _Tournament_Deatail_ScreenState extends State<Tournament_Deatail_Screen> {
  add_location_to_firebase(location)async{
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .update({
      "Location": location,
    });



    await  FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .update({
      "Location": location,
    }).then((value){
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Location has been selected',
            );
          });
    });
  }
  DateTime start_selecteddate = DateTime.now();
  DateTime End_selecteddate = DateTime.now();

  TextEditingController total_teams = TextEditingController();
  TextEditingController Register_teams = TextEditingController();
  TextEditingController entry_fees = TextEditingController();
  TextEditingController winning_price = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
// updating total_teams and register_teams
  formvalidation() {
    if (total_teams.text.trim().isNotEmpty && Register_teams.text.isNotEmpty ) {
      //login
      if(int.parse(total_teams.text.trim())>=int.parse(Register_teams.text)){
        update_teams();
      }
      else{
        showDialog(
            context: context,
            builder: (c) {
              return Error_Dialog(
                message: 'Register team cannot be greater then Total Teams',
              );
            });
      }


    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please Enter All Textfields',
            );
          });
    }
  }
  update_teams() async {

    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(
            message: 'Updating please wait',
          );
        });
    FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .update({
      "Total_Teams": total_teams.text,
      "Register_Teams": Register_teams.text,
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .update({
      "Total_Teams": total_teams.text,
      "Register_Teams": Register_teams.text,
    }).then((value) async {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Updated Successfully',
            );
          });
    });
  }

  Map<String, dynamic>? userdata;
  @override

  // init method to gain the uid of the user and access data
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
    // if the user data == null then it will show loading
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
                      Container(height: MediaQuery.of(context).size.height * 0.020),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(child: Text("Tournament Details",style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),)),
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
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return AlertDialog(
                                          backgroundColor: Colors.deepPurple,
                                          scrollable: true,
                                          title: Text('Update Phone number'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Form(
                                              child: Column(
                                                children: <Widget>[
                                                  Text_form_field(
                                                      texthint: "Total Teams",
                                                      data: Icons.access_time,
                                                      controller: phonenumber),


                                                  // short address
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                child: Text("cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  // your code
                                                }),
                                            TextButton(
                                                child: Text("UPDATE"),
                                                onPressed: () async{
                                                  FirebaseFirestore.instance
                                                      .collection("Users")
                                                      .doc(firebaseAuth.currentUser!.uid).update({
                                                    "Phone":phonenumber.text
                                                  }).then((value)async{
                                                    Navigator.pop(context);
                                                  });
                                                  // your code
                                                }),
                                          ],
                                        );
                                      });
                                    });
                              },
                              child: Center(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height * 0.05,
                                          width:
                                          MediaQuery.of(context).size.width * 0.6,

                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Center(child: Text("Tap To Update",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                          ))),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Tournament Creator :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(snapshot.data["Name"],style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Email Address:",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(snapshot.data['useremail'],style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Phone Number :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(snapshot.data['Phone'],style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
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
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("hello here");

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    scrollable: true,
                                    title: Text('Create Tournament'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          children: <Widget>[
                                            Text_form_field(
                                                texthint: "Total Teams",
                                                data: Icons.access_time,
                                                controller: total_teams),

                                            Text_form_field(
                                                texthint: "Register Teams",
                                                type: TextInputType.number,
                                                data: Icons.access_time,
                                                controller: Register_teams),

                                            // short address
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          child: Text("cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // your code
                                          }),
                                      TextButton(
                                          child: Text("Create now"),
                                          onPressed: () {
                                              formvalidation();


                                            // your code
                                          }),
                                    ],
                                  );
                                });
                              });
                        },
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Users")
                                .doc(firebaseAuth.currentUser!.uid)
                                .collection("Tournaments")
                                .doc(
                                    widget.new_tournament_model.Tournament_Name)
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
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height * 0.05,
                                          width:
                                          MediaQuery.of(context).size.width * 0.6,

                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Center(child: Text("Tap To Update",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                          ))),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Teams :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(snapshot.data["Total_Teams"],style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Registered Teams :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(
                                                snapshot.data["Register_Teams"],style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("hello here");
                          var myInt = widget.new_tournament_model.End_tournament
                              .toString()
                              .split(" ")
                              .first;
                          print(myInt);
                          var year = int.parse(myInt.split("-").first);
                          var month = int.parse(myInt.split("").skip(5).first);
                          var monthh = int.parse(myInt.split("").skip(6).first);
                          print(month);
                          print(monthh);
                          var m =
                              int.parse(month.toString() + monthh.toString());
                          print(m);
                          var day = int.parse(myInt.split("-").last);
                          print("${year}y-${m}m-${day}");

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    scrollable: true,
                                    title: Text('Create Tournament'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          children: <Widget>[
                                            TextButton(
                                                onPressed: () async {
                                                  print("helodbhh");

                                                  final DateTime? datetime =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate: DateTime(
                                                              year, m, day));
                                                  if (datetime != null) {
                                                    setState(() {
                                                      start_selecteddate =
                                                          datetime;
                                                    });
                                                    print(start_selecteddate);
                                                  }
                                                },
                                                child: Text("Pick Start Date")),
                                            TextButton(
                                                onPressed: () async {
                                                  final DateTime? datetime =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2024));
                                                  if (datetime != null) {
                                                    setState(() {
                                                      End_selecteddate =
                                                          datetime;
                                                    });
                                                    print(End_selecteddate);
                                                  }
                                                },
                                                child: Text("Pick Final Date")),

                                            // short address
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          child: Text("cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // your code
                                          }),
                                      TextButton(
                                          child: Text("Change Date"),
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (c) {
                                                  return Loading_Dialog(
                                                    message:
                                                        'Adding Player please wait',
                                                  );
                                                });

                                            FirebaseFirestore.instance
                                                .collection("All_Tournaments")
                                                .doc(widget.new_tournament_model
                                                    .Tournament_Name)
                                                .update({
                                              "Start_tournament":
                                                  start_selecteddate.toString(),
                                              "End_tournament":
                                                  End_selecteddate.toString(),
                                            });
                                            FirebaseFirestore.instance
                                                .collection("Users")
                                                .doc(firebaseAuth
                                                    .currentUser!.uid)
                                                .collection("Tournaments")
                                                .doc(widget.new_tournament_model
                                                    .Tournament_Name)
                                                .update({
                                              "Start_tournament":
                                                  start_selecteddate.toString(),
                                              "End_tournament":
                                                  End_selecteddate.toString(),
                                            }).then((value) async {
                                              Navigator.pop(context);
                                            });

                                            // your code
                                          }),
                                    ],
                                  );
                                });
                              });
                        },
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Users")
                                .doc(firebaseAuth.currentUser!.uid)
                                .collection("Tournaments")
                                .doc(
                                    widget.new_tournament_model.Tournament_Name)
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
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height * 0.05,
                                          width:
                                          MediaQuery.of(context).size.width * 0.6,

                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Center(child: Text("Tap To Update",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                          ))),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Tournament Start Date :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(snapshot.data
                                                .data()["Start_tournament"]
                                                .toString()
                                                .split(" ")
                                                .first,style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Final Date :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(snapshot.data
                                                .data()["End_tournament"]
                                                .toString()
                                                .split(" ")
                                                .first,style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    scrollable: true,
                                    title: Text('Create Tournament'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          children: <Widget>[
                                            Text_form_field(
                                                texthint: "Entry Fees",
                                                data: Icons.access_time,
                                                controller: entry_fees),

                                            Text_form_field(
                                                texthint: "Winning price",
                                                type: TextInputType.number,
                                                data: Icons.access_time,
                                                controller: winning_price),

                                            // short address
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          child: Text("cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // your code
                                          }),
                                      TextButton(
                                          child: Text("Create now"),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (c) {
                                                  return Loading_Dialog(
                                                    message:
                                                        'Adding Player please wait',
                                                  );
                                                });
                                            FirebaseFirestore.instance
                                                .collection("All_Tournaments")
                                                .doc(widget.new_tournament_model
                                                    .Tournament_Name)
                                                .update({
                                              "Entry_Fees": entry_fees.text,
                                              "Winning_price":
                                                  winning_price.text,
                                            }).then((value) async {
                                              print("helokkk");
                                              Navigator.pop(context);
                                            });
                                            FirebaseFirestore.instance
                                                .collection("Users")
                                                .doc(firebaseAuth
                                                    .currentUser!.uid)
                                                .collection("Tournaments")
                                                .doc(widget.new_tournament_model
                                                    .Tournament_Name)
                                                .update({
                                              "Entry_Fees": entry_fees.text,
                                              "Winning_price":
                                                  winning_price.text,
                                            });
                                            // your code
                                          }),
                                    ],
                                  );
                                });
                              });
                        },
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Users")
                                .doc(firebaseAuth.currentUser!.uid)
                                .collection("Tournaments")
                                .doc(
                                    widget.new_tournament_model.Tournament_Name)
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
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height:
                                          MediaQuery.of(context).size.height * 0.05,
                                          width:
                                          MediaQuery.of(context).size.width * 0.6,

                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Center(child: Text("Tap To Update",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                          ))),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Entry Fees :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(snapshot.data["Entry_Fees"],style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Winning price :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )),
                                            Text(snapshot.data["Winning_price"],style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      StreamBuilder(
                          stream:FirebaseFirestore.instance
                              .collection("Users")
                              .doc(firebaseAuth.currentUser!.uid)
                              .collection("Tournaments")
                              .doc(
                              widget.new_tournament_model.Tournament_Name)
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>Pick_Match_Location(new_tournament_model: widget.new_tournament_model,)));
                              },
                              child: Center(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
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
                                            Container(
                                              height:
                                              MediaQuery.of(context).size.height * 0.05,
                                              width:
                                              MediaQuery.of(context).size.width * 0.6,

                                              decoration: BoxDecoration(
                                                  color: Colors.blueGrey,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Center(child: Text("Tap To Update",style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold
                                              ))),
                                            ),
                                            Center(child: Text("Location :",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ))),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                            ),
                                            Center(child: Text(snapshot.data["Location"],style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            )))
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
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),


                      // show details of the tournament rules etc and can update the details as well
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return AlertDialog(
                                    backgroundColor: Colors.deepPurple,
                                    scrollable: true,
                                    title: Text('Create Tournament'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          children: <Widget>[
                                            Text_form_field(
                                                texthint: "Detail",
                                                data: Icons.access_time,
                                                controller: detail),

                                            // short address
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          child: Text("cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // your code
                                          }),
                                      TextButton(
                                          child: Text("Create now"),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (c) {
                                                  return Loading_Dialog(
                                                    message:
                                                        'Adding Player please wait',
                                                  );
                                                });
                                            FirebaseFirestore.instance
                                                .collection("All_Tournaments")
                                                .doc(widget.new_tournament_model
                                                    .Tournament_Name)
                                                .update({
                                              "Detail": detail.text,
                                            }).then((value) async {
                                              print("helokkk");
                                              Navigator.pop(context);
                                            });
                                            FirebaseFirestore.instance
                                                .collection("Users")
                                                .doc(firebaseAuth
                                                    .currentUser!.uid)
                                                .collection("Tournaments")
                                                .doc(widget.new_tournament_model
                                                    .Tournament_Name)
                                                .update({
                                              "Detail": detail.text,
                                            });
                                            // your code
                                          }),
                                    ],
                                  );
                                });
                              });
                        },
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Users")
                                .doc(firebaseAuth.currentUser!.uid)
                                .collection("Tournaments")
                                .doc(
                                    widget.new_tournament_model.Tournament_Name)
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
                                      MediaQuery.of(context).size.height * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
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
                                            Container(
                                              height:
                                              MediaQuery.of(context).size.height * 0.05,
                                              width:
                                              MediaQuery.of(context).size.width * 0.6,

                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(10),

                                              ),
                                              child: Center(child: Text("Tap To Update",style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold
                                              ))),
                                            ),
                                            Center(child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Details",style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold
                                              )),
                                            )),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                            ),
                                            Row(
                                              children: [
                                                Text(snapshot.data["Detail"],style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                )),
                                              ],
                                            ),



                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
