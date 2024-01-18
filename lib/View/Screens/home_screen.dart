import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Control/homecontroller.dart';

class homescreen extends StatelessWidget {
  homecontroller bottomcontroller = Get.put(homecontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: GetBuilder<homecontroller>(
          builder: (bottomcontroller) => BottomNavigationBar(
            currentIndex: bottomcontroller.currentindex,
            selectedItemColor: bottomcontroller.selecteditemcolor,
            unselectedItemColor: fontcolorsecond,
            elevation: 0.0,
            onTap: (index) {
              bottomcontroller.changenavindex(index);
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
                icon: Stack(
                  alignment: Alignment.topRight,
                  children: [
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
                  ]
                ),
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
        ),
        body:
           GetBuilder<homecontroller>(
            builder: (bottomcontroller) =>
                PageTransitionSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (child, animation,animation2)=>
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                  child: bottomcontroller.bottomscreens[bottomcontroller.currentindex]),
          ),
        ),

    );
  }
}
