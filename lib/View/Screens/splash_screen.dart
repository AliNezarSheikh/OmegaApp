import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/home_screen.dart';

import 'login_screen.dart';

class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1),(){

     Get.off(()=> remembertoken!= null ?homescreen():loginscreen(),transition: Transition.circularReveal,curve: Curves.easeInOut,duration: Duration(seconds: 3));
    });
    return  SafeArea(
      child: Scaffold(

        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              child: Image(

                image: AssetImage("assets/images/img_group_9.png"),

              ),
            ),
          ),
        ),


      ),
    );
  }
}
