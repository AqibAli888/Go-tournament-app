//ok

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/public_tournament_files/single_tournament_detail_screen/Navigate_Screen_single_tournament_detail.dart';
import '../models/all_tournament_showing_model.dart';

class Favorite_Tournaments extends StatefulWidget {
  const Favorite_Tournaments({Key? key}) : super(key: key);

  @override
  State<Favorite_Tournaments> createState() => _Favorite_TournamentsState();
}

class _Favorite_TournamentsState extends State<Favorite_Tournaments> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.black,
          elevation: 5,
          shadowColor: Colors.white,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Container(
              height:MediaQuery.of(context).size.height*0.10 ,
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
              child: Center(
                child: Text("Favorite Tournament",style: TextStyle(
                  fontSize: 15,
                    color: Colors.white
                ),),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("All_Tournaments").where("fovorite",isEqualTo:"true")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    // shows tournaments if the tournament exists
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            All_Tournament_Showing_model new_tournamnent =
                            All_Tournament_Showing_model.fromJson(
                                snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height * 0.52,
                                    width:MediaQuery.of(context).size.width * 0.99 ,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                        trailing: SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.01,
                                          // to enter the
                                          // delete and updaate icon
                                          child: Row(
                                            children: [],
                                          ),
                                        ),
                                        focusColor: Colors.red,
                                        title: Padding(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context).size.height*0.035,

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
                                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text("Tournament Name",style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                      Text(
                                                        new_tournamnent
                                                            .Tournament_Name
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.02,
                                              ),

                                              Container(
                                                height: MediaQuery.of(context).size.height*0.035,

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
                                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text("Tournament Format",style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                      Text(
                                                          new_tournamnent.format
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.02,
                                              ),

                                              Container(
                                                height: MediaQuery.of(context).size.height*0.035,

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
                                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text("From",style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                      Text(
                                                        new_tournamnent
                                                            .Start_tournament
                                                            .toString().split(" ").first,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.02,
                                              ),

                                              Container(
                                                height: MediaQuery.of(context).size.height*0.035,

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
                                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text("Final Date",style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                      Text(
                                                        new_tournamnent.End_tournament
                                                            .toString().split(" ").first,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold
                                                        ),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.02,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height:MediaQuery.of(context).size.height*0.22 ,
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
                                                    padding: const EdgeInsets.only(left: 30.0,top: 10,bottom: 10,right: 10),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 20.0),
                                                          child: Container(
                                                            height: MediaQuery.of(context).size.height*0.035,
                                                            width:MediaQuery.of(context).size.width*0.25,

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
                                                            child: Center(
                                                              child: Text(
                                                                "Location",
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(context).size.height*0.012,
                                                        ),
                                                        Container(

                                                          child: Text(new_tournamnent.Location.toString(),style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )



                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Navigatetoscreen_tournament(
                                                        all_tournament_showing_model:
                                                        new_tournamnent,
                                                      )));

                                          // transfer data to new screen
                                          print(new_tournamnent.id);
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
            ],
          ),
        ),
      ),
    );;
  }
}
