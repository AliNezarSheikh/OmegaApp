import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Control/logincontroller.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/register_screen.dart';

double? width;
double? height;
logincontroller controller = Get.put(logincontroller());
getwidth(BuildContext context) {
  width = MediaQuery.of(context).size.width;
  return MediaQuery.of(context).size.width;
}

getheight(BuildContext context) {
  height = MediaQuery.of(context).size.height;
  return MediaQuery.of(context).size.height;
}

Widget PrimaryText(
        {required String words,
        Color? color,
        double? fontsize,
        String? fontfami,
        FontWeight? wight}) =>
    Text(
      words,
      style: TextStyle(
        color: color != null ? color : fontcolorprimary,
        fontSize: fontsize != null ? fontsize : sizeprimary,
        fontFamily: fontfami != null ? fontfami : fontfamilyprimary,
        fontWeight: wight != null ? wight : fontwightprimary,
      ),
    );
Widget SecondlyText(
        {required String words,
        Color? color,
        double? fontsize,
        String? fontfami,
        FontWeight? wight}) =>
    Text(
      words,
      style: TextStyle(
        color:color==null ? fontcolorsecond : color,
        fontSize:fontsize==null ?  sizesecond :fontsize ,
        fontFamily: fontfami ==null ? fontfamilysecond: fontfami,
        fontWeight: wight ==null ? fontwightsecond: wight,
      ),
    );

Widget textinput({
  required TextEditingController controller,
  required TextInputType type,
  required String hint,
  required bool obscure,
  Widget? eyeicon,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          suffixIcon: eyeicon,
          hintText: hint,
        ),
        style: TextStyle(
            fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w200),
      ),
    );
Widget buildRememberMeRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Checkbox(
          value: controller.rememberMe,
          onChanged: (val) {
            controller.getremember(val: val);
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
      ),
      PrimaryText(
        words: "Remember Me",
        fontsize: 14,
        wight: FontWeight.w500,
      ),
      Spacer(),
      TextButton(
        onPressed: () {

        },
        child: PrimaryText(
          words: "Forgot password?",
          fontsize: 14,
          wight: FontWeight.w500,
        ),
      ),
    ],
  );
}
Widget buildAgreeRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Checkbox(
          value: controller.agree,
          onChanged: (val) {
            controller.getagree(val: val);
          },
          checkColor: Colors.white,
          activeColor: Colors.black,
        ),
      ),
      PrimaryText(
        words: "I agree to Terms and conditions ",
        fontsize: 14,
        wight: FontWeight.w500,
      ),
      Spacer(),

    ],
  );
}

Widget buildLoginButton({required  context, required String name , Color? Textcolor} ) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: height! * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color:Textcolor ==null ? fontcolorprimary : Colors.white,
          border: Textcolor!= null ?
              Border.all(
                color: Textcolor,
                style: BorderStyle.solid,
                width: 1,
              )
              : null,
        ),
        child: Center(
            child: PrimaryText(
          words: name,
          color: Textcolor !=null  ? Textcolor :Colors.white,
          fontsize: 18,
          fontfami: "Inter",
        )),
      ),
    ),
  );
}

Widget buildDividerRow(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 9),
        child: SizedBox(
          width: 168,
          child: Divider(),
        ),
      ),
      Text(
        "Or",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 9),
        child: SizedBox(
          width: 168,
          child: Divider(),
        ),
      ),
    ],
  );
}

Widget buildIconButton(context, String sentence , ) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: height! * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
              color: fontcolorsecond, style: BorderStyle.solid, width: 1),
        ),
        child: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SvgPicture.asset(
              'assets/images/img_google.svg',
              height: 25,
              width: 25,
            ),
            SizedBox(
              width: 3.0,
            ),
            PrimaryText(
              words: sentence,
              fontsize: 14,
              wight: FontWeight.w600,
            ),
          ],
        )),
      ),
    ),
  );
}

Widget buildannoymusButton(context, String sentence  ) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: height! * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),

          border: Border.all(
              color: fontcolorprimary, style: BorderStyle.solid, width: 1),
        ),
        child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset(
                  'assets/images/annoyms.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 3.0,
                ),
                PrimaryText(
                  words: sentence,
                  fontsize: 14,
                  wight: FontWeight.w600,
                ),
              ],
            )),
      ),
    ),
  );
}
