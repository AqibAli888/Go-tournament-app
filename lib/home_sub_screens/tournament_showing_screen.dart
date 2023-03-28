import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/create_tournament_sub_screens/Navigate_tournament_full_detail_screen.dart';
import '../Global/global.dart';
import '../models/New_Tournament_create_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'navigatescreen.dart';

class Tournament_home_screen extends StatefulWidget {
  const Tournament_home_screen({Key? key}) : super(key: key);
  @override
  State<Tournament_home_screen> createState() => _Tournament_home_screenState();
}

class _Tournament_home_screenState extends State<Tournament_home_screen> {
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





  TextEditingController tournamentcontroller=TextEditingController();
  TextEditingController formatcontroller=TextEditingController();
  TextEditingController startdatecontroller=TextEditingController();
  TextEditingController enddatecontroller=TextEditingController();

  formvalidation() {
    if (tournamentcontroller.text.trim().isNotEmpty &&
        formatcontroller.text.isNotEmpty) {
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
        .doc(tournamentcontroller.text)
        .set({
      "Tournament_Name":tournamentcontroller.text,
      "id":time,
      "format":formatcontroller.text,
      "time":dateRange.toString(),
      "Location":"location"
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("Tournaments")
        .doc(tournamentcontroller.text)
        .set({
      "Tournament_Name":tournamentcontroller.text,
      "format":formatcontroller.text,
      "time":dateRange.toString(),
      "Location":"location"

    }).then((value) async {
      await sharedpreference!.setString("Tournament_Name", tournamentcontroller.text.trim());
      await sharedpreference!.setString("format", formatcontroller.text.trim());
      await sharedpreference!.setString("Start_date", startdatecontroller.text.trim());
      await sharedpreference!.setString("End_date", enddatecontroller.text.trim());
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
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(706, 112, 107, 107),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: ListTile(
                                      trailing: SizedBox(
                                        width: MediaQuery.of(context).size.width*0.3,
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
                                          Text(new_tournamnent.Tournament_Name.toString(),
                                            style: TextStyle(
                                            color: Colors.white
                                          ),
                                          ),
                                    Text(new_tournamnent.time.toString(),),



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
                              scrollable: true,
                              title: Text('Add Tournament'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: tournamentcontroller,
                                        decoration: InputDecoration(
                                          labelText: 'Name of the Tournament',
                                          icon: Icon(Icons.account_box),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:formatcontroller,
                                        decoration: InputDecoration(
                                          labelText: 'Tournament Format',
                                          icon: Icon(Icons.email),
                                        ),
                                      ),
                                      TextButton(onPressed:pickdateRange, child: Text("Pick Date Range")),
                                      Text('${"Start Date :"}${dateRange.start}'),
                                      Text('${"Start Date :"}${dateRange.end}')

                                      // province

                                      // district
                                      // tehsil

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
