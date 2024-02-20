import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:omega/Model/categorymodel.dart';
import 'package:omega/Model/usermodel.dart';

import '../Model/adressmodel.dart';
//primary
Color fontcolorprimary =Color(0xff000000);
double sizeprimary = 24;
String fontfamilyprimary ="Poppins";
FontWeight fontwightprimary =FontWeight.w600;


//secondary
Color fontcolorsecond =Color(0XFF828282);
double sizesecond = 14;
String fontfamilysecond ="Poppins";
FontWeight fontwightsecond =FontWeight.w400;

Color themesecond=Color(0XFFE8E8E8);

class SpacingTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    String formattedText = newValue.text.replaceAll(' ', '');
    if (formattedText.length > 4) {
      formattedText = formattedText.replaceAllMapped(
        RegExp(r".{4}"),
            (match) => "${match.group(0)} ",
      );
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
int generateRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min);
}
Future<String> getDeviceName() async {

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if(Platform.isIOS){

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.utsname.machine;
  }else  if(Platform.isAndroid){
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model;
  }else{
    return "model not known";
  }


}
String devicename="";
String? remembertoken;
String token="";
 usermodel? currentuser;
categorymodel? catmod;
BuildContext? context;
const List<String> list = <String>['Male', 'Female',];

 List<addressmodel> listadress = [];
List<categorymodel> listcategories = [];
late addressmodel useraddress;
String baseurl="https://bagisto.lofialight.com/public/api/v1";
GetStorage remeber=GetStorage();
GetStorage edit=GetStorage();
