import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Control/homecontroller.dart';

class homescreen extends StatelessWidget {

  homecontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
            () =>  Scaffold(
          bottomNavigationBar:
           BottomNavigationBar(
              currentIndex: controller.currentindex.value,
              selectedItemColor: controller.selecteditemcolor.value,
              unselectedItemColor: fontcolorsecond,
              elevation: 0.0,
              onTap: (index) {

                controller.changenavindex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/img_user.png"),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/img_heart.png"),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Stack(alignment: Alignment.topRight, children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ImageIcon(
                        AssetImage("assets/images/img_thumbs_up.png"),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.green.withOpacity(0.5),
                      child: Text("0"),
                      radius: 10,
                    ),
                  ]),
                  // label: "",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/img_lock.png"),
                  ),
                  label: "",
                ),
              ],
            ),

          body:  Obx(()=>PageTransitionSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (child, animation, animation2) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              child: controller
                  .bottomscreens[controller.currentindex.value]),),
          ),

      ),
    );
  }
}
