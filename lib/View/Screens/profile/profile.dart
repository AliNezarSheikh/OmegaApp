import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/address/addadress.dart';
import 'package:omega/View/Screens/address/all%20address.dart';
import 'package:omega/View/Screens/profile/edituser.dart';
import 'package:omega/View/Screens/signup/register_screen.dart';
import 'package:omega/View/Screens/profile/updatepassword.dart';

import '../../../Constant/reusable.dart';
import '../../../Control/logincontroller.dart';

class profile extends StatelessWidget {
  logincontroller controller = Get.put(logincontroller());
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: currentuser!.email==null
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
              :SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  words: "Profile",
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        fontcolorprimary,
                        fontcolorsecond,
                        Colors.black26
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 1,
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => edituser(),
                        transition: Transition.rightToLeft,
                        curve: Curves.easeInOut,
                        duration: Duration(seconds: 2));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_3_outlined,
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      PrimaryText(
                          words: "Personal Info", wight: FontWeight.w300),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        fontcolorprimary,
                        fontcolorsecond,
                        Colors.black26
                      ], // Replace with your desired gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 1,
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => changepassword(),
                        transition: Transition.rightToLeft,
                        curve: Curves.easeInOut,
                        duration: Duration(seconds: 2));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_open_outlined,
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      PrimaryText(
                          words: "Change Password", wight: FontWeight.w300),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        fontcolorprimary,
                        fontcolorsecond,
                        Colors.black26
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 1,
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => addadress(),
                        transition: Transition.rightToLeft,
                        curve: Curves.easeInOut,
                        duration: Duration(seconds: 2));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      PrimaryText(
                          words: "Add New Address", wight: FontWeight.w300),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        fontcolorprimary,
                        fontcolorsecond,
                        Colors.black26
                      ], // Replace with your desired gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 1,
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {

                    Get.to(() => alladdress(),
                        transition: Transition.rightToLeft,
                        curve: Curves.easeInOut,
                        duration: Duration(seconds: 2));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                      ),
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      PrimaryText(
                          words: "List All Addresses", wight: FontWeight.w300),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Obx(
                    ()=> ConditionalBuilder(
                      condition: controller.isLoading.isFalse,
                      builder: (context) => buildButton(
                          context: context,
                          name: "Sign Out",
                          onTap: () async {
                            await controller.logout(
                                context: context, token: token);
                          }),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator())),
                ),

              ],
            ),
          ),
        ),
      ),
    );


  }
}
