import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';

class logincontroller extends GetxController {
  RxBool notvisable = true.obs;
  RxBool rememberMe = false.obs;
  RxBool agree = false.obs;
  void getvisiblepassword() {
    notvisable.value = !notvisable.value;
  }
  void getremember({bool? val}) {
    rememberMe.value = val!;
  }

  void getagree({bool? val}) {
    agree.value = val!;
  }
}
