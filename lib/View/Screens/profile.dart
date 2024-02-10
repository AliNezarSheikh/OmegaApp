import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Control/homecontroller.dart';
import 'package:omega/Model/usermodel.dart';
import 'package:omega/View/Screens/addadress.dart';
import 'package:omega/View/Screens/checkuser.dart';
import 'package:omega/View/Screens/edituser.dart';
import 'package:omega/View/Screens/login_screen.dart';
import 'package:omega/View/Screens/register_screen.dart';

import '../../Constant/reusable.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                PrimaryText(words: "Profile",),
                SizedBox(height: 20.0,),
                Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [fontcolorprimary, fontcolorsecond,Colors.black26], // Replace with your desired gradient colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          height: 1,
                ),
                SizedBox(height: 10.0,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                    Icon(  Icons.person_3_outlined,),
                      SizedBox(width: width!*0.05,),
                      PrimaryText(words: "Personal Info",wight: FontWeight.w300),
                      Spacer(),
                      Icon(  Icons.arrow_forward_ios,),

                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [fontcolorprimary, fontcolorsecond,Colors.black26], // Replace with your desired gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 1,
                ),
                SizedBox(height: 10.0,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(  Icons.lock_open_outlined,),
                      SizedBox(width: width!*0.05,),
                      PrimaryText(words: "Change Password",wight: FontWeight.w300),
                      Spacer(),
                      Icon(  Icons.arrow_forward_ios,),

                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [fontcolorprimary, fontcolorsecond,Colors.black26], // Replace with your desired gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 1,
                ),
                SizedBox(height: 10.0,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(  Icons.location_on_outlined,),
                      SizedBox(width: width!*0.05,),
                      PrimaryText(words: "Add New Address",wight: FontWeight.w300),
                      Spacer(),
                      Icon(  Icons.arrow_forward_ios,),

                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [fontcolorprimary, fontcolorsecond,Colors.black26], // Replace with your desired gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 1,
                ),
                SizedBox(height: 10.0,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(  Icons.list_alt,),
                      SizedBox(width: width!*0.05,),
                      PrimaryText(words: "List All Addresses",wight: FontWeight.w300),
                      Spacer(),
                      Icon(  Icons.arrow_forward_ios,),

                    ],
                  ),
                ),
                SizedBox(height: 100.0,),
                buildButton(context: context, name: "Sign Out",onTap: (){
                  remeber.remove("token");
                  usermodel.signOut();
                  homecontrol.currentindex=0.obs;
                  Get.off(loginscreen(),
                      transition: Transition.circularReveal,
                      curve: Curves.easeOut,
                      duration: Duration(seconds: 3));
                }),
              ],
            ),
          ),
        ),
      ),
    );
     /* Scaffold(

      body:currentuser==null
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
                  profileButton(context: context, name: "Edit",    onTap:(){
                    Get.to(checkuser(targetscreen: edituser()),
                        transition: Transition.upToDown,
                        curve: Curves.easeOut,
                        duration: Duration(milliseconds: 500));
                  }),
                  Spacer(),
                  profileButton(context: context, name: "Signout",onTap: (){
                    remeber.remove("token");
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
              SizedBox(height: 20,),
              ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index)=>  adresslist(listadress[index],context),
                  separatorBuilder:  (context, int index) {
                    return SizedBox(height: 20);
                  },
                  itemCount: listadress.length),
              SizedBox(height: 20,),
              buildButton(context: context, name: "Add New Adress",onTap: (){
    Get.to(checkuser(targetscreen: addadress()),
    transition: Transition.upToDown,
    curve: Curves.easeOut,
    duration: Duration(milliseconds: 500));

              }),
            ],
          ),
        ),
      ),
    );*/
  }
}
