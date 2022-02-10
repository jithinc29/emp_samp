import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String category;
  final Color? color;

  final Function()? ontap;
  TaskCard({
    required this.title,
    required this.category,
    required this.color,

    required this.ontap});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        
      },
  
      child: Container(
        width: 330,
      
        
        //  width: 135,
       
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                offset: Offset.zero,
              )
            ],
          ),
         
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.martel(
                    fontSize: 26, fontWeight: FontWeight.w800),
              ),
              Text(category,style: TextStyle(fontSize: 25),),
              SizedBox(
                height: 10,
              ),
              // CircularProgressIndicator(
              //   value: .2,
              //   backgroundColor: Colors.black,
              //   strokeWidth: 8,
              // ),
              // CircularPercentIndicator(
              //   animation: true,
              //   animationDuration: 1000,
              //   radius: 20,
              //   lineWidth: 8,
              //   percent: 1,
              //   progressColor: Colors.deepPurple,
              //   backgroundColor: Colors.deepPurple.shade100,
              //   circularStrokeCap: CircularStrokeCap.round,
              // ),
            ],
          )),
    );
  }
}
