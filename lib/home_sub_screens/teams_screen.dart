import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Global/global.dart';
import '../models/team_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'navigatescreen.dart';

class Teams_screen extends StatefulWidget {
  const Teams_screen({Key? key}) : super(key: key);
  @override
  State<Teams_screen> createState() => _Teams_screenState();
}

class _Teams_screenState extends State<Teams_screen> {
  TextEditingController teamnamecontroller = TextEditingController();

  // check the validation of the text fields
  formvalidation(String time) {
    if (teamnamecontroller.text.trim().isNotEmpty) {
      //login
      Adding_team(time);
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'please Enter Team Name',
              path: "animation/95614-error-occurred.json",
            );
          });
    }
  }

// adding team to the firebase function
  Adding_team(time) async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(
            message: 'Please wait',
            path: "animation/97930-loading.json",
          );
        });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Teams")
        .doc(time)
        .set({
      "id":time,
      "Name": teamnamecontroller.text,
    }).then((value) async {
      Navigator.pop(context);
      await sharedpreference!
          .setString("Team_Name", teamnamecontroller.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // for real time we use stream builder
          Container(
            height: MediaQuery.of(context).size.height * 0.58,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(firebaseAuth.currentUser!.uid)
                  .collection("Teams")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Team team = Team.fromJson(snapshot.data!.docs[index]
                              .data()! as Map<String, dynamic>);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                      focusColor: Colors.red,
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: Text(
                                              team.Name.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.055,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.deepPurple),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(firebaseAuth
                                                                .currentUser!
                                                                .uid)
                                                            .collection("Teams")
                                                            .doc(team.id)
                                                            .delete();
                                                      },
                                                      child: Container(
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                scrollable:
                                                                    true,
                                                                title: Text(
                                                                    'Update Team Name'),
                                                                content:
                                                                    Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Form(
                                                                    child:
                                                                        Column(
                                                                      children: <
                                                                          Widget>[
                                                                        TextFormField(
                                                                          controller:
                                                                              teamnamecontroller,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            labelText:
                                                                                'Name of the team',
                                                                            icon:
                                                                                Icon(Icons.account_box),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                      child: Text(
                                                                          "Update"),
                                                                      onPressed:
                                                                          () {

                                                                        if(teamnamecontroller.text.isNotEmpty){
                                                                          showDialog(context: context, builder: (c) {
                                                                            return Loading_Dialog(message: 'Please wait',
                                                                              path:"animation/97930-loading.json" ,);
                                                                          });
                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection("Users")
                                                                              .doc(firebaseAuth.currentUser!.uid)
                                                                              .collection("Teams")
                                                                              .doc(team.id)
                                                                              .update({
                                                                            "Name":
                                                                            teamnamecontroller.text,
                                                                          }).then((value){
                                                                            Navigator.pop(context);
                                                                          });
                                                                        }
                                                                        else{
                                                                          showDialog(context: context, builder: (c) {
                                                                            return Error_Dialog(message: "Please Enter Name to update"
                                                                                ,path:"animation/95614-error-occurred.json");
                                                                          });
                                                                        }


                                                                        // your code
                                                                      })
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child: Container(
                                                        child: Icon(
                                                          Icons.update,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Navigatetoscreen(
                                                      team: team,
                                                    )));
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
          ),
// floating action button to add new team to the firebase
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
                          title: Text('Add New Team'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: teamnamecontroller,
                                    decoration: InputDecoration(
                                      labelText: 'Name of the team',
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
                                  String time = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  formvalidation(time);
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
