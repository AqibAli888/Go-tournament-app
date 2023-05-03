import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/New_Tournament_create_model.dart';
import '../models/user_detail_model.dart';

class Tournament_Deatail_Screen extends StatefulWidget {

  final New_Tournament_model new_tournament_model;

  const Tournament_Deatail_Screen({Key? key, required this.new_tournament_model,
  }) : super(key: key);






  @override
  State<Tournament_Deatail_Screen> createState() => _Tournament_Deatail_ScreenState();
}





class _Tournament_Deatail_ScreenState extends State<Tournament_Deatail_Screen> {
  Map<String,dynamic>? userdata;



  @override
  void initState () {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });

  }
  _asyncMethod() async {
    var  document = await FirebaseFirestore.instance.collection('Users').
    doc(FirebaseAuth.instance.currentUser!.uid).get();
    Map<String,dynamic>? value = document.data();
    setState(() {
      userdata=value;
    });
    print(userdata!['Name']);

    print(value!['Name']);
  }



  // @override
  // Future initState()async {
  //   super.initState();
  //   var  document = await FirebaseFirestore.instance.collection('Users').
  //   doc(FirebaseAuth.instance.currentUser!.uid).get();
  //   Map<String,dynamic>? value = document.data();
  //   print(value!['Name']);
  // }



  @override
  Widget build(BuildContext context) {
    return userdata==null?Center(child: Text("Loading",style: TextStyle(
      color: Colors.white
    ),)):Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.10,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: Center(child: Text("Tournament Details")),

                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tournament Creator :"),
                              Text(userdata!['Name'])
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Email Address:"),
                              Text(userdata!['useremail'])
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Phone Number :"),
                              Text(userdata!['Phone'])
                            ],
                          ),


                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                GestureDetector(
                  onTap: (){

                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.10,
                      width: MediaQuery.of(context).size.width*0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Teams :"),
                                Text("12")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Registered Teams :"),
                                Text("6")
                              ],
                            ),



                          ],
                        ),
                      ),

                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tournament Start Date :"),
                              Text("12/12/2023")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Final Date :"),
                              Text("12/12/2023")
                            ],
                          ),



                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Entry Fees :"),
                              Text("500 rs")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Winning price :"),
                              Text("1000rs")
                            ],
                          ),



                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(child: Text("Location :")),
                             SizedBox( height: MediaQuery.of(context).size.height*0.025,),
                              Center(child: Text("qazipur"))
                            ],
                          ),




                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(child: Text("Details")),
                              SizedBox( height: MediaQuery.of(context).size.height*0.025,),
                              Row(
                                children: [
                                  Text("qazipur"),
                                ],
                              )
                            ],
                          ),




                        ],
                      ),
                    ),

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
