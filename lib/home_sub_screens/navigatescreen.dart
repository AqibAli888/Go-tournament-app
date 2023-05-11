
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Team_Navigator_screen/Player_in_team.dart';
import '../models/team_model.dart';

class Navigatetoscreen extends StatefulWidget {
  final Team team;
  const Navigatetoscreen({Key? key,required this.team}) : super(key: key);

  @override
  State<Navigatetoscreen> createState() => _NavigatetoscreenState();
}

class _NavigatetoscreenState extends State<Navigatetoscreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,title: Row(
          children: [
            Text("Players In Team"),


          ],
        ),centerTitle: true,
          bottom: TabBar(
            tabs: [

              Tab(text: "Players in Team",icon: Icon(Icons.app_registration),)
            ],
          ),),
        body: Container(
          color: Colors.black,
          child: TabBarView(
            children: [
              Player_in_team(teamname: widget.team.Name.toString() ,)
            ],
          ),
        ),
      ),
    );
  }
}
