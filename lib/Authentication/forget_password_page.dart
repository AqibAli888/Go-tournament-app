import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Future resetpassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email_controller.text.trim())
          .then((value) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c) {
              return Error_Dialog(
                message: 'Password reset link is sent in email',
              );
            });
      });
    } catch (err) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return Error_Dialog(
              message: err.toString(),
            );
          });
    }
  }

  final formkey = GlobalKey<FormState>();
  final email_controller = TextEditingController();
  @override
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
        title: Text("Reset password"),
      ),
      body: Column(
        children: [
          Text_form_field(
              controller: email_controller,
              data: Icons.email,
              texthint: "email",
              enabled: true,
              obscure: false),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (c) {
                    return Loading_Dialog(
                      message: 'password reset link is'
                          ' sent to your email address',
                    );
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
                  "Change password",
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
    );
  }
}
