import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_app/widgets/progress_bar.dart';

class Loading_Dialog extends StatelessWidget {
  final String message;
  String? path;
  Loading_Dialog({
    required this.message,this.path
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Lottie.asset(path!,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.2),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: Center(
                            child: Text(
                              message,
                              style: TextStyle(fontSize: 15),
                            )))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
