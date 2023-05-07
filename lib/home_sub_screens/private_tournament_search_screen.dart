import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Global/global.dart';
import '../create_tournament_sub_screens/Navigate_tournament_full_detail_screen.dart';
import '../models/New_Tournament_create_model.dart';
import '../models/all_tournament_showing_model.dart';
import '../public_tournament_files/single_tournament_detail_screen/Navigate_Screen_single_tournament_detail.dart';

class Private_Tournament_search_screen extends StatefulWidget {
  final String data;
  const Private_Tournament_search_screen({Key? key, required this.data}) : super(key: key);

  @override
  State<Private_Tournament_search_screen> createState() => _Private_Tournament_search_screenState();
}

class _Private_Tournament_search_screenState extends State<Private_Tournament_search_screen> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor:  Colors.black,
        appBar: AppBar(
          elevation: 30,
          backgroundColor: Colors.grey,
          title: Text("Search Tournament",style: TextStyle(
              fontSize: 15
          ),),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search Tournament by Name",
                        fillColor: Colors.blue,
                        focusColor: Colors.blue,
                        hoverColor: Colors.yellow,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)
                        )
                    ),
                    onChanged: (val) {
                      setState(() {
                        inputText = val;
                        print(inputText);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: StreamBuilder(

                        stream: FirebaseFirestore.instance
                            .collection("Users")
                            .doc(firebaseAuth.currentUser!.uid)
                            .collection("Tournaments")
                            .where(widget.data,
                            isEqualTo: inputText)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Something went wrong"),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text("Loading"),
                            );
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                              New_Tournament_model _Tournament_Showing_model = New_Tournament_model.fromJson(snapshot.data!.docs[index]
                                  .data()! as Map<String, dynamic>);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 10,),
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.2,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(706, 112, 117, 107),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: ListTile(
                                          trailing: SizedBox(
                                              width: MediaQuery.of(context).size.width*0.05,
                                              child:Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10)
                                                ),


                                              )
                                          ),
                                          focusColor: Colors.red,
                                          title: Text(_Tournament_Showing_model.Tournament_Name.toString()),
                                          subtitle: Text("Click to See the Whole Tournament details"),
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                                builder: (context) => Navigate_Tournament_full_detail_screen(new_tournament_model:_Tournament_Showing_model,)));
                                          }),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
