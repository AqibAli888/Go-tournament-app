import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/all_tournament_showing_model.dart';
import 'Navigate_Screen_single_tournament_detail.dart';

class tournament_SearchScreen extends StatefulWidget {
  final String data;
  const tournament_SearchScreen({Key? key, required this.data,}) : super(key: key);

  @override


  _tournament_SearchScreenState createState() => _tournament_SearchScreenState();
}

class _tournament_SearchScreenState extends State<tournament_SearchScreen> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    print(widget.data);
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
                            .collection("All_Tournaments")
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
                              All_Tournament_Showing_model all_Tournament_Showing_model = All_Tournament_Showing_model.fromJson(snapshot.data!.docs[index]
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
                                          title: Text(all_Tournament_Showing_model.Tournament_Name.toString()),
                                          subtitle: Text("Click to See the Whole Tournament details"),
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                                builder: (context) => Navigatetoscreen_tournament(
                                                  all_tournament_showing_model: all_Tournament_Showing_model,)));
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
