import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main_screens/option_screen_for_public_private.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'auth_screen.dart';

class Verify_email_screen extends StatefulWidget {
  const Verify_email_screen({Key? key}) : super(key: key);

  @override
  State<Verify_email_screen> createState() => _Verify_email_screenState();
}

class _Verify_email_screenState extends State<Verify_email_screen> {

  bool isverifiedemail=false;
  bool canresend=false;
  Timer?timer;
  @override
  void initState(){
    super.initState();
    isverifiedemail=FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isverifiedemail) {
      sendverificationemail();
      timer = Timer.periodic(
        Duration(seconds: 3),
            (_) => checkemailVerified(),
      );
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkemailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isverifiedemail=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isverifiedemail)timer?.cancel();
  }

  Future sendverificationemail() async{
    try{
      final user=FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canresend=false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canresend=true;
      });


    }catch(e){
      print(e.toString());
    }
  }





  @override
  Widget build(BuildContext context) {
    print(isverifiedemail.toString() + "not verified");
   return isverifiedemail?Option_Screen():Scaffold(
     backgroundColor: Colors.black12,

     appBar: AppBar(
       automaticallyImplyLeading: false,
       backgroundColor: Colors.black,
       title: Text("verify email to continue"),
     ),
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Container(
             height: MediaQuery.of(context).size.height*0.4,
             child:Lottie.asset("animation/verify.json")
         ),
         Text("Verification link has been sent to the email",style: TextStyle(
           color: Colors.white
         ),),
        ElevatedButton(
          onPressed: (){},
          // onPressed: canresend?sendverificationemail:null,
          child: Container(
            child: Text("Resend",style: TextStyle(
                color: Colors.tealAccent
            ),
          )

           ),
        ),
         Center(
           child: TextButton(
             onPressed: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const Auth_screen()),
               );
             },
             child: Text("Login page"),
           ),

         ),
         Center(
           child: TextButton(
             onPressed: (){
               FirebaseAuth.instance.signOut();
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const Auth_screen()),
               );

             },
             child: Text("cancel"),
           ),

         ),

       ],
     ),

    );
  }
}
