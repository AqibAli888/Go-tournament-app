import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Global/global.dart';
import '../models/New_Tournament_create_model.dart';
import '../models/match_detail_model.dart';
import '../tournament_match_detail_result/match_result_screen.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/text_form_field.dart';

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
  var _chosenValue;
  void _showDecline()  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return AlertDialog(
              shadowColor: Colors.orange,
              elevation: 20,
              backgroundColor: Colors.grey,
              title: new Text("SEARCH TOURNAMENT",style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
              ),),
              content: Container(
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Text("Search With",style: TextStyle(
                            color: Colors.white,fontSize: 15
                        )),
                        DropdownButton<String>(
                          hint: Text('Select one option',style: TextStyle(
                              color: Colors.white,fontSize: 15
                          )),
                          value: _chosenValue,
                          underline: Container(



                          ),
                          items: <String>[

                            'Group',
                            'Qualifier',
                            'Semifinal',
                            'Final'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(

                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
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


                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(

                    child:Text("Select"),),
                ),


              ],
            );
          },

        );
      },
    );
  }

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
    if (selecteddate.toString().isNotEmpty&&
        matchtime.toString().isNotEmpty &&selectedItem!="" &&
        secondselected!="" && _chosenValue!=null) {
     // will update
      updating_match_schedule(id);
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
                message: "Please Enter All Fields",
                path: "animation/95614-error-occurred.json");
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
            message: 'Please wait ',
            path: "animation/97930-loading.json",
          );
        });
    FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule")
        .doc(id)
        .update({
      "Match_Type":_chosenValue,
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
      "Match_Type":_chosenValue,
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
    if (selecteddate.toString().isNotEmpty&&matchtime.toString().isNotEmpty
        &&selectedItem!="" && secondselected!=""&& _chosenValue!=null) {
      //login
      Adding_match_schedule(time);

    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
                message: "please fill all the fields",
                path: "animation/95614-error-occurred.json");

          }).then((value) {
        setState(() {
          selecteddate = DateTime.now();
        });
      });
    }
  }

  Adding_match_schedule(String time) async {
    showDialog(context: context, builder: (c) {
      return Loading_Dialog(message: 'Please wait',
        path:"animation/97930-loading.json" ,);
    });
    FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule")
        .doc(time)
        .set({
      "Match_Type":_chosenValue,
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
      "Match_Type":_chosenValue,
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
  TextEditingController Match_Type = TextEditingController();
  List<String> items = <String>[""];
  String selectedteam = "pk";
  String option2 = "select";
  @override
  Widget build(BuildContext context) {

    DocumentReference all_tournament_ref = FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name);

    DocumentReference pri_tournament_ref = FirebaseFirestore.instance
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
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
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
                  borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                  onPressed: () {
                    deletecollection();
                  },
                  child: Text(
                    "Delete All Schedule",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
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
                                    MediaQuery.of(context).size.height * 0.45,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
                                child: ListTile(
                                    trailing: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.00001,
                                      child: Row(
                                        children: [],
                                      ),
                                    ),
                                    focusColor: Colors.red,
                                    title: Padding(
                                      padding: const  EdgeInsets.only(
                                        left: 25.0,),
                                      // Match type
                                      child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.85,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.blue
                                                        .withOpacity(1),
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: Offset(
                                                      1,
                                                      1,
                                                    ),
                                                    blurStyle: BlurStyle
                                                        .solid // changes position of shadow
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.circular(
                                                  5)),
                                          // Match Type


                                          child: Center(child: Text(match_detail_model.Match_Type.toString()=="null"?"Match Type Not selected":match_detail_model.Match_Type.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),))),
                                    ),
                                    subtitle: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // team1 vs team 2 ui

                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                match_detail_model.team0.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.2,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.08,
                                                child: Image.asset(
                                                    "animation/election.png"),
                                              ),
                                              Text(
                                                match_detail_model.team1.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),

                                          // calender and date ui
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 35.0, top: 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  child: Image.asset(
                                                      "animation/calendar(1).png"),
                                                ),
                                                Text(
                                                  match_detail_model.Date
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),

                                          // clock and time ui
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    child: Image.asset(
                                                        "animation/clock.png"),
                                                  ),
                                                  Text(
                                                    "At ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    match_detail_model.Time
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),



                                          // result ui
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.blue
                                                            .withOpacity(1),
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                        offset: Offset(
                                                          1,
                                                          1,
                                                        ),
                                                        blurStyle: BlurStyle
                                                            .solid // changes position of shadow
                                                        ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    match_detail_model.result
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),


                                          //   delete and result update ui
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Center(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.blue
                                                              .withOpacity(1),
                                                          spreadRadius: 1,
                                                          blurRadius: 5,
                                                          offset: Offset(
                                                            1,
                                                            1,
                                                          ),
                                                          blurStyle: BlurStyle
                                                              .solid // changes position of shadow
                                                          ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0,
                                                              bottom: 5),
                                                      // delete button
                                                      child: IconButton(
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
                                                            color: Colors.red,
                                                          )),
                                                    ),

                                                    // update result
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              bottom: 5),
                                                      child: IconButton(
                                                          onPressed: () async {
                                                            DocumentSnapshot variable = await FirebaseFirestore
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
                                                                .get();
                                                            String team =
                                                                variable[
                                                                        "result"]
                                                                    .toString()
                                                                    .split(" ")
                                                                    .first;
                                                            if ((variable[
                                                                    "result"]) ==
                                                                "Result Not added") {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          Match_result_screen(
                                                                            new_tournament_model:
                                                                                widget.new_tournament_model,
                                                                            match_detail_model:
                                                                                match_detail_model,
                                                                          )));
                                                            } else if (team ==
                                                                match_detail_model
                                                                    .team0) {
                                                              print(team);
                                                              print("here 1");
                                                              print(
                                                                  match_detail_model
                                                                      .team0);
                                                              // result updaate
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
                                                                      "All_Tournaments")
                                                                  .doc(widget
                                                                      .new_tournament_model
                                                                      .Tournament_Name)
                                                                  .collection(
                                                                      "Teams_in_Tournament")
                                                                  .doc(match_detail_model
                                                                      .team0)
                                                                  .update({
                                                                "played":
                                                                    FieldValue
                                                                        .increment(
                                                                            -1),
                                                                "point": FieldValue
                                                                    .increment(
                                                                        -2),
                                                                "win": FieldValue
                                                                    .increment(
                                                                        -1)
                                                              });

                                                              //  decrease the other team played match

                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "All_Tournaments")
                                                                  .doc(widget
                                                                      .new_tournament_model
                                                                      .Tournament_Name)
                                                                  .collection(
                                                                      "Teams_in_Tournament")
                                                                  .doc(match_detail_model
                                                                      .team1)
                                                                  .update({
                                                                "played":
                                                                    FieldValue
                                                                        .increment(
                                                                            -1),
                                                              });

                                                              // decrease the get points played win all in private of team[0]

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
                                                                  .doc(match_detail_model
                                                                      .team0)
                                                                  .update({
                                                                "played":
                                                                    FieldValue
                                                                        .increment(
                                                                            -1),
                                                                "point": FieldValue
                                                                    .increment(
                                                                        -2),
                                                                "win": FieldValue
                                                                    .increment(
                                                                        -1)
                                                              });

                                                              //  decrease the other team played match

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
                                                                  .doc(match_detail_model
                                                                      .team1)
                                                                  .update({
                                                                "played":
                                                                    FieldValue
                                                                        .increment(
                                                                            -1),
                                                              }).then((value) {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (context) => Match_result_screen(
                                                                              new_tournament_model: widget.new_tournament_model,
                                                                              match_detail_model: match_detail_model,
                                                                            )));
                                                              });
                                                            } else if (team ==
                                                                match_detail_model
                                                                    .team1) {
                                                              print(team);
                                                              print("here 1");
                                                              print(
                                                                  match_detail_model
                                                                      .team0);
                                                              // result updaate
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
                                                                      "All_Tournaments")
                                                                  .doc(widget
                                                                      .new_tournament_model
                                                                      .Tournament_Name)
                                                                  .collection(
                                                                      "Teams_in_Tournament")
                                                                  .doc(match_detail_model
                                                                      .team1)
                                                                  .update({
                                                                "played":
                                                                    FieldValue
                                                                        .increment(
                                                                            -1),
                                                                "point": FieldValue
                                                                    .increment(
                                                                        -2),
                                                                "win": FieldValue
                                                                    .increment(
                                                                        -1)
                                                              });

                                                              //  decrease the other team played match

                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "All_Tournaments")
                                                                  .doc(widget
                                                                      .new_tournament_model
                                                                      .Tournament_Name)
                                                                  .collection(
                                                                      "Teams_in_Tournament")
                                                                  .doc(match_detail_model
                                                                      .team0)
                                                                  .update({
                                                                "played":
                                                                    FieldValue
                                                                        .increment(
                                                                            -1),
                                                              });

                                                              // decrease the get points played win all in private of team[0]

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
                                                                  .doc(match_detail_model
                                                                      .team1)
                                                                  .update({
                                                                "played":
                                                                    FieldValue
                                                                        .increment(
                                                                            -1),
                                                                "point": FieldValue
                                                                    .increment(
                                                                        -2),
                                                                "win": FieldValue
                                                                    .increment(
                                                                        -1)
                                                              });

                                                              //  decrease the other team played match

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
                                                                  .doc(match_detail_model
                                                                      .team0)
                                                                  .update({
                                                                "played":
                                                                    FieldValue
                                                                        .increment(
                                                                            -1),
                                                              }).then((value) {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (context) => Match_result_screen(
                                                                              new_tournament_model: widget.new_tournament_model,
                                                                              match_detail_model: match_detail_model,
                                                                            )));
                                                              });
                                                            }
                                                            // draw
                                                            else if (team ==
                                                                "Draw") {
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
                                                                  .doc(match_detail_model
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
                                                                  .doc(match_detail_model
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
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (context) => Match_result_screen(
                                                                              new_tournament_model: widget.new_tournament_model,
                                                                              match_detail_model: match_detail_model,
                                                                            )));
                                                              });
                                                            }

                                                            print(team);
                                                          },
                                                          icon: Icon(
                                                            Icons.update,
                                                            color: Colors.red,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    //   tap on the list index
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shadowColor: Colors.white,
                                              elevation: 10,
                                              backgroundColor: Colors.black,
                                              scrollable: true,
                                              title: Text(
                                                'Are You Sure to Update the Match Scheduling?',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              actions: [
                                                TextButton(
                                                    child: Text(
                                                      "cancel",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // your code
                                                    }),
                                                TextButton(
                                                    child: Text(
                                                      "Update",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
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
                                                            return items.length>1 && teamsadded.length>1? SingleChildScrollView(
                                                              child:
                                                                  AlertDialog(
                                                                title: Text(
                                                                    'Update Match Schedule'),
                                                                content: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Row(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: <Widget>[
                                                                        Icon(Icons.group),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 8.0, right: 8.0),
                                                                          child: Text('Select Team:'),
                                                                        ),
                                                                        Expanded(
                                                                          // add Expanded to have your dropdown button fill remaining space
                                                                          child: DropdownButton<String>(
                                                                            borderRadius:
                                                                            BorderRadius.circular(10),
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
                                                                        Icon(Icons.group),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 8.0, right: 8.0),
                                                                          child: Text('Select Team:'),
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

                                                                    Container(
                                                                      height:  MediaQuery.of(context).size.height*0.1,
                                                                      width:
                                                                      MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.black,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.blue
                                                                                  .withOpacity(0.5),
                                                                              spreadRadius: 1,
                                                                              blurRadius: 5,
                                                                              offset: Offset(0,
                                                                                  1), // changes position of shadow
                                                                            ),
                                                                          ],
                                                                          borderRadius:
                                                                          BorderRadius.circular(10)),
                                                                      child: GestureDetector(
                                                                        onTap: (){
                                                                          _showDecline();
                                                                        },
                                                                        child:  Center(
                                                                          child: Text("Match Type",style: TextStyle(
                                                                              color: Colors.white,fontSize: 13
                                                                          ),),
                                                                        ),),
                                                                    ),
                                                                    SizedBox(
                                                                      height: MediaQuery.of(context).size.height*0.02,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                      MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.black,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.blue
                                                                                  .withOpacity(0.5),
                                                                              spreadRadius: 1,
                                                                              blurRadius: 5,
                                                                              offset: Offset(0,
                                                                                  1), // changes position of shadow
                                                                            ),
                                                                          ],
                                                                          borderRadius:
                                                                          BorderRadius.circular(5)),
                                                                      child: TextButton(
                                                                          onPressed: () async {
                                                                            var myInt = widget
                                                                                .new_tournament_model
                                                                                .End_tournament
                                                                                .toString()
                                                                                .split(" ")
                                                                                .first;
                                                                            print(myInt);
                                                                            var year = int.parse(
                                                                                myInt.split("-").first);
                                                                            var month = int.parse(myInt
                                                                                .split("")
                                                                                .skip(5)
                                                                                .first);
                                                                            var monthh = int.parse(myInt
                                                                                .split("")
                                                                                .skip(6)
                                                                                .first);
                                                                            print(month);
                                                                            print(monthh);
                                                                            var m = int.parse(
                                                                                month.toString() +
                                                                                    monthh.toString());
                                                                            print(m);
                                                                            var day = int.parse(
                                                                                myInt.split("-").last);
                                                                            print("${year}y-${m}m-${day}");

                                                                            final DateTime? datetime =
                                                                            await showDatePicker(
                                                                                context: context,
                                                                                initialDate:
                                                                                DateTime.now(),
                                                                                firstDate: DateTime.now(),
                                                                                lastDate: DateTime(
                                                                                    year, m, day));
                                                                            if (datetime != null) {
                                                                              setState(() {
                                                                                selecteddate = datetime;
                                                                              });
                                                                            }
                                                                          },
                                                                          child: Text("pick date")),
                                                                    ),
                                                                    SizedBox(
                                                                      height: MediaQuery.of(context).size.height*0.02,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                      MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.black,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.blue
                                                                                  .withOpacity(0.5),
                                                                              spreadRadius: 1,
                                                                              blurRadius: 5,
                                                                              offset: Offset(0,
                                                                                  1), // changes position of shadow
                                                                            ),
                                                                          ],
                                                                          borderRadius:
                                                                          BorderRadius.circular(5)),
                                                                      child: TextButton(
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
                                                                    ),
                                                                    SizedBox(
                                                                      height: MediaQuery.of(context).size.height*0.02,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween
                                                                      ,
                                                                      children: [




                                                                        TextButton(
                                                                            onPressed: () {
                                                                              selectedteam="";
                                                                              selectedItem="";
                                                                              secondselected="";
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:Container(height: MediaQuery.of(context).size.height*0.1,
                                                                                child:Image.asset("animation/multiply.png"))),
                                                                        TextButton(
                                                                            onPressed: () async {
                                                                              Navigator.pop(
                                                                                  context);
                                                                              Updatematchdetail(match_detail_model
                                                                                  .id
                                                                                  .toString());
                                                                            },
                                                                            child:Container(height: MediaQuery.of(context).size.height*0.1,
                                                                                child:Image.asset("animation/accept.png")) ),
                                                                      ],
                                                                    ),


                                                                    SizedBox(
                                                                      height: MediaQuery.of(context).size.height*0.02,
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ):Container(
                                                              child: Center(child: Text("Loading")),
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
                backgroundColor: Colors.grey,
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
                                  backgroundColor: Colors.grey,
                                  elevation: 10,
                                  shadowColor: Colors.yellow,
                                  title: Text('Match Scheduling'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.group),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Text('Select Team:'),
                                          ),
                                          Expanded(
                                            // add Expanded to have your dropdown button fill remaining space
                                            child: DropdownButton<String>(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                          Icon(Icons.group),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Text('Select Team:'),
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

                                   Container(
                                     height:  MediaQuery.of(context).size.height*0.1,
                                     width:
                                     MediaQuery.of(context).size.width,
                                     decoration: BoxDecoration(
                                         color: Colors.black,
                                         boxShadow: [
                                           BoxShadow(
                                             color: Colors.blue
                                                 .withOpacity(0.5),
                                             spreadRadius: 1,
                                             blurRadius: 5,
                                             offset: Offset(0,
                                                 1), // changes position of shadow
                                           ),
                                         ],
                                         borderRadius:
                                         BorderRadius.circular(10)),
                                     child: GestureDetector(
                                       onTap: (){
                                         _showDecline();
                                       },
                                      child:  Center(
                                        child: Text("Match Type",style: TextStyle(
                                          color: Colors.white,fontSize: 13
                                        ),),
                                      ),),
                                   ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blue
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextButton(
                                            onPressed: () async {
                                              var myInt = widget
                                                  .new_tournament_model
                                                  .End_tournament
                                                  .toString()
                                                  .split(" ")
                                                  .first;
                                              print(myInt);
                                              var year = int.parse(
                                                  myInt.split("-").first);
                                              var month = int.parse(myInt
                                                  .split("")
                                                  .skip(5)
                                                  .first);
                                              var monthh = int.parse(myInt
                                                  .split("")
                                                  .skip(6)
                                                  .first);
                                              print(month);
                                              print(monthh);
                                              var m = int.parse(
                                                  month.toString() +
                                                      monthh.toString());
                                              print(m);
                                              var day = int.parse(
                                                  myInt.split("-").last);
                                              print("${year}y-${m}m-${day}");

                                              final DateTime? datetime =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(
                                                          year, m, day));
                                              if (datetime != null) {
                                                setState(() {
                                                  selecteddate = datetime;
                                                });
                                              }
                                            },
                                            child: Text("pick date")),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blue
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: TextButton(
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
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween
                                        ,
                                        children: [




                                          TextButton(
                                              onPressed: () {
                                                selectedteam="";
                                                selectedItem="";
                                                secondselected="";
                                                Navigator.pop(context);
                                              },
                                              child:Container(height: MediaQuery.of(context).size.height*0.1,
                                                  child:Image.asset("animation/multiply.png"))),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                String time = DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString();
                                                formvalidation(time);
                                              },
                                              child:Container(height: MediaQuery.of(context).size.height*0.1,
                                                  child:Image.asset("animation/accept.png")) ),
                                        ],
                                      ),


                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),

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




