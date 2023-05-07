import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Global/global.dart';
import '../models/New_Tournament_create_model.dart';
import '../models/match_detail_model.dart';
import '../tournament_match_detail_result/match_result_screen.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'Navigate_tournament_full_detail_screen.dart';

class Tournament_match_detail extends StatefulWidget {
  final New_Tournament_model new_tournament_model;
  const Tournament_match_detail({Key? key, required this.new_tournament_model})
      : super(key: key);

  @override
  State<Tournament_match_detail> createState() =>
      _Tournament_match_detailState();
}

class _Tournament_match_detailState extends State<Tournament_match_detail> {
  DateTime selecteddate = DateTime.now();
  TimeOfDay matchtime = TimeOfDay(hour: 12, minute: 30);




  Future<void> deletecollection() async {
    var collection = await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule");
    var snapshot = await collection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    var newcollection = await FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule");
    var newsnapshot = await newcollection.get();
    for (var doc in newsnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Updatematchdetail(String id) {
    if (date.text.trim().isNotEmpty) {
      //login
      updating_match_schedule(id);
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please Enter All textfields',
            );
          }).then((value) {
        setState(() {
          selecteddate = DateTime.now();
        });
      });
    }
  }

  updating_match_schedule(String id) async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(
            message: 'Adding Player please wait',
          );
        });
    FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule")
        .doc(id)
        .update({
      "team0": selectedItem,
      "team1": secondselected,
      "team0_win": false,
      "team1_win": false,
      "result": "Result Not added",
      "Time": matchtime
          .toString()
          .split("TimeOfDay(")
          .last
          .toString()
          .split(")")
          .first
          .toString(),
      "Date": selecteddate.toString().split(" ").first.toString()
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule")
        .doc(id)
        .update({
      "team0": selectedItem,
      "team1": secondselected,
      "team0_win": false,
      "team1_win": false,
      "result": "Result Not added",
      "Time": matchtime
          .toString()
          .split("TimeOfDay(")
          .last
          .toString()
          .split(")")
          .first
          .toString(),
      "Date": selecteddate.toString().split(" ").first.toString()
    }).then((value) {
      secondselected = "";
      selectedItem = "";
      Navigator.pop(context);
      selecteddate = DateTime.now();
    });
  }

  formvalidation(String time) {
    if (date.text.trim().isNotEmpty) {
      //login
      if (selectedItem != secondselected) {
        Adding_team(time);
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return Error_Dialog(
                message: 'Same Team Name cannot play with each other ',
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please Enter All textfields',
            );
          }).then((value) {
        setState(() {
          selecteddate = DateTime.now();
        });
      });
    }
  }

  Adding_team(String time) async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(
            message: 'Adding Player please wait',
          );
        });
    FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule")
        .doc(time)
        .set({
      "id": time.toString(),
      "team0": selectedItem,
      "team1": secondselected,
      "team0_win": false,
      "team1_win": false,
      "result": "Result Not added",
      "Time": matchtime
          .toString()
          .split("TimeOfDay(")
          .last
          .toString()
          .split(")")
          .first
          .toString(),
      "Date": selecteddate.toString().split(" ").first.toString()
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule")
        .doc(time)
        .set({
      "id": time.toString(),
      "team0": selectedItem,
      "team1": secondselected,
      "team0_win": false,
      "team1_win": false,
      "result": "Result Not added",
      "Time": matchtime
          .toString()
          .split("TimeOfDay(")
          .last
          .toString()
          .split(")")
          .first
          .toString(),
      "Date": selecteddate.toString().split(" ").first.toString()
    }).then((value) {
      secondselected = "";
      selectedItem = "";
      Navigator.pop(context);
      selecteddate = DateTime.now();
    });
  }

  String selectedItem = "";
  String secondselected = "";
  TextEditingController location = TextEditingController();
  TextEditingController date = TextEditingController();
  List<String> items = <String>[""];
  String selectedteam = "pk";
  String option2 = "select";
  @override
  Widget build(BuildContext context) {

    DocumentReference all_tournament_ref=FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name);

    DocumentReference pri_tournament_ref=FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name);




    List<String> teamsadded = <String>[""];

    void getallteams() async {
      await for (var messages in FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("Tournaments")
          .doc(widget.new_tournament_model.Tournament_Name)
          .collection("Teams_in_Tournament")
          .snapshots()) {
        for (var message in messages.docs.toList()) {
          print(message.data()["Team_Name"]);
          items.add(message.data()["Team_Name"]);
          teamsadded.add(message.data()["Team_Name"]);
        }
        teamsadded = teamsadded.toSet().toList();
        print(teamsadded);
      }
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {
                    deletecollection();
                  },
                  child: Text(
                    "Delete All Schedule",
                    style: TextStyle(color: Colors.white),
                  ))),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(firebaseAuth.currentUser!.uid)
                .collection("Tournaments")
                .doc(widget.new_tournament_model.Tournament_Name)
                .collection("Tournament_schedule")
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
                        Match_Detail_model match_detail_model =
                            Match_Detail_model.fromJson(
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
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                    trailing: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.00001,
                                      child: Row(
                                        children: [],
                                      ),
                                    ),
                                    focusColor: Colors.red,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(match_detail_model.team0
                                            .toString()),
                                        Text("VS"),
                                        Text(match_detail_model.team1
                                            .toString()),
                                      ],
                                    ),
                                    subtitle: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(match_detail_model.Date
                                              .toString()),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("At "),
                                                Text(match_detail_model.Time
                                                    .toString()),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(Icons.access_time)
                                              ],
                                            ),
                                          ),
                                          Text(match_detail_model.result
                                              .toString()),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Delete Match",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .doc(firebaseAuth
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection(
                                                                  "Tournaments")
                                                              .doc(widget
                                                                  .new_tournament_model
                                                                  .Tournament_Name)
                                                              .collection(
                                                                  "Tournament_schedule")
                                                              .doc(
                                                                  match_detail_model
                                                                      .id)
                                                              .delete();

                                                          all_tournament_ref
                                                              .collection(
                                                                  "Tournament_schedule")
                                                              .doc(
                                                                  match_detail_model
                                                                      .id)
                                                              .delete();
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Update Result",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    IconButton(
                                                        onPressed: () async {
                                                          DocumentSnapshot variable = await FirebaseFirestore.instance
                                                              .collection('Users').doc(firebaseAuth.currentUser!.uid)
                                                              .collection("Tournaments")
                                                              .doc(widget
                                                                  .new_tournament_model
                                                                  .Tournament_Name)
                                                              .collection(
                                                                  "Tournament_schedule")
                                                              .doc(
                                                                  match_detail_model
                                                                      .id)
                                                              .get();
                                                          String team =
                                                              variable["result"]
                                                                  .toString()
                                                                  .split(" ")
                                                                  .first;
                                                          if ((variable[
                                                                  "result"]) ==
                                                              "Result Not added") {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Match_result_screen(
                                                                              new_tournament_model: widget.new_tournament_model,
                                                                              match_detail_model: match_detail_model,
                                                                            )));
                                                          }


                                                          else if (team ==
                                                              match_detail_model
                                                                  .team0) {
                                                            print(team);
                                                            print("here 1");
                                                            print(
                                                                match_detail_model
                                                                    .team0);
                                                            // result updaate
                                                            FirebaseFirestore.instance.collection('Users').doc(firebaseAuth
                                                                    .currentUser!.uid).collection("Tournaments").doc(widget.new_tournament_model
                                                                    .Tournament_Name).collection("Tournament_schedule").doc(match_detail_model.id)
                                                                .update({"result": "Result Not added"});

                                                            FirebaseFirestore.instance
                                                                .collection("All_Tournaments")
                                                                .doc(widget.new_tournament_model.Tournament_Name).collection("Teams_in_Tournament").doc(
                                                                match_detail_model.team0).update({"played": FieldValue.increment(
                                                                -1),"point": FieldValue.increment(-2), "win": FieldValue.increment(-1)});

                                                            //  decrease the other team played match

                                                            FirebaseFirestore.instance
                                                                .collection("All_Tournaments")
                                                                .doc(widget.new_tournament_model.Tournament_Name).collection("Teams_in_Tournament")
                                                                .doc(match_detail_model.team1).update({"played": FieldValue
                                                                .increment(-1),
                                                            });








                                                            // decrease the get points played win all in private of team[0]

                                                            FirebaseFirestore.instance.collection('Users').
                                                            doc(firebaseAuth.currentUser!.uid).collection("Tournaments").doc(widget
                                                                .new_tournament_model.Tournament_Name).collection("Teams_in_Tournament").doc(
                                                                    match_detail_model.team0).update({"played": FieldValue.increment(
                                                                          -1),"point": FieldValue.increment(-2), "win": FieldValue.increment(-1)});

                                                            //  decrease the other team played match

                                                            FirebaseFirestore.instance.collection('Users').doc(firebaseAuth.currentUser!.uid).collection("Tournaments").doc(widget.new_tournament_model
                                                                .Tournament_Name).collection("Teams_in_Tournament").doc(match_detail_model.team1).update({"played": FieldValue
                                                                .increment(-1),
                                                            }).then((value) {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          Match_result_screen(
                                                                            new_tournament_model:
                                                                                widget.new_tournament_model,
                                                                            match_detail_model:
                                                                                match_detail_model,
                                                                          )));
                                                            });






                                                          }
                                                          else if (team ==
                                                              match_detail_model
                                                                  .team1) {
                                                            print(team);
                                                            print("here 1");
                                                            print(
                                                                match_detail_model
                                                                    .team0);
                                                            // result updaate
                                                            FirebaseFirestore.instance.collection('Users').doc(firebaseAuth
                                                                .currentUser!.uid).collection("Tournaments").doc(widget.new_tournament_model
                                                                .Tournament_Name).collection("Tournament_schedule").doc(match_detail_model.id)
                                                                .update({"result": "Result Not added"});


                                                            FirebaseFirestore.instance
                                                                .collection("All_Tournaments")
                                                                .doc(widget.new_tournament_model.Tournament_Name).collection("Teams_in_Tournament").doc(
                                                                match_detail_model.team1).update({"played": FieldValue.increment(
                                                                -1),"point": FieldValue.increment(-2), "win": FieldValue.increment(-1)});

                                                            //  decrease the other team played match

                                                            FirebaseFirestore.instance
                                                                .collection("All_Tournaments")
                                                                .doc(widget.new_tournament_model.Tournament_Name).collection("Teams_in_Tournament")
                                                                .doc(match_detail_model.team0).update({"played": FieldValue
                                                                .increment(-1),
                                                            });

                                                            // decrease the get points played win all in private of team[0]

                                                            FirebaseFirestore.instance.collection('Users').
                                                            doc(firebaseAuth.currentUser!.uid).collection("Tournaments").doc(widget
                                                                .new_tournament_model.Tournament_Name).collection("Teams_in_Tournament").doc(
                                                                match_detail_model.team1).update({"played": FieldValue.increment(
                                                                -1),"point": FieldValue.increment(-2), "win": FieldValue.increment(-1)});

                                                            //  decrease the other team played match

                                                            FirebaseFirestore.instance.collection('Users').doc(firebaseAuth.currentUser!.uid).collection("Tournaments").doc(widget.new_tournament_model
                                                                .Tournament_Name).collection("Teams_in_Tournament").doc(match_detail_model.team0).update({"played": FieldValue
                                                                .increment(-1),
                                                            }).then((value) {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          Match_result_screen(
                                                                            new_tournament_model:
                                                                            widget.new_tournament_model,
                                                                            match_detail_model:
                                                                            match_detail_model,
                                                                          )));
                                                            });






                                                          }
                                                          // draw
                                                          else if (team == "Draw") {
                                                            print("Draw");
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Users')
                                                                .doc(firebaseAuth
                                                                    .currentUser!
                                                                    .uid)
                                                                .collection(
                                                                    "Tournaments")
                                                                .doc(widget
                                                                    .new_tournament_model
                                                                    .Tournament_Name)
                                                                .collection(
                                                                    "Tournament_schedule")
                                                                .doc(
                                                                    match_detail_model
                                                                        .id)
                                                                .update({
                                                              "result":
                                                                  "Result Not added"
                                                            });
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'All_Tournaments')
                                                                .doc(widget
                                                                    .new_tournament_model
                                                                    .Tournament_Name)
                                                                .collection(
                                                                    "Tournament_schedule")
                                                                .doc(
                                                                    match_detail_model
                                                                        .id)
                                                                .update({
                                                              "result":
                                                                  "Result Not added"
                                                            });
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Users')
                                                                .doc(firebaseAuth
                                                                    .currentUser!
                                                                    .uid)
                                                                .collection(
                                                                    "Tournaments")
                                                                .doc(widget
                                                                    .new_tournament_model
                                                                    .Tournament_Name)
                                                                .collection(
                                                                    "Teams_in_Tournament")
                                                                .doc(
                                                                    match_detail_model
                                                                        .team1)
                                                                .update({
                                                              "played":
                                                                  FieldValue
                                                                      .increment(
                                                                          -1),
                                                              "point": FieldValue
                                                                  .increment(
                                                                      -1),
                                                            });
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Users')
                                                                .doc(firebaseAuth
                                                                    .currentUser!
                                                                    .uid)
                                                                .collection(
                                                                    "Tournaments")
                                                                .doc(widget
                                                                    .new_tournament_model
                                                                    .Tournament_Name)
                                                                .collection(
                                                                    "Teams_in_Tournament")
                                                                .doc(
                                                                    match_detail_model
                                                                        .team0)
                                                                .update({
                                                              "played":
                                                                  FieldValue
                                                                      .increment(
                                                                          -1),
                                                              "point": FieldValue
                                                                  .increment(
                                                                  -1),
                                                            }).then((value) {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          Match_result_screen(
                                                                            new_tournament_model:
                                                                                widget.new_tournament_model,
                                                                            match_detail_model:
                                                                                match_detail_model,
                                                                          )));
                                                            });
                                                          }

                                                          print(team);
                                                        },
                                                        icon: Icon(
                                                          Icons.update,
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [],
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: Text(
                                                  'Are You Sure to Update the Match Scheduling?'),
                                              actions: [
                                                TextButton(
                                                    child: Text("cancel"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // your code
                                                    }),
                                                TextButton(
                                                    child: Text("Update"),
                                                    onPressed: () {
                                                      getallteams();
                                                      items = items
                                                          .toSet()
                                                          .toList();
                                                      teamsadded = teamsadded
                                                          .toSet()
                                                          .toList();
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return SingleChildScrollView(
                                                              child:
                                                                  AlertDialog(
                                                                title: Text(
                                                                    'Alert Dialog'),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(Icons
                                                                            .volume_up),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 8.0,
                                                                              right: 8.0),
                                                                          child:
                                                                              Text('Select one:'),
                                                                        ),
                                                                        Expanded(
                                                                          // add Expanded to have your dropdown button fill remaining space
                                                                          child:
                                                                              DropdownButton<String>(
                                                                            isExpanded:
                                                                                true, // this allows your dropdown icon to be visible
                                                                            value: items.isNotEmpty
                                                                                ? selectedItem
                                                                                : null,
                                                                            iconSize:
                                                                                24,
                                                                            items:
                                                                                items.map((item) {
                                                                              return DropdownMenuItem(
                                                                                value: item,
                                                                                child: Text(item),
                                                                              );
                                                                            }).toList(),
                                                                            onChanged: (value) =>
                                                                                setState(() {
                                                                              items = items.toSet().toList();
                                                                              selectedItem = value!;
                                                                              items.add(selectedItem);
                                                                              items.clear();
                                                                              items.add("");
                                                                              items = items.toSet().toList();
                                                                            }),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                        "hello"),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(Icons
                                                                            .volume_up),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 8.0,
                                                                              right: 8.0),
                                                                          child:
                                                                              Text('Select one:'),
                                                                        ),
                                                                        Expanded(
                                                                          // add Expanded to have your dropdown button fill remaining space
                                                                          child:
                                                                              DropdownButton<String>(
                                                                            isExpanded:
                                                                                true, // this allows your dropdown icon to be visible
                                                                            value: teamsadded.isNotEmpty
                                                                                ? selectedItem
                                                                                : null,
                                                                            iconSize:
                                                                                24,
                                                                            items:
                                                                                teamsadded.map((item) {
                                                                              return DropdownMenuItem(
                                                                                value: item,
                                                                                child: Text(item),
                                                                              );
                                                                            }).toList(),
                                                                            onChanged: (value) =>
                                                                                setState(() {
                                                                              secondselected = value!;
                                                                              print(secondselected);
                                                                              teamsadded.add(selectedItem);
                                                                              teamsadded.clear();
                                                                              teamsadded.add("");
                                                                              teamsadded = teamsadded.toSet().toList();
                                                                            }),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                        "${selecteddate.year}-${selecteddate.month}"
                                                                        "-${selecteddate.day}"),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          print(
                                                                              "hello here");
                                                                          var myInt = widget
                                                                              .new_tournament_model
                                                                              .End_tournament
                                                                              .toString()
                                                                              .split(" ")
                                                                              .first;
                                                                          print(
                                                                              myInt);
                                                                          var year = int.parse(myInt
                                                                              .split("-")
                                                                              .first);
                                                                          var month = int.parse(myInt
                                                                              .split("")
                                                                              .skip(5)
                                                                              .first);
                                                                          var monthh = int.parse(myInt
                                                                              .split("")
                                                                              .skip(6)
                                                                              .first);
                                                                          print(
                                                                              month);
                                                                          print(
                                                                              monthh);
                                                                          var m =
                                                                              int.parse(month.toString() + monthh.toString());
                                                                          print(
                                                                              m);
                                                                          var day = int.parse(myInt
                                                                              .split("-")
                                                                              .last);
                                                                          print(
                                                                              "${year}y-${m}m-${day}");

                                                                          final DateTime? datetime = await showDatePicker(
                                                                              context: context,
                                                                              initialDate: DateTime.now(),
                                                                              firstDate: DateTime.now(),
                                                                              lastDate: DateTime(year, m, day));
                                                                          if (datetime !=
                                                                              null) {
                                                                            setState(() {
                                                                              selecteddate = datetime;
                                                                            });
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                            "pick date")),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          TimeOfDay?
                                                                              newtime =
                                                                              await showTimePicker(context: context, initialTime: matchtime!);
                                                                          if (newtime !=
                                                                              null) {
                                                                            setState(() {
                                                                              matchtime = newtime;
                                                                            });
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                            "pick time")),
                                                                    TextField(
                                                                      controller:
                                                                          date,
                                                                    ),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Updatematchdetail(match_detail_model
                                                                              .id
                                                                              .toString());
                                                                        },
                                                                        child: Text(
                                                                            "Add Match Deatils")),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            "Cancel"))
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    })
                                              ],
                                            );
                                          });
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) => Match_result_screen(new_tournament_model: widget.new_tournament_model,
                                      //       match_detail_model: match_detail_model,)));
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
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  getallteams();
                  items = items.toSet().toList();
                  teamsadded = teamsadded.toSet().toList();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return items.length > 1
                            ? SingleChildScrollView(
                                child: AlertDialog(
                                  title: Text('Match Scheduling'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.volume_up),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Text('Select one:'),
                                          ),
                                          Expanded(
                                            // add Expanded to have your dropdown button fill remaining space
                                            child: DropdownButton<String>(
                                              isExpanded:
                                                  true, // this allows your dropdown icon to be visible
                                              value: items.isNotEmpty
                                                  ? selectedItem
                                                  : null,
                                              iconSize: 24,
                                              items: items.map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList(),
                                              onChanged: (value) =>
                                                  setState(() {
                                                selectedItem = value!;
                                                print(selectedItem);
                                                items.add(selectedItem);
                                                items.clear();
                                                items.add("");
                                                items = items.toSet().toList();
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text("VS"),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.volume_up),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Text('Select one:'),
                                          ),
                                          Expanded(
                                            // add Expanded to have your dropdown button fill remaining space
                                            child: DropdownButton<String>(
                                              isExpanded:
                                                  true, // this allows your dropdown icon to be visible
                                              value: teamsadded.isNotEmpty
                                                  ? selectedItem
                                                  : null,
                                              iconSize: 24,
                                              items: teamsadded.map((item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList(),
                                              onChanged: (value) =>
                                                  setState(() {
                                                secondselected = value!;
                                                print(secondselected);
                                                teamsadded.add(selectedItem);
                                                teamsadded.clear();
                                                teamsadded.add("");
                                                teamsadded =
                                                    teamsadded.toSet().toList();
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                          "${selecteddate.year}-${selecteddate.month}"
                                          "-${selecteddate.day}"),
                                      TextButton(
                                          onPressed: () async {
                                            print("hello here");
                                            var myInt = widget
                                                .new_tournament_model
                                                .End_tournament
                                                .toString()
                                                .split(" ")
                                                .first;
                                            print(myInt);
                                            var year = int.parse(
                                                myInt.split("-").first);
                                            var month = int.parse(
                                                myInt.split("").skip(5).first);
                                            var monthh = int.parse(
                                                myInt.split("").skip(6).first);
                                            print(month);
                                            print(monthh);
                                            var m = int.parse(month.toString() +
                                                monthh.toString());
                                            print(m);
                                            var day = int.parse(
                                                myInt.split("-").last);
                                            print("${year}y-${m}m-${day}");

                                            final DateTime? datetime =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate:
                                                        DateTime(year, m, day));
                                            if (datetime != null) {
                                              setState(() {
                                                selecteddate = datetime;
                                              });
                                            }
                                          },
                                          child: Text("pick date")),
                                      TextButton(
                                          onPressed: () async {
                                            TimeOfDay? newtime =
                                                await showTimePicker(
                                                    context: context,
                                                    initialTime: matchtime!);
                                            if (newtime != null) {
                                              setState(() {
                                                matchtime = newtime;
                                              });
                                            }
                                          },
                                          child: Text("pick time")),
                                      TextField(
                                        controller: date,
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            print("bbbbbb" + selectedItem);
                                            print("ge");
                                            print(secondselected);

                                            String time = DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString();
                                            formvalidation(time);
                                            print(selecteddate);
                                            print(
                                                "${matchtime.hour}:${matchtime.minute}");
                                          },
                                          child: Text("Add Match Deatils")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"))
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                child: Center(child: Text("Loading")),
                              );
                      });
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
