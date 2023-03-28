
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/models/all_tournament_showing_model.dart';
import 'package:sports_app/public_tournament_files/single_tournament_detail_screen/result_screen_search.dart';
import 'package:sports_app/public_tournament_files/single_tournament_detail_screen/search_screen.dart';
import 'package:sports_app/public_tournament_files/single_tournament_detail_screen/teams_added_in_tournament.dart';

import '../../models/New_Tournament_create_model.dart';
import 'Match_Schedule_result_screen.dart';
import 'Standing_screen.dart';

class Navigatetoscreen_tournament extends StatefulWidget {
  final All_Tournament_Showing_model all_tournament_showing_model;
  const Navigatetoscreen_tournament({Key? key, required this.all_tournament_showing_model,}) : super(key: key);

  @override
  State<Navigatetoscreen_tournament> createState() => _Navigatetoscreen_tournamentState();
}

class _Navigatetoscreen_tournamentState extends State<Navigatetoscreen_tournament> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
          children: [
            Text("Go Tournamenttt"),

          ],
        ),centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Teams",icon: Icon(Icons.group),),
              Tab(text: "Standing",icon: Icon(Icons.format_list_numbered),),
              Tab(text: "Schedule",icon: Icon(Icons.schedule),)
            ],
          ),),
        body: Container(
          color: Colors.black,
          child: TabBarView(
            children: [
              Teams_added_in_Tournament(all_tournament_showing_model:widget.all_tournament_showing_model,),
              Standing_screen(all_Tournament_Showing_model: widget.all_tournament_showing_model),
              Match_schedule_result_screen_public(all_Tournament_Showing_model: widget.all_tournament_showing_model),
                          ],
          ),
        ),
      ),
    );
  }
}
