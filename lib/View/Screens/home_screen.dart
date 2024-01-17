import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                icon: ImageIcon(
                  AssetImage("assets/images/img_thumbs_up.png"),
                ),
                label: "",
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
        body: GetBuilder<homecontroller>(
          builder: (bottomcontroller) =>
              bottomcontroller.bottomscreens[bottomcontroller.currentindex],
        ),
      ),
    );
  }
}
