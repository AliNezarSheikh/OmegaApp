import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Control/homecontroller.dart';
import 'package:omega/Model/usermodel.dart';
import 'package:omega/View/Screens/login_screen.dart';
import 'package:omega/View/Screens/register_screen.dart';

import '../../Constant/reusable.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:user.id==null
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryText(words: "Join"),
              SizedBox(height: 10,),
              SecondlyText(words: "Join us and register your account \n to explore all features ",align: TextAlign.center),
              SizedBox(height: 10,),
              buildButton(context: context, name: "Register " ,onTap: (){
                homecontrol.currentindex=0.obs;
                Get.off(registerscreen(),
                    transition: Transition.circularReveal,
                    curve: Curves.easeOut,
                    duration: Duration(seconds: 3));
              }),
            ],
          )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              Row(
        
                children: [
                  profileButton(context: context, name: "Edit"),
                  Spacer(),
                  profileButton(context: context, name: "Signout",onTap: (){
                    remeber.write("token", null);
                    usermodel.signOut();
                    homecontrol.currentindex=0.obs;
                    Get.off(loginscreen(),
                        transition: Transition.circularReveal,
                        curve: Curves.easeOut,
                        duration: Duration(seconds: 3));
                  }),
                ],
              ),
             // buildHeader(),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 20,),
              buildInfoCard(context),
              SizedBox(height: 20,),
              buildinfo(),
        
            ],
          ),
        ),
      ),
    );
  }
}
