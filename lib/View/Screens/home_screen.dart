import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/homecontroller.dart';

class homescreen extends StatelessWidget {
  homecontroller controller = Get.put(homecontroller());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentindex.value,
          selectedItemColor: controller.selecteditemcolor.value,
          unselectedItemColor: fontcolorsecond,
          elevation: 0.0,
          onTap: (index) async {
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
              icon: Badge(
                  child: ImageIcon(
                AssetImage("assets/images/img_thumbs_up.png"),
              )),
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
        body: Obx(
          () => PageTransitionSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (child, animation, animation2) =>
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              child: controller.bottomscreens[controller.currentindex.value]),
        ),
      ),
    );
  }
}
