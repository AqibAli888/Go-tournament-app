import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Basic_detail_screen extends StatefulWidget {
  const Basic_detail_screen({Key? key}) : super(key: key);

  @override
  State<Basic_detail_screen> createState() => _Basic_detail_screenState();
}

class _Basic_detail_screenState extends State<Basic_detail_screen> {
  int encounter_value=1;
  int win_point=1;
  int loss_point=0;
  int draw_points=1;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // no of encounters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Number of Encounters",style: TextStyle(
                    color: Colors.white
                ),),
                Row(
                  children: [
                    Center(
                      child: Center(child: IconButton(onPressed: (){
                        setState(() {
                          if(encounter_value==1){
                            encounter_value=encounter_value;
                          }
                          else if(encounter_value>1){
                            encounter_value=encounter_value-1;
                          }

                        });
                      }, icon:Icon(Icons.remove,color: Colors.white,))),
                    ),
                    Text(encounter_value.toString(),style: TextStyle(
                        color: Colors.white
                    ),),
                    IconButton(onPressed: (){
                      setState(() {

                        encounter_value=encounter_value+1;
                      });
                    }, icon:Icon(Icons.add,color: Colors.white,)),

                  ],
                ),
              ],
            ),
            // win points
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Points for win",style: TextStyle(
                    color: Colors.white
                ),),
                Row(
                  children: [
                    Center(
                      child: Center(child: IconButton(onPressed: (){
                        setState(() {
                          if(win_point==0){
                            win_point=win_point;
                          }
                          else if(win_point>0){
                            win_point=win_point-1;
                          }

                        });
                      }, icon:Icon(Icons.remove,color: Colors.white,))),
                    ),
                    Text(win_point.toString(),style: TextStyle(
                        color: Colors.white
                    ),),
                    IconButton(onPressed: (){
                      setState(() {
                        if(win_point==9){
                          win_point=win_point;
                        }
                        else{
                          win_point=win_point+1;
                        }
                      });
                    }, icon:Icon(Icons.add,color: Colors.white,)),

                  ],
                ),
              ],
            ),
            // loss  points
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Points for loss",style: TextStyle(
                    color: Colors.white
                ),),
                Row(
                  children: [
                    Center(
                      child: Center(child: IconButton(onPressed: (){
                        setState(() {
                          if(loss_point==-9){
                            loss_point=loss_point;
                          }
                          else{
                            loss_point=loss_point-1;
                          }

                        });
                      }, icon:Icon(Icons.remove,color: Colors.white,))),
                    ),
                    Text(loss_point.toString(),style: TextStyle(
                        color: Colors.white
                    ),),
                    IconButton(onPressed: (){
                      setState(() {
                        if(loss_point==0){
                          loss_point=loss_point;
                        }
                        else{
                          loss_point=loss_point+1;
                        }
                      });
                    }, icon:Icon(Icons.add,color: Colors.white,)),

                  ],
                ),
              ],
            ),
            // draw points
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Points for Draw",style: TextStyle(
                  color: Colors.white
                ),),
                Row(
                  children: [
                    Center(
                      child: Center(child: IconButton(onPressed: (){
                        setState(() {
                          if(draw_points==-9){
                            draw_points=draw_points;
                          }
                          else{
                            draw_points=draw_points-1;
                          }

                        });
                      }, icon:Icon(Icons.remove,color: Colors.white,))),
                    ),
                    Text(draw_points.toString(),style: TextStyle(
    color: Colors.white
    ),),
                    IconButton(onPressed: (){
                      setState(() {
                        if(draw_points==9){
                          draw_points=draw_points;
                        }
                        else{
                          draw_points=draw_points+1;
                        }
                      });
                    }, icon:Icon(Icons.add,color: Colors.white,)),

                  ],
                ),
              ],
            ),

              ],
            ),

        ),
    );
  }
}
