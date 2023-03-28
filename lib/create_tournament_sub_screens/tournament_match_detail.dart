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
Future<void>deletecollection()async{
  var collection=await FirebaseFirestore.instance
      .collection('Users')
      .doc(firebaseAuth.currentUser!.uid)
      .collection("Tournaments")
      .doc(widget
      .new_tournament_model.Tournament_Name)
      .collection("Tournament_schedule");
  var snapshot=await collection.get();
  for(var doc in snapshot.docs){
    await doc.reference.delete();
  }
  var newcollection=await FirebaseFirestore.instance
      .collection("All_Tournaments").
  doc(widget.new_tournament_model.Tournament_Name)
      .collection("Tournament_schedule");
  var newsnapshot=await newcollection.get();
  for(var doc in newsnapshot.docs){
    await doc.reference.delete();
  }

}

  formvalidation(String time) {
    if (date.text.trim().isNotEmpty
     ) {
      //login
      Adding_team(time);
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please Enter All textfields',
            );
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
        .collection("All_Tournaments").doc(widget.new_tournament_model.Tournament_Name).
    collection("Tournament_schedule")
        .doc(time)
        .set({
      "id": time.toString(),
      "team0": selectedItem,
      "team1": secondselected,
      "team0_win": false,
      "team1_win": false
    });


    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget
        .new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule")
        .doc(time)
        .set({
      "id": time.toString(),
      "team0": selectedItem,
      "team1": secondselected,
      "team0_win": false,
      "team1_win": false
    }).then((value){
      secondselected = "";
      selectedItem = "";
      Navigator.pop(context);
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
          Container(decoration: BoxDecoration(
      color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextButton(onPressed: (){
        deletecollection();
      }, child: Text("Delete All Schedule",style: TextStyle(
          color: Colors.white
      ),))),

          StreamBuilder(
            stream:FirebaseFirestore.instance
                .collection('Users')
                .doc(firebaseAuth.currentUser!.uid)
                .collection("Tournaments")
                .doc(widget
                .new_tournament_model.Tournament_Name)
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
                        Match_Detail_model match_detail_model =Match_Detail_model.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 10,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)
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
                                        Text(match_detail_model.team0.toString()),

                                        Text("VS"),
                                        Text(match_detail_model.team1.toString()),

                                      ],
                                    ),
                                    subtitle: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(match_detail_model.id.toString()),
                                          Text(match_detail_model.result.toString()),
                                          Text(match_detail_model.result.toString()),
                                          Row(
                                            children: [
                                              IconButton(onPressed: (){
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(firebaseAuth.currentUser!.uid)
                                                    .collection("Tournaments")
                                                    .doc(widget
                                                    .new_tournament_model.Tournament_Name)
                                                    .collection("Tournament_schedule").doc(match_detail_model.id).delete();

                                              }, icon:Icon(Icons.delete,color: Colors.white,)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => Match_result_screen(new_tournament_model: widget.new_tournament_model,
                                            match_detail_model: match_detail_model,)));
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
                        return SingleChildScrollView(
                          child: AlertDialog(
                            title: Text('Alert Dialog'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.volume_up),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.0, right: 8.0),
                                      child: Text('Select one:'),
                                    ),
                                    Expanded(
                                      // add Expanded to have your dropdown button fill remaining space
                                      child: DropdownButton<String>(
                                        isExpanded:
                                            true, // this allows your dropdown icon to be visible
                                        value: items.isNotEmpty ? selectedItem : null,
                                        iconSize: 24,
                                        items: items.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (value) => setState(() {
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
                                Text("hello"),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.volume_up),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.0, right: 8.0),
                                      child: Text('Select one:'),
                                    ),
                                    Expanded(
                                      // add Expanded to have your dropdown button fill remaining space
                                      child: DropdownButton<String>(
                                        isExpanded:
                                            true, // this allows your dropdown icon to be visible
                                        value:
                                            teamsadded.isNotEmpty ? selectedItem : null,
                                        iconSize: 24,
                                        items: teamsadded.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (value) => setState(() {
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
                                TextField(
                                  controller: location,
                                ),
                                TextField(
                                  controller: date,
                                ),
                                TextButton(
                                    onPressed: () async {

                                      Navigator.pop(context);
                                      print("bbbbbb"+ selectedItem);
                                      print("ge");
                                      print(secondselected);
                                      String time =
                                          DateTime.now().millisecondsSinceEpoch.toString();
                                      formvalidation(time);
                                    },
                                    child: Text("Add Match Deatils")),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child:Text("Cancel"))
                              ],
                            ),
                          ),
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