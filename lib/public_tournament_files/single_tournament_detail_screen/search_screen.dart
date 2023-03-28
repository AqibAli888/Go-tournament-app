import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/all_tournament_showing_model.dart';

class Search_screen extends StatefulWidget {
  final All_Tournament_Showing_model all_tournament_showing_model;
  const Search_screen({Key? key, required this.all_tournament_showing_model}) : super(key: key);

  @override
  State<Search_screen> createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {
  List Searchresult=[];
  void searchfromfirebase(String querry)async{
    final result=await FirebaseFirestore.instance.collection("All_Tournaments").where(
      "id",
      isEqualTo: querry
    ).get();
    setState(() {
      Searchresult=result.docs.map((e) => e.data()).toList();

    });


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Tournament"),
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search"
              ),
              onChanged: (querry){
                searchfromfirebase(querry);
              },
            ),
           Expanded(
             child: ListView.builder(itemCount:Searchresult.length,itemBuilder: (context,index){
               return GestureDetector(
                 onTap: (){

                 },

                 child: Container(
                   child: Column(
                     children: [
                   Text(Searchresult[index]["Tournament_Name"]),
                       Text(Searchresult[index]["Tournament_Name"]),

                     ],
                   ),
                 ),
               );
             }),
           )
            
          ],
        ),
      ),
    );
  }
}
