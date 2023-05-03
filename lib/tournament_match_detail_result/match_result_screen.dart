import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Global/global.dart';
import '../models/New_Tournament_create_model.dart';
import '../models/match_detail_model.dart';

class Match_result_screen extends StatefulWidget {
  final New_Tournament_model new_tournament_model;
  final Match_Detail_model match_detail_model;
  const Match_result_screen({Key? key, required this.new_tournament_model, required this.match_detail_model}) : super(key: key);

  @override
  State<Match_result_screen> createState() => _Match_result_screenState();
}

class _Match_result_screenState extends State<Match_result_screen> {
  List<String> items = <String>[];
  List<String> newlist = <String>[];

  void getallteams(BuildContext context) async {
    await for (var messages in FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(widget.new_tournament_model.Tournament_Name)
        .collection("Tournament_schedule")
        .doc(widget.match_detail_model.id)
        .snapshots()) {
      for (var message in messages.data()!.values.toList()) {
        // print(message.toString());
        // print(items);
        if(message.toString()=="false"){
          print("not added");
          print(items);
        }
        else{
          if(message.toString().contains("1")){
            print(message.toString());
    }
          else{
            items.add(message.toString());
            print(items);
          }

        }


      }
      // print(items[2]);
      newlist.add("Draw");
      newlist.add(items[0]);
      newlist.add(items[1]);
      print(newlist);
    }
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getallteams(context));
    // Add listeners to this class
  }

  String selectedItem = "";
  String Value = "New York";
  String dropdownValue = "New York";
  late String selectedValue;
  int number=0;

  showPicker() {
    showModalBottomSheet(

        context: context,
        builder: (BuildContext context) {
          return CupertinoPicker(


            backgroundColor: Colors.white,
            onSelectedItemChanged: (value) {
              setState(() {
                number=value;
                selectedValue = value.toString();

              });
            },
            itemExtent: 32.0,
            children:[
              Text(newlist[0]),
              Text(newlist[1]),
              Text(newlist[2]),
            ],
          );
        });
  }




    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Who win the Match :"),
                  Text(newlist.length==0?"Not selected":newlist[number]),
                ],
              ),
              const SizedBox(height: 10.0),
              Center(
                child: TextButton(
                  onPressed: showPicker,
                    child: Text("Pick Team Who win the match"),
                ),
              ),
              TextButton(onPressed: (){
                if(newlist[number]=="Draw"){
                  print("Draw");
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(firebaseAuth.currentUser!.uid)
                      .collection("Tournaments")
                      .doc(widget.new_tournament_model.Tournament_Name)
                      .collection("Teams_in_Tournament").doc(newlist[1]).update({
                    "point":FieldValue.increment(1)
                  });
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(firebaseAuth.currentUser!.uid)
                      .collection("Tournaments")
                      .doc(widget.new_tournament_model.Tournament_Name)
                      .collection("Teams_in_Tournament").doc(newlist[2]).update({
                    "point":FieldValue.increment(1)
                  });
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(firebaseAuth.currentUser!.uid)
                      .collection("Tournaments")
                      .doc(widget.new_tournament_model.Tournament_Name)
                      .collection("Tournament_schedule").doc(widget.match_detail_model.id).update({
                    "result":"Match has been drawn"
                  });
                  FirebaseFirestore.instance
                      .collection("All_Tournaments").
                  doc(widget.new_tournament_model.Tournament_Name)
                      .collection("Tournament_schedule").doc(widget.match_detail_model.id).update({
                    "result":"Match has been drawn"
                  });

                }

      else{
      FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("Tournaments")
          .doc(widget.new_tournament_model.Tournament_Name)
          .collection("Teams_in_Tournament").doc(newlist[number]).update({
      "point":FieldValue.increment(2),
      "win":FieldValue.increment(1),
      "result":newlist[number]
      });
      FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("Tournaments")
          .doc(widget.new_tournament_model.Tournament_Name)
          .collection("Teams_in_Tournament").doc(newlist[1]).update({
      "played":FieldValue.increment(1)
      });
      FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("Tournaments")
          .doc(widget.new_tournament_model.Tournament_Name)
          .collection("Teams_in_Tournament").doc(newlist[2]).update({
      "played":FieldValue.increment(1)
      });
      FirebaseFirestore.instance
          .collection("All_Tournaments").
      doc(widget.new_tournament_model.Tournament_Name)
          .collection("Teams_in_Tournament")
          .doc(newlist[number]).update({
      "point":FieldValue.increment(2),
      "win":FieldValue.increment(1),
      "result":newlist[number]
      });
      FirebaseFirestore.instance
          .collection("All_Tournaments").
      doc(widget.new_tournament_model.Tournament_Name)
          .collection("Teams_in_Tournament").doc(newlist[2]).update({
      "played":FieldValue.increment(1)
      });

      FirebaseFirestore.instance
          .collection("All_Tournaments").
      doc(widget.new_tournament_model.Tournament_Name)
          .collection("Teams_in_Tournament").doc(newlist[1]).update({
      "played":FieldValue.increment(1)
      });

      FirebaseFirestore.instance
          .collection("All_Tournaments").
      doc(widget.new_tournament_model.Tournament_Name)
          .collection("Teams_in_Tournament").doc(newlist[1]).update({
        "played": FieldValue.increment(1)
      });
      FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("Tournaments")
          .doc(widget.new_tournament_model.Tournament_Name)
          .collection("Tournament_schedule").doc(widget.match_detail_model.id).update({
        "result":(newlist[number]) + " win the match"
      });
      FirebaseFirestore.instance
          .collection("All_Tournaments").
      doc(widget.new_tournament_model.Tournament_Name)
          .collection("Tournament_schedule").doc(widget.match_detail_model.id).update({
        "result":(newlist[number]) + " win the match"
      });
      print(newlist[number]);

      }



              },
                  child: Text("SAVE"))

            ],
          ),
        ),
      );
    }
  }


