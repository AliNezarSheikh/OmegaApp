import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/cart_screen.dart';
import 'package:omega/View/Screens/dashboard.dart';
import 'package:omega/View/Screens/favorite.dart';
import 'package:omega/View/Screens/profile.dart';

class homecontroller extends GetxController {
  int currentindex = 0;
  Color selecteditemcolor = fontcolorprimary;
  int selectedlistindex = 0;
  Color selectedlistcolor = fontcolorprimary;
  List<Widget> bottomscreens = [
    dashboard(),
    favorite(),
    cartscreen(),
    profile(),
  ];
  void changenavindex(int index) {
    currentindex = index;
    selecteditemcolor = fontcolorprimary;
    update();
  }

  void changenlistindex(int index) {
    selectedlistindex = index;
    selectedlistcolor = fontcolorprimary;
    update();
  }
}
