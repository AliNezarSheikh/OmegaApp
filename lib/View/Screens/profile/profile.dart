import 'package:accordion/accordion.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/address/all%20address.dart';
import 'package:omega/View/Screens/profile/edituser.dart';
import 'package:omega/View/Screens/profile/updatepassword.dart';
import 'package:omega/View/Screens/signup/register_screen.dart';

import '../../../Constant/reusable.dart';
import '../../../Control/logincontroller.dart';

class profile extends StatelessWidget {
  logincontroller controller = Get.put(logincontroller());
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
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
                  transition: Transition.fadeIn,
                  curve: Curves.easeOut,
                  duration: Duration(seconds: 1));
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
                        duration: Duration(milliseconds: 700));
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
                        duration: Duration(milliseconds: 700));
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
                /* InkWell(
                  onTap: () {
                    Get.to(() => addadress(),
                        transition: Transition.rightToLeft,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 700));
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
                ),*/
                InkWell(
                  onTap: () {

                    Get.to(() => alladdress(),
                        transition: Transition.rightToLeft,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 700));
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
                          words: "My Addresses", wight: FontWeight.w300),
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

                Accordion(
                  children: [
                    AccordionSection(

                        isOpen: false,
                        headerBackgroundColor: Colors.white,
                        contentVerticalPadding: 20,
                        headerBackgroundColorOpened: Colors.white,
                        headerBorderColor: fontcolorsecond,
                        headerBorderColorOpened: fontcolorsecond,
                        headerPadding: EdgeInsets.all(12.0),
                        contentBorderColor: Colors.white,
                        rightIcon:
                        SvgPicture.asset("assets/images/img_arrow_up.svg"),
                        leftIcon:Icon(Icons.support_agent_sharp),
                        header: const Text(
                          'Customer Support',
                        ),
                        content: Column(
                          children: [
                            Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(16.0),
                                 child: InkWell(
                                   onTap: () async {
                                     await controller.openWhatsApp(context: context);
                                   },
                                   child: Container(
                                     width:width!*0.3,
                                     height: height! * 0.06,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                       color: Colors.white,
                                       border: Border.all(
                                         color: Colors.green,
                                         style: BorderStyle.solid,
                                         width: 1,
                                       ),
                                         boxShadow: [
                                     BoxShadow(
                                     color: Colors.green.withOpacity(0.05),
                                     spreadRadius: 3,
                                     blurRadius: 4,
                                     offset: Offset(
                                       2,
                                       4,
                                     ),
                                   ),
                                   ],

                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                       child: Row(
                                         children: [
                                         Image(image: AssetImage("assets/images/whatsapppng.png",),width: 20,),
                                            Spacer(),
                                           PrimaryText(
                                             words: "Via Whatsapp",
                                             color: Colors.green,
                                             fontsize: 10,
                                             fontfami: "Inter",
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               ),

                               Padding(
                                 padding: const EdgeInsets.all(16.0),
                                 child: InkWell(
                                   onTap: () async {
                                     await controller.openEmail(context: context);
                                   },
                                   child: Container(
                                     width:width!*0.3,
                                     height: height! * 0.06,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                       color: Colors.white,
                                       border: Border.all(
                                         color: Colors.blue,
                                         style: BorderStyle.solid,
                                         width: 1,
                                       ),
                                       boxShadow: [
                                         BoxShadow(
                                           color: Colors.blue.withOpacity(0.05),
                                           spreadRadius: 3,
                                           blurRadius: 4,
                                           offset: Offset(
                                             2,
                                             4,
                                           ),
                                         ),
                                       ],

                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                       child: Row(
                                         children: [
                                           Icon((Icons.email_outlined),color: Colors.blue,),
                                          SizedBox(width: 5,),
                                           PrimaryText(
                                             words: "Via Email",
                                             color: Colors.blue,
                                             fontsize: 10,
                                             fontfami: "Inter",
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               ),
                             //  buildButton(context: context, name: "Contact "),
                             ],
                            ),
                            Row(

                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    onTap: () async {
                                      await controller.openphone(context: context);
                                    },
                                    child: Container(
                                      width:width!*0.3,
                                      height: height! * 0.06,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            spreadRadius: 3,
                                            blurRadius: 4,
                                            offset: Offset(
                                              2,
                                              4,
                                            ),
                                          ),
                                        ],

                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          children: [
                                           Icon(Icons.phone,color: Colors.black,),
                                          SizedBox(width: 5,),
                                            PrimaryText(
                                              words: "Via Phone",
                                              color: Colors.black,
                                              fontsize: 10,
                                              fontfami: "Inter",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                                //  buildButton(context: context, name: "Contact "),
                              ],
                            ),

                          ],
                        )
                     ),
                  ],
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
                                context: context, token: token!);
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
