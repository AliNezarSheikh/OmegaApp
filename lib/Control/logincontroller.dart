import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';

class logincontroller extends GetxController{
  bool notvisable= true;
  bool rememberMe= false;
  bool agree =false;
  void getvisiblepassword(){
    notvisable=!notvisable;
    update();
  }
  void getremember( { bool? val}){

    rememberMe=val!;
    update();
  }

  void getagree( { bool? val}){

    agree=val!;
    update();
  }
}