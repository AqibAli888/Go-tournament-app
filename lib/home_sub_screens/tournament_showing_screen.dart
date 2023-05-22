import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/create_tournament_sub_screens/Navigate_tournament_full_detail_screen.dart';
import '../Global/global.dart';
import '../models/New_Tournament_create_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/text_form_field.dart';
import 'navigatescreen.dart';

class Tournament_home_screen extends StatefulWidget {

  const Tournament_home_screen({Key? key}) : super(key: key);
  @override
  State<Tournament_home_screen> createState() => _Tournament_home_screenState();
}

class _Tournament_home_screenState extends State<Tournament_home_screen> {
  DateTime start_selecteddate = DateTime.now();
  DateTime End_selecteddate = DateTime.now();
  DateTimeRange dateRange=
  DateTimeRange(start:
  DateTime(2023,4,5), end: DateTime(2023,4,10));

  DocumentReference priref=FirebaseFirestore.instance
      .collection("Users")
      .doc(firebaseAuth.currentUser!.uid);





  TextEditingController name=TextEditingController();
  TextEditingController format=TextEditingController();
  TextEditingController total_teams=TextEditingController();
  TextEditingController phone_number=TextEditingController();
  TextEditingController Detail=TextEditingController();

  formvalidation() {
    if (name.text.trim().isNotEmpty &&
        format.text.isNotEmpty&&total_teams.text.trim().isNotEmpty
        &&Detail.text.trim().isNotEmpty) {
      //login
      Adding_tournament();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please enter All the text fields'
              , path: "animation/95614-error-occurred.json",);
          });
  }
  }
  Adding_tournament() async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(message: 'Creating Tournament please wait',
            path:"animation/97930-loading.json" ,);
        });
    var time=DateTime.now().millisecondsSinceEpoch.toString();

    //public data store
    FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(name.text)
        .set({
      "fovorite":"false",
      "Tournament_Name":name.text,
      "id":time.trim(),
      "format":format.text,
      "Detail":Detail.text,
      "Total_Teams":total_teams.text,
      "Register_Teams":0.toString(),
      "Entry_Fees":0.toString(),
      "Location":"Not Added",
      "Winning_price":0.toString(),
      "Detail":"",
      "Start_tournament":start_selecteddate.toString(),
      "End_tournament":End_selecteddate.toString()
    });
    // private data store
    priref
        .collection("Tournaments")
        .doc(name.text)
        .set({
      "Tournament_Name":name.text,
      "id":time.trim(),
      "Location":"Not Added",
      "format":format.text,
      "Detail":Detail.text,
      "Total_Teams":total_teams.text,
      "Register_Teams":0.toString(),
      "Entry_Fees":0.toString(),
      "Winning_price":0.toString(),
      "Detail":"",
      "Start_tournament":start_selecteddate.toString(),
      "End_tournament":End_selecteddate.toString()

    }).then((value) async {
      await sharedpreference!.setString("Tournament_Name", name.text.trim());
      await sharedpreference!.setString("format", format.text.trim());
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child:Column(
        children: [
          Container(
      height: MediaQuery.of(context).size.height * 0.59,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(firebaseAuth.currentUser!.uid)
                  .collection("Tournaments")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  // shows tournaments if the tournament exists
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          New_Tournament_model new_tournamnent =New_Tournament_model.fromJson(snapshot.data!.docs[index]
                              .data()! as Map<String, dynamic>);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.01,),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.40,
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
                                        width: MediaQuery.of(context).size.width*0.00001,
                                        // to enter the
                                        // delete and updaate icon
                                        child: Row(
                                          children:  [
                                          ],
                                        ),
                                      ),
                                      focusColor: Colors.red,
                                      title: Padding(
                                        padding: const EdgeInsets.only(left: 20.0,top: 5),
                                        child: Column(

                                          children: [

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "Name",style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold
                                                ),

                                                ),
                                                Text(
                                                  new_tournamnent
                                                      .Tournament_Name
                                                      .toString(),style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                ),

                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height*0.01,
                                            ),

                                            Row(
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
                                                        .toString(),style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height*0.01,
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text("From",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                                Text(new_tournamnent.Start_tournament.toString().split(" ").first,style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                ),)
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height*0.01,
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text("To",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                                Text(new_tournamnent.End_tournament.toString().split(" ").first,style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold
                                                ),)
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height*0.01,
                                            ),
                                            Text("Location",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold
                                            ),),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height*0.01,
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height:MediaQuery.of(context).size.height*0.15 ,
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
                                                  padding: const EdgeInsets.only(left: 20.0,top: 10,bottom: 10,right: 10),
                                                  child: Center(
                                                    child: Text(new_tournamnent.Location.toString()=="null"?"Location not added":new_tournamnent.Location.toString(),style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                  ),
                                                ),
                                              ),
                                            )




                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        // transfer data to new screen
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>Navigate_Tournament_full_detail_screen(new_tournament_model: new_tournamnent)));
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
            padding: const EdgeInsets.only(right: 2.0,bottom: 2.0,top: 4.0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              backgroundColor: Colors.grey,
                              elevation: 10,

                              shadowColor: Colors.yellow,
                              scrollable: true,
                              title: Text('Create Tournament'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[

                                      Container(
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
                                        child: Text_form_field(texthint:"Name",type: TextInputType.name,
                                            data: Icons.drive_file_rename_outline,controller: name),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),
                                      Container(
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
                                        child: Text_form_field(texthint:"Format",
                                            data: Icons.question_mark_outlined,controller: format),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),
                                      Container(
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
                                        child: Text_form_field(texthint:"Total Teams",type: TextInputType.number,
                                            data: Icons.groups_rounded,controller: total_teams),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),




                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),

                                      Container(
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
                                        child: Text_form_field(texthint:"Detail about Tournament",type: TextInputType.text,
                                            data: Icons.textsms_outlined,controller: Detail),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),


                                      Container(
                                        width:MediaQuery.of(context).size.width ,
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
                                        child: TextButton(
                                            onPressed:
                                                () async {
                                              final DateTime? datetime = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2024));
                                              if (datetime !=
                                                  null) {
                                                setState(() {
                                                  start_selecteddate = datetime;
                                                });
                                                print(start_selecteddate);
                                              }
                                            },
                                            child: Text(
                                                "Pick Start Date")),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*0.02,
                                      ),
                                      Container(
                                        width:MediaQuery.of(context).size.width ,
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
                                        child: TextButton(
                                            onPressed:
                                                () async {
                                              final DateTime? datetime = await showDatePicker(
                                                  context: context,
                                                  initialDate: start_selecteddate,
                                                  firstDate: start_selecteddate,
                                                  lastDate: DateTime(2024));
                                              if (datetime !=
                                                  null) {
                                                setState(() {
                                                  End_selecteddate = datetime;
                                                });
                                                print( End_selecteddate);
                                              }
                                            },
                                            child: Text(
                                                "Pick Final Date")),
                                      ),





                                      // short address
                                    ],
                                  ),
                                ),
                              ),
                              actions: [

                                Container(
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
                                  child: TextButton(
                                      child: Text("cancel",style: TextStyle(
                                        color: Colors.white
                                      ),),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // your code
                                      }),
                                ),
                                SizedBox(width: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Container(
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
                                    child: TextButton(
                                        child: Text("Create now",style: TextStyle(
                                            color: Colors.white
                                        ),),
                                        onPressed: () {
                                          formvalidation();
                                          // your code
                                        }),
                                  ),
                                ),
                              ],
                            );
                          }
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
