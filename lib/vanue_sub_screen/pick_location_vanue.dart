import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:sports_app/models/Vanues_model.dart';


import '../Global/global.dart';
import '../home_sub_screens/vanue_screen.dart';
import '../widgets/error_dialog.dart';

class Pick_Location_Vanue extends StatefulWidget {
  final Vanues vanues;

  const Pick_Location_Vanue({Key? key, required this.vanues}) : super(key: key);

  @override
  State<Pick_Location_Vanue> createState() => _Pick_Location_VanueState();
}

class _Pick_Location_VanueState extends State<Pick_Location_Vanue> {
  add_location_to_firebase(location)async{
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Vanue")
        .doc(widget.vanues.id)
        .update({
      "Location": location,
    }).then((value){
      showDialog(
          context: context,
          builder: (c) {
           return Error_Dialog(message: 'selected'
              ,path:"animation/79952-successful.json" ,);
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
            buttonColor: Colors.grey,

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
