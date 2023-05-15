import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/main_screens/home_screen.dart';
import '../Authentication/auth_screen.dart';
import '../public_tournament_files/All_public_tournament_showing_screen.dart';
import '../widgets/loading_dialog.dart';

class Option_Screen extends StatefulWidget {
  const Option_Screen({Key? key, }) : super(key: key);

  @override
  State<Option_Screen> createState() => _Option_ScreenState();
}

class _Option_ScreenState extends State<Option_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight:  MediaQuery.of(context).size.height * 0.15,
          backgroundColor: Colors.black,
          elevation: 1,
          shadowColor: Colors.white,
          centerTitle: true,
          title: Container(
            height:MediaQuery.of(context).size.height*0.060 ,
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
            child: Center(
              child: Text("GO TOURNAMENT",style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ),

        ),
        backgroundColor: Colors.black26,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home_screen()));
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
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
                        width: MediaQuery.of(context).size.width *0.75,
                        height: MediaQuery.of(context).size.height * 0.25,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: MediaQuery.of(context).size.height * 0.15,
                                child: Image.asset("animation/pointing.png"),),
                            ),
                            Center(child: Text("Your Tournaments",style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
                            ),))],
                        )),
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  Loading_Dialog(message: 'please wait',
                    path:"animation/97930-loading.json" ,);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => All_Tournament_showing_screen()));
                  Loading_Dialog(message: 'please wait',
                    path:"animation/97930-loading.json" ,);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(
                    child: Container(

                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.25,
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
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Image.asset("animation/public.png"),),

                            Center(child: Text("Public",style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
                            ),))],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(onPressed: (){
                  FirebaseAuth.instance.signOut().then((value){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Auth_screen()));
                  });
                }, child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Image.asset("animation/exit.png"),),

                    Text("Sign Out",style: TextStyle(
                      color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold
                    ),),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
