import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_app/Global/global.dart';
import 'package:sports_app/main_screens/option_screen_for_public_private.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/text_form_field.dart';
import 'forget_password_page.dart';
import 'login succesfully confirmation.dart';

class Login extends StatefulWidget {

  const Login({Key? key,}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  formvalidation(){
    if(emailcontroller.text.trim().isNotEmpty && passwordcontroller.text.isNotEmpty){
      //login
      Login();

    }
    else{
      showDialog(context: context, builder: (c) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            //
            Error_Dialog(message: 'Please Enter All textfields'
              ,path:"animation/95614-error-occurred.json" ,),
          ],
        );
      });
    }
  }

  User? currentuser;
  Login()async{
    showDialog(context: context, builder: (c) {
      return Loading_Dialog(message: 'Checking Credintial',
        path:"animation/97930-loading.json" ,);
    });
    await firebaseAuth.signInWithEmailAndPassword(email: emailcontroller.text.trim(), password:passwordcontroller.text.trim()).then((auth){
      currentuser=auth.user!;
      if(currentuser!=null){
        if(firebaseAuth.currentUser!.emailVerified){
          savedatalocally(currentuser).then((value){




            print("email is verified");

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Successfully_Login()));


          }

          );

        }
        else{
          Navigator.pop(context);
          showDialog(context: context, builder: (c) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                //
                Error_Dialog(message: 'Email is not Verified \n'"Please verify the email first"
                  ,path:"animation/95614-error-occurred.json" ,),
              ],
            );
          });
        }


      }

    }).catchError((err) {
      Navigator.pop(context);
      showDialog(context: context, builder: (c) {
        return Error_Dialog(message: err.message.toString(),path:"animation/95614-error-occurred.json");
      });
      }
    );  }


  Future savedatalocally(User? currentuser)async{
    await FirebaseFirestore.instance.collection("Users").doc(currentuser!.uid).get().then((snapshot)async{
      await sharedpreference!.setString("uid",currentuser.uid);
      await sharedpreference!.setString("name",snapshot.data()!["Name"]);
      await sharedpreference!.setString("email",snapshot.data()!["useremail"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(

        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.20,
                  width:MediaQuery.of(context).size.width*0.38 ,
                  child: Lottie.asset("animation/85568-user-login.json",
                      height:MediaQuery.of(context).size.height*0.60,fit: BoxFit.fitHeight ),
                ),
              ],
            ),

            Form(
                key: _formkey,
                child:Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.010,
                    ),
                    Text_form_field(controller: emailcontroller,
                        texthint:"Enter Your Email",
                        data: Icons.mail),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.002,
                    ),
                    Text_form_field(controller: passwordcontroller,
                      texthint:"Enter Your password",
                      data: Icons.lock_clock_outlined,obscure: true,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.002,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
                    ),
                    GestureDetector(
                      onTap: (){
                        formvalidation();
                      },
                      child: Container(
                        padding: EdgeInsets.all(0.8),
                        margin: EdgeInsets.all(0.8),
                        height:MediaQuery.of(context).size.height*0.07 ,
                        width: MediaQuery.of(context).size.width*0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.login),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.03,
                              ),
                              Center(child: Text("Login")),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => Forget_password_page()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text("forget password",style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ))

          ],
        ),
      ),
    );
  }
}
