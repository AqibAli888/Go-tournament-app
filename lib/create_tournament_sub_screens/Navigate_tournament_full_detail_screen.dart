import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/create_tournament_sub_screens/teams_in_tournament.dart';
import 'package:sports_app/create_tournament_sub_screens/tournament_match_detail.dart';

import '../models/New_Tournament_create_model.dart';
import '../models/user_detail_model.dart';
import 'Basic_detail_screen_for_tournamnet.dart';
import 'Detail about tournament.dart';
import 'Standings_tournamen.dart';
import 'final_added_teams_in_tournament.dart';

class Navigate_Tournament_full_detail_screen extends StatefulWidget {

  final New_Tournament_model new_tournament_model;
  const Navigate_Tournament_full_detail_screen({Key? key, required this.new_tournament_model, }) : super(key: key);

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
          elevation: 2,
          shadowColor: Colors.white,

          title: Text("Go Tournamentt"),centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Deatail",icon: Image.asset("animation/resume.png",height:MediaQuery.of(context).size.height*0.051,width:MediaQuery.of(context).size.width*0.1 ,),),
              // Tab(text: "Basic Details",icon: Icon(Icons.info_outline),),
              Tab(text: "Teams in Tournament",icon: Image.asset("animation/group.png",height:MediaQuery.of(context).size.height*0.051,width:MediaQuery.of(context).size.width*0.1 ,),),
              Tab(text: "Added Teams in Tournament",icon: Image.asset("animation/customer.png",height:MediaQuery.of(context).size.height*0.051,width:MediaQuery.of(context).size.width*0.1 ,),),
              Tab(text: "Standings",icon: Image.asset("animation/side-menu.png",height:MediaQuery.of(context).size.height*0.051,width:MediaQuery.of(context).size.width*0.1 ,),),
              Tab(text: "Match Details",icon: Image.asset("animation/calendar.png",height:MediaQuery.of(context).size.height*0.051,width:MediaQuery.of(context).size.width*0.1 ,),)
            ],
          ),),
        body: Container(
          color: Colors.black,
          child: TabBarView(
            children: [
              // Basic_detail_screen(),
              Tournament_Deatail_Screen(new_tournament_model:widget.new_tournament_model,),
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
