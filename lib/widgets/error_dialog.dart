import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Error_Dialog extends StatelessWidget {
  final String message;
  String? path;
  Error_Dialog({required this.message, this.path});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.99,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"))
            ],
          ),
        ),
      ),
    );
  }
}
