import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:omega/Constant/Components.dart';

import 'home_screen.dart';
import 'login_screen.dart';


class splashscreen extends StatelessWidget {
   splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4),(){
      remeber.read("token")==null ?
      Get.off(()  =>loginscreen(),transition: Transition.circularReveal,curve: Curves.easeInOut,duration: Duration(seconds: 3))
          :Get.off(()  =>homescreen(),transition: Transition.circularReveal,curve: Curves.easeInOut,duration: Duration(seconds: 3));
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
