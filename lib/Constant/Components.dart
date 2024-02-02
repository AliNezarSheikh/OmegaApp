import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
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
GetStorage box=GetStorage();
