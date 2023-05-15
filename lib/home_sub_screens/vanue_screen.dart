import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Global/global.dart';
import '../models/Vanues_model.dart';
import '../vanue_sub_screen/pick_location_vanue.dart';

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
  formvalidation(String id) {
    if (vanuenamecontroller.text.trim().isNotEmpty) {
      //login
      Adding_vanue (id);
    } else {
      showDialog(
          context: context,
          builder: (c) {
           return  Error_Dialog(message: 'Please Enter the Vanue Name'
              ,path:"animation/95614-error-occurred.json" ,);
          });
    }
  }
  Adding_vanue(String id) async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(message: 'Please Wait ',
            path:"animation/97930-loading.json" ,);
                });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Vanue")
        .doc(id)
        .set({
      "id":id,
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
          Container(
            height: MediaQuery.of(context).size.height * 0.58,
            child: StreamBuilder(
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
                                  height: MediaQuery.of(context).size.height * 0.33,
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
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                          trailing: SizedBox(
                                            width: MediaQuery.of(context).size.width*0.005,

                                          ),
                                          focusColor: Colors.red,
                                          title: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(vanues.vanuename.toString(),style: TextStyle(
                                                fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white
                                              ),),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.02,

                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0),
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height*0.17,
                                                  width:double.infinity,

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
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Center(
                                                      child: Text(vanues.Location.toString()==""?"Add Location from map\n         Tap to add":vanues.Location.toString(),style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white
                                                      ),),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.02,

                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 25.0),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.055,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                      color: Colors.white),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          FirebaseFirestore.instance
                                                              .collection("Users")
                                                              .doc(firebaseAuth.currentUser!.uid)
                                                              .collection("Vanue").doc(
                                                            vanues.id
                                                          ).delete();

                                                        },
                                                        child: Container(
                                                            height: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.05,
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.12,
                                                          child: Image.asset("animation/delete.png")
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          onTap: () {
                                            print(vanues.Location);
                                            // transfer data to new screen
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) =>Pick_Location_Vanue(vanues: vanues,)));
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

                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                                child: Text("Create"),
                                onPressed: () {
                                  String id = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  formvalidation(id);
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



