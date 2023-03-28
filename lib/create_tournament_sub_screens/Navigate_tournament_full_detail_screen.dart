import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/create_tournament_sub_screens/teams_in_tournament.dart';
import 'package:sports_app/create_tournament_sub_screens/tournament_match_detail.dart';

import '../models/New_Tournament_create_model.dart';
import 'Basic_detail_screen_for_tournamnet.dart';
import 'Standings_tournamen.dart';
import 'final_added_teams_in_tournament.dart';

class Navigate_Tournament_full_detail_screen extends StatefulWidget {
  final New_Tournament_model new_tournament_model;
  const Navigate_Tournament_full_detail_screen({Key? key, required this.new_tournament_model}) : super(key: key);

  @override
  State<Navigate_Tournament_full_detail_screen> createState() => _Navigate_Tournament_full_detail_screenState();
}

class _Navigate_Tournament_full_detail_screenState extends State<Navigate_Tournament_full_detail_screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Go Tournamentt"),centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Basic Details",icon: Icon(Icons.info_outline),),
              Tab(text: "Teams in Tournament",icon: Icon(Icons.group),),
              Tab(text: "Added Teams in Tournament",icon: Icon(Icons.group),),
              Tab(text: "Standings",icon: Icon(Icons.format_list_numbered),),
              Tab(text: "Match Details",icon: Icon(Icons.calendar_month),)
            ],
          ),),
        body: Container(
          color: Colors.black,
          child: TabBarView(
            children: [
              Basic_detail_screen(),
              Teams_in_Tournament(new_tournament_model:widget.new_tournament_model, ),
              Final_added_teams_in_tournament(new_tournament_model:widget.new_tournament_model,),
              Standing_tournament(new_tournament_model: widget.new_tournament_model,),
              Tournament_match_detail(new_tournament_model: widget.new_tournament_model),


            ],
          ),
        ),
      ),
    );
  }
}
