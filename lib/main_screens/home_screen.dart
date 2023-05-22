import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../home_sub_screens/private_tournament_search_screen.dart';
import '../home_sub_screens/teams_screen.dart';
import '../home_sub_screens/tournament_showing_screen.dart';
import '../home_sub_screens/vanue_screen.dart';
import '../widgets/error_dialog.dart';

class Home_screen extends StatefulWidget {

  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
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
                          builder: (context) => Private_Tournament_search_screen(data: _chosenValue,)));
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





  User? currentuser;
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(length:3,
        child: Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            actions: [
              Row(
                children: [
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

                  child: Image.asset("animation/research.png",height:MediaQuery.of(context).size.height*0.04,width:MediaQuery.of(context).size.width*0.09 ,))),)
                ],
              ),
            ],
            elevation: 2,
            backgroundColor: Colors.black,
            shadowColor: Colors.white,
            title: Text("Go Tournament",

            ),centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "Tournaments",icon: Image.asset("animation/trophy(1).png",height:MediaQuery.of(context).size.height*0.051,width:MediaQuery.of(context).size.width*0.1 ,),),
                Tab(text: "Team",icon: Image.asset("animation/group.png",height:MediaQuery.of(context).size.height*0.051,width:MediaQuery.of(context).size.width*0.1 ,)),
                Tab(text: "Place",icon: Image.asset("animation/places.png",height:MediaQuery.of(context).size.height*0.051,width:MediaQuery.of(context).size.width*0.1 ,))
              ],
            ),),
          body: Container(
            child: TabBarView(
              children: [
                Tournament_home_screen(),
                Teams_screen(),
                Vanue_screen()
              ],
            ),
          ),
        ));
  }
}
