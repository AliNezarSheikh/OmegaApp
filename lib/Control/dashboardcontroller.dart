import 'dart:convert';
import 'dart:ui';
import '../Constant/Components.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:omega/Model/adressmodel.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Constant/Components.dart';
import 'package:http/http.dart' as http;

import '../View/Screens/login_screen.dart';
class dashcontroller extends GetxController {
  int selectedlistindex = 0;
  Color selectedlistcolor = fontcolorprimary;

  void changenlistindex(int index) {
    selectedlistindex = index;
    selectedlistcolor = fontcolorprimary;
    update();
  }

}