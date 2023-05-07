import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../Global/global.dart';
import '../models/New_Tournament_create_model.dart';
import '../widgets/error_dialog.dart';

class Pick_Match_Location extends StatefulWidget {
  final New_Tournament_model new_tournament_model;
  const Pick_Match_Location({Key? key, required this.new_tournament_model}) : super(key: key);

  @override
  State<Pick_Match_Location> createState() => _Pick_Match_LocationState();
}

class _Pick_Match_LocationState extends State<Pick_Match_Location> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: OpenStreetMapSearchAndPick(
            center: LatLong(33.9946, 72.9106),
            buttonColor: Colors.blue,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
              add_location_to_firebase(pickedData.address);
            }),
      ),
    );
  }
}
