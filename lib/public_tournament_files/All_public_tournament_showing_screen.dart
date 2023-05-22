import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/public_tournament_files/single_tournament_detail_screen/Navigate_Screen_single_tournament_detail.dart';
import 'package:sports_app/public_tournament_files/single_tournament_detail_screen/result_screen_search.dart';
import '../models/all_tournament_showing_model.dart';
import '../widgets/error_dialog.dart';
import 'favorite_tournaments.dart';

class All_Tournament_showing_screen extends StatefulWidget {

  const All_Tournament_showing_screen({Key? key,}) : super(key: key);

  @override
  State<All_Tournament_showing_screen> createState() =>
      _All_Tournament_showing_screenState();
}

class _All_Tournament_showing_screenState
    extends State<All_Tournament_showing_screen> {
  var _chosenValue;
  void _showDecline() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return AlertDialog(
              shadowColor: Colors.orange,
              elevation: 20,
              backgroundColor: Colors.grey,
              title: new Text("SEARCH TOURNAMENT",style: TextStyle(
                color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
              ),),
              content: Container(
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                       Text("Search With",style: TextStyle(
                        color: Colors.white,fontSize: 15
                    )),
                     DropdownButton<String>(
                          hint: Text('Select one option',style: TextStyle(
                              color: Colors.white,fontSize: 15
                          )),
                          value: _chosenValue,
                          underline: Container(



                          ),
                          items: <String>[

                            'Tournament_Name',
                            'id',
                            'format',
                            'Entry_Fees'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(

                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _chosenValue = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[


                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset("animation/multiply.png"),),
                ),
                SizedBox(
                  width:MediaQuery.of(context).size.width * 0.15 ,
                ),
                // usually buttons at the bottom of the dialog
                GestureDetector(
                  onTap: (){
                    if(_chosenValue==null){
                      showDialog(context: context, builder: (c) {
                        return Error_Dialog(message: "Please Select one Option For Searching",path:"animation/95614-error-occurred.json");
                      });
                      print("please select option");
                    }
                    else{
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => tournament_SearchScreen( data:_chosenValue,)));
                    }



                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset("animation/check.png"),),
                ),
                SizedBox(
                  width:MediaQuery.of(context).size.width * 0.15 ,
                ),

              ],
            );
          },

        );
      },
    );
  }
  bool love=false;




  TextEditingController search=TextEditingController();
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
          title: Container(
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
              child: Text("All Tournament",style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ),
          actions: [
            Container(
              height:MediaQuery.of(context).size.height*0.5 ,
              width:MediaQuery.of(context).size.width*0.2 ,

              child: Row(
                children: [


                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Favorite_Tournaments()));

                          },
                          icon:Container(

                              child: Container(
                                  height:MediaQuery.of(context).size.height*0.10,width:MediaQuery.of(context).size.width*0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),

                                  child: Image.asset("animation/lover.png",height:MediaQuery.of(context).size.height*0.06,width:MediaQuery.of(context).size.width*0.15 ,))) ),


                      
                      IconButton(
                          onPressed: () {
                            _showDecline();
                          },
                          icon: Container(

                              child: Container(
                                  height:MediaQuery.of(context).size.height*0.060,width:MediaQuery.of(context).size.width*0.15,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),

                                  child: Image.asset("animation/research.png",height:MediaQuery.of(context).size.height*0.04,width:MediaQuery.of(context).size.width*0.09 ,)))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("All_Tournaments")
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
                                    height: MediaQuery.of(context).size.height * 0.57,
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

                                              SizedBox(
                                                height: MediaQuery.of(context).size.height*0.02,
                                              ),

                                              Container(
                                                height: MediaQuery.of(context).size.height*0.0755,
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
                                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                                  child: Column(
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

                                                          child: Padding(
                                                            padding: const EdgeInsets.only(right: 8.0),
                                                            child: Text(new_tournamnent.Location.toString(),style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.bold
                                                            ),),
                                                          ),
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
    );
  }
}
