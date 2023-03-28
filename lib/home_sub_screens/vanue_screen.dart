import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../Global/global.dart';
import '../create_tournament_sub_screens/Navigate_tournament_full_detail_screen.dart';
import '../models/Main_Player_model.dart';
import '../models/New_Tournament_create_model.dart';
import '../models/Vanues_model.dart';
import '../models/final_added_teams_in_tournament_model.dart';
import '../vanue_sub_screen/pick_location_vanue.dart';
import '../vanue_sub_screen/vanue_detail_screen.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
class Vanue_screen extends StatefulWidget {
  const Vanue_screen({Key? key}) : super(key: key);

  @override
  State<Vanue_screen> createState() => _Vanue_screenState();
}

class _Vanue_screenState extends State<Vanue_screen> {
  TextEditingController vanuenamecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController vanuename = TextEditingController();
  var data;
  locationfinder()async{
    DocumentSnapshot snapshot=await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Vanue")
        .doc().get();
    print(snapshot.data());
    data=snapshot.data() as Map;
    print(data["Location"]);

  }
  formvalidation() {
    if (vanuenamecontroller.text.trim().isNotEmpty) {
      //login
      Adding_vanue ();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please Enter Name of the vanue',
            );
          });
    }
  }
  Adding_vanue() async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(
            message: 'Adding Player please wait',
          );
        });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Vanue")
        .doc(vanuenamecontroller.text)
        .set({
      "Name":vanuenamecontroller.text,
      "vanuename":vanuename.text,
      "Location":""
    }).then((value) async {
      await sharedpreference!.setString("Vanue_Name", vanuenamecontroller.toString());
      Navigator.pop(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          // for real time we use stream builder
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(firebaseAuth.currentUser!.uid)
                .collection("Vanue")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Vanues vanues = Vanues.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 10,),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.30,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                        trailing: SizedBox(
                                          width: MediaQuery.of(context).size.width*0.005,

                                        ),
                                        focusColor: Colors.red,
                                        title: Column(
                                          children: [
                                            Text(vanues.vanuename.toString()),
                                            Text(vanues.Location.toString()==""?"Add Location from map":vanues.Location.toString(),style: TextStyle(
                                              fontSize: 12
                                            ),)
                                          ],
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children:  [
                                            IconButton(onPressed: (){
                                              FirebaseFirestore.instance.collection("Users").
                                              doc(firebaseAuth.currentUser!.uid).
                                              collection("Vanue").doc(vanues.Name).delete();
                                            }, icon: Icon(Icons.delete)),

                                          ],
                                        ),
                                        onTap: () {
                                          // transfer data to new screen
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) =>Vanue_detail_screen(vanues: vanues,)));
                                        }),
                                    // TextButton(onPressed: (){
                                    //   locationfinder();
                                    // }, child: Text(data["Location"],style: TextStyle(color: Colors.black),))
                                  ],
                                ),
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
// floating action button to add new vanue to the firebase database
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text('Add New vanue'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: vanuenamecontroller,
                                    decoration: InputDecoration(
                                      labelText: 'Name of the vanue',
                                      icon: Icon(Icons.account_box),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: vanuename,
                                    decoration: InputDecoration(
                                      labelText: 'Name of the vanue',
                                      icon: Icon(Icons.account_box),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  formvalidation();
                                  // your code
                                })
                          ],
                        );
                      });
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ],
      ),
    );
  }
}



