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
  var _chosenValue;
  // void _showDecline() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState){
  //           return AlertDialog(
  //             title: new Text("Decline Appointment Request"),
  //             content: Container(
  //               child: SingleChildScrollView(
  //                 child: Form(
  //                   child: Column(
  //                     children: <Widget>[
  //                       TextFormField(
  //                         controller: tournamentcontroller,
  //                         decoration: InputDecoration(
  //                           labelText: 'Name of the Tournament',
  //                           icon: Icon(Icons.account_box),
  //                         ),
  //                       ),
  //
  //                       TextButton(onPressed:pickdateRange, child: Text("Pick Date Range")),
  //                       Text('${"Start Date :"}${dateRange.start}'),
  //                       Text('${"Start Date :"}${dateRange.end}'),
  //
  //                      Text("Please select  Province."),
  //                    DropdownButton<String>(
  //                         hint: Text('Select one option'),
  //                         value: _chosenValue,
  //                         underline: Container(
  //
  //                         ),
  //                         items: <String>[
  //                           'KPK',
  //                           'PUNJAB',
  //                           'BOLOCHISTAN',
  //                           'SINDH'
  //                         ].map((String value) {
  //                           return new DropdownMenuItem<String>(
  //                             value: value,
  //                             child: new Text(
  //                               value,
  //                               style: TextStyle(fontWeight: FontWeight.w200),
  //                             ),
  //                           );
  //                         }).toList(),
  //                         onChanged: (value) {
  //                           setState(() {
  //                             _chosenValue = value;
  //                           });
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             actions: <Widget>[
  //               // usually buttons at the bottom of the dialog
  //               TextButton(
  //                 child: new Text("Close"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //               TextButton(
  //                 child: new Text("ok"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //
  //       );
  //     },
  //   );
  // }



  DateTimeRange dateRange=
  DateTimeRange(start:
  DateTime(2023,4,5), end: DateTime(2023,4,10));





  TextEditingController name=TextEditingController();
  TextEditingController format=TextEditingController();
  TextEditingController total_teams=TextEditingController();
  TextEditingController phone_number=TextEditingController();
  TextEditingController Detail=TextEditingController();

  formvalidation() {
    if (name.text.trim().isNotEmpty &&
        format.text.isNotEmpty&&total_teams.text.trim().isNotEmpty
        &&phone_number.text.trim().isNotEmpty &&Detail.text.trim().isNotEmpty) {
      //login
      Adding_team();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: 'Please Enter All textfields',
            );
          });
    }
  }
  Adding_team() async {
    showDialog(
        context: context,
        builder: (c) {
          return Loading_Dialog(
            message: 'Adding Player please wait',
          );
        });
    var time=DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance
        .collection("All_Tournaments")
        .doc(name.text)
        .set({
      "Tournament_Name":name.text,
      "id":time.trim(),
      "format":format.text,
      "Phone_Number":phone_number.text,
      "Detail":Detail.text,
      "Total_Teams":total_teams.text,
      "Register_Teams":0.toString(),
      "Entry_Fees":0.toString(),
      "Winning_price":0.toString(),
      "Detail":"",
      "Start_tournament":start_selecteddate.toString(),
      "End_tournament":End_selecteddate.toString()
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(name.text)
        .set({
      "Tournament_Name":name.text,
      "id":time.trim(),
      "format":format.text,
      "Phone_Number":phone_number.text,
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
      // await sharedpreference!.setString("Start_date", startdatecontroller.text.trim());
      // await sharedpreference!.setString("End_date", enddatecontroller.text.trim());
      Navigator.pop(context);
    });
  }
  
  Future pickdateRange()async{
    DateTimeRange?newDateRange=await showDateRangePicker(context: context,
        firstDate: DateTime.now(), lastDate:DateTime(2023,4,4) );
    
    
    showDateRangePicker(context: context,
        initialDateRange: dateRange,
          firstDate:DateTime(2023, 3, 26), lastDate: DateTime(2024, 1, 1));
    if(newDateRange==null)return;
    setState(() {
      dateRange=newDateRange;
    });

  }
  
  

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
      height: MediaQuery.of(context).size.height * 0.57,
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
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.57,
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
                                  height: 10,),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(706, 112, 107, 107),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: ListTile(
                                      trailing: SizedBox(
                                        width: MediaQuery.of(context).size.width*0.01,
                                        // to enter the
                                        // delete and updaate icon
                                        child: Row(
                                          children:  [
                                          ],
                                        ),
                                      ),
                                      focusColor: Colors.red,
                                      title: Column(

                                        children: [
                                          Container(
                                            color: Colors.white,
                                            height: 10,
                                          ),
                                          Text((index+1).toString(),style: TextStyle(
                                            fontSize: 20,fontWeight: FontWeight.bold,
                                              color: Colors.white
                                          ),),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.004,
                                            color: Colors.white,
                                            width:  MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.1,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Tournament Name"),
                                              Text(
                                                new_tournamnent
                                                    .Tournament_Name
                                                    .toString(),

                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.004,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Tournament Format"),
                                              Text(
                                                  new_tournamnent.format
                                                      .toString(),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.004,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Start Date "),
                                              Text(new_tournamnent.Start_tournament.toString().split(" ").first)
                                            ],
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.004,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Final"),
                                              Text(new_tournamnent.End_tournament.toString().split(" ").first)
                                            ],
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.004,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [

                                              Text("Location"),
                                              Text("Hripur")
                                            ],
                                          ),

                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.03,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            height: 10,
                                          ),
                                        ],
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
            padding: const EdgeInsets.all(8.0),
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
                              backgroundColor: Colors.deepPurple,
                              scrollable: true,
                              title: Text('Create Tournament'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[

                                      Text_form_field(texthint:"Name",type: TextInputType.name,
                                          data: Icons.access_time,controller: name),



                                      TextButton(
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
                                      TextButton(
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

                                      Text_form_field(texthint:"Format",
                                          data: Icons.access_time,controller: format),

                                      Text_form_field(texthint:"Total Teams",type: TextInputType.number,
                                          data: Icons.access_time,controller: total_teams),
                                      Text_form_field(texthint:"Phone Number",type: TextInputType.number,
                                          data: Icons.access_time,controller: phone_number),
                                      Text_form_field(texthint:"Detail about Tournament",type: TextInputType.number,
                                          data: Icons.access_time,controller: Detail),

                                      // short address
                                    ],
                                  ),
                                ),
                              ),
                              actions: [

                                TextButton(
                                    child: Text("cancel"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // your code
                                    }),
                                TextButton(
                                    child: Text("Create now"),
                                    onPressed: () {
                                      formvalidation();
                                      // your code
                                    }),
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
