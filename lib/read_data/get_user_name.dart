import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sports_app/models/New_Tournament_create_model.dart';

import '../Global/global.dart';

class Get_User_name extends StatelessWidget {
  final New_Tournament_model new_tournament_model;
  final String Documentid;
  const Get_User_name({Key? key, required this.Documentid, required this.new_tournament_model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference Teams=FirebaseFirestore.instance.collection(
        "Users"
    ).doc(firebaseAuth.currentUser!.uid).collection(
        "Tournaments"
    ).doc(new_tournament_model.Tournament_Name).
    collection("Teams_in_Tournament");

    return FutureBuilder<DocumentSnapshot>(future:Teams.doc(Documentid).get() ,
        builder: (context,snapshot){
      if(snapshot.connectionState==ConnectionState.done){
        Map<String,dynamic>data=snapshot.data!.data() as Map<String,dynamic>;
     return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(data["Team_Name"]),
         Text(data["Level"]),
         Text(data["point"].toString()),
         Text(data["point"].toString())
       ],
     );
      }
      return Text("Loading");

    }) ;
  }
}
