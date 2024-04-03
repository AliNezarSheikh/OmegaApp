import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/cartscreen/cart_screen.dart';
import 'package:omega/View/Screens/Dashboard/dashboard.dart';
import 'package:omega/View/Screens/Dashboard/favorite.dart';
import 'package:omega/View/Screens/profile/profile.dart';

class homecontroller extends GetxController {
   RxInt currentindex = 0.obs;
  Rx<Color> selecteditemcolor = fontcolorprimary.obs;
  static RxInt itemsincart=0.obs;
  List<Widget> bottomscreens = [
    dashboard(),
    favorite(),
    cartscreen(),
    profile(),
  ];
  void changenavindex(int index) {
    currentindex.value = index;
    selecteditemcolor.value = fontcolorprimary;
  }


}
