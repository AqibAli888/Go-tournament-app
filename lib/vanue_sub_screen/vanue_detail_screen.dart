import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:sports_app/vanue_sub_screen/pick_location_vanue.dart';
import '../Global/global.dart';
import '../models/Vanues_model.dart';

class Vanue_detail_screen extends StatefulWidget {
  final Vanues vanues;
  const Vanue_detail_screen({Key? key, required this.vanues}) : super(key: key);

  @override
  State<Vanue_detail_screen> createState() => _Vanue_detail_screenState();
}

class _Vanue_detail_screenState extends State<Vanue_detail_screen> {
  var data;
  datanew()async{
    DocumentSnapshot snapshot=   await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Vanue").doc(widget.vanues.Name).get();
    data=snapshot.data() as Map;
    data=data["Name"];
    print(data);
    setState(() {
      data=data["Name"];
    });
  }
  @override
  void dispose() {
    super.dispose();
    datanew();
  }
  @override
  Widget build(BuildContext context) {

    String Location;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                  child:  Text("My location")
                    ),
                ),
                TextButton(onPressed: ()async{
                  DocumentSnapshot snapshot=   await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(firebaseAuth.currentUser!.uid)
                      .collection("Vanue").doc(widget.vanues.Name).get();
                  data=snapshot.data() as Map;
                  data=data["Name"];
                  print(data);


                }, child: Text(

                  data.toString()==null.toString()?"location":data
                )),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>Pick_Location_Vanue(vanues: widget.vanues,)));
                }, child: Text("Pick location"))

]

          ),
        ),
    )
    );
  }
}
