import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Text_form_field extends StatelessWidget {
  final TextEditingController controller;
  final String texthint;
  final IconData? data;
  int? min;
  int? max;

TextInputType? type;
  bool? obscure;

  bool?enabled;
  Text_form_field({
    this.type,
    required this.controller,required this.texthint,this.obscure=false,required this.data
,this.enabled=true,this.max, this.min});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8),
      child: TextFormField(
        maxLength: max,
        minLines: min,

        keyboardType:type,
        controller: controller,
        enabled: enabled,
        obscureText: obscure!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(

          border: InputBorder.none,
              prefixIcon: Icon(
            data,
                color: Colors.black,
        ),
          focusColor: Theme.of(context).primaryColor,
          hintText: texthint
        ),
      ),
    );
  }
}
