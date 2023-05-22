import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_app/Authentication/auth_screen.dart';

import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/text_form_field.dart';

class Forget_password_page extends StatefulWidget {
  const Forget_password_page({Key? key}) : super(key: key);

  @override
  State<Forget_password_page> createState() => _Forget_password_pageState();
}

class _Forget_password_pageState extends State<Forget_password_page> {


  // password reset function
  Future resetpassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email_controller.text.trim())
          .then((value) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c) {
             return Error_Dialog(message: 'Sent succefully '
                ,path:"animation/79952-successful.json" ,);
            });
      });
    } catch (err) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(message: err.toString().split("]").last
              ,path:"animation/95614-error-occurred.json" ,);
          });
    }
  }

  final formkey = GlobalKey<FormState>();
  final email_controller = TextEditingController();
  @override
  // dispose to clear the controller text
  void dispose() {
    email_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(child: Text("Reset Password")),
      ),
      body: SingleChildScrollView(
        child: Column(






          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.4,
                child:Lottie.asset("animation/forget.json")
            ),
            // email of the user that he want to reset
            Text_form_field(
                controller: email_controller,
                data: Icons.email,
                texthint: "Enter Your Email to Reset password",
                enabled: true,
                obscure: false),
            SizedBox(
              height: 10,
            ),

            // reset button
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (c) {
                      return Loading_Dialog(message: 'Please Wait',
                        path:"animation/verify.json" ,);
                    });
                resetpassword();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent),
                child: Center(
                  child: Text(
                    "Sent",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            ),




            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Auth_screen()));

              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent),
                child: Center(
                  child: Text(
                    "Login page",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
