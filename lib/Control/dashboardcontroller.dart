import 'dart:ui';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../Constant/Components.dart';

class dashcontroller extends GetxController {
  int selectedlistindex = 0;
  Color selectedlistcolor = fontcolorprimary;

  void changenlistindex(int index) {
    selectedlistindex = index;
    selectedlistcolor = fontcolorprimary;
    update();
  }
}
