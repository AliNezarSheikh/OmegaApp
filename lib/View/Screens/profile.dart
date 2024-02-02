import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/login_screen.dart';

import '../../Constant/reusable.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            Row(

              children: [
                profileButton(context: context, name: "Edit"),
                Spacer(),
                profileButton(context: context, name: "Signout",onTap: (){
                  Get.off(loginscreen(),
                      transition: Transition.circularReveal,
                      curve: Curves.easeOut,
                      duration: Duration(seconds: 3));
                }),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            buildHeader(),
            SizedBox(height: 20,),
            buildinfo(),
          ],
        ),
      ),
    );
  }
}
