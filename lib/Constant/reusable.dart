import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Control/homecontroller.dart';
import 'package:omega/Control/logincontroller.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/home_screen.dart';
import 'package:omega/View/Screens/register_screen.dart';

double? width;
double? height;
logincontroller controller = Get.put(logincontroller());
homecontroller homecontrol = Get.put(homecontroller());
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
        TextDecoration? decoration,
        FontWeight? wight}) =>
    Text(
      words,
      style: TextStyle(
        color: color == null ? fontcolorsecond : color,
        fontSize: fontsize == null ? sizesecond : fontsize,
        fontFamily: fontfami == null ? fontfamilysecond : fontfami,
        fontWeight: wight == null ? fontwightsecond : wight,
        decoration: decoration == null ? TextDecoration.none : decoration,
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
Widget buildRememberMeRow(bool value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Checkbox(
          value: value,
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
        onPressed: () {},
        child: PrimaryText(
          words: "Forgot password?",
          fontsize: 14,
          wight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Widget buildAgreeRow(bool value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Checkbox(
          value: value,
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

Widget buildLoginButton(
    {required context, required String name, Color? Textcolor}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {
        Get.off(homescreen(),
            transition: Transition.circularReveal,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 3));
      },
      child: Container(
        width: double.infinity,
        height: height! * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Textcolor == null ? fontcolorprimary : Colors.white,
          border: Textcolor != null
              ? Border.all(
                  color: Textcolor,
                  style: BorderStyle.solid,
                  width: 1,
                )
              : null,
        ),
        child: Center(
            child: PrimaryText(
          words: name,
          color: Textcolor != null ? Textcolor : Colors.white,
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

Widget buildIconButton(
  context,
  String sentence,
) {
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

Widget buildannoymusButton(context, String sentence) {
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

Widget buildbanner(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: Stack(alignment: Alignment.topRight, children: [
          Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                child: Container(
                  width: getwidth(context),
                  height: getwidth(context) * 0.5,
                  decoration: BoxDecoration(
                    color: themesecond,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryText(words: "Shop with us!", fontsize: 14),
                        SizedBox(
                          height: 12.0,
                        ),
                        SizedBox(
                          width: getheight(context) * 0.2,
                          child: Text(
                            "Get 40% Off for all items",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: fontcolorprimary,
                              fontSize: sizeprimary,
                              fontFamily: fontfamilyprimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32.0, bottom: 32.0),
            child: SvgPicture.asset(
              "assets/images/img_mask_group.svg",
              width: getwidth(context) * 0.4,
            ),
          ),
        ]),
      ),
    );

Widget buildlist(int index) => TextButton(
      onPressed: () {
        homecontrol.changenlistindex(index);
        print(index);
      },
      child: SecondlyText(
          words: "All",
          wight: FontWeight.w400,
          decoration: homecontrol.selectedlistindex == index
              ? TextDecoration.underline
              : TextDecoration.none,
          color: homecontrol.selectedlistindex == index
              ? fontcolorprimary
              : fontcolorsecond),
    );

Widget ProductlistItemWidget(context) => Container(
      padding: EdgeInsets.all(10),
      height: getheight(context) * 0.1719,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: fontcolorprimary.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 5,
            offset: Offset(
              2,
              4,
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: AssetImage(
                "assets/images/img_bg.png",
              ),
              width: getwidth(context) * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(words: "Airforce Jump", fontsize: 14),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SecondlyText(words: "Dark Grey")
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  PrimaryText(words: '\$245.00 ', fontsize: 14),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    child: Image(
                      image: AssetImage(
                        "assets/images/img_heart.png",
                      ),
                      width: getwidth(context) * 0.055,
                      //color: Colors.red,
                    ),
                    backgroundColor: Colors.red.withOpacity(0.5),
                    radius: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 15.0),
                child: SvgPicture.asset("assets/images/img_plus_primary.svg"),
              ),
            ],
          ),
        ],
      ),
    );
final random = Random();
Widget CartlistItemWidget(context) => Dismissible(
      key: Key(random.nextInt(4).toString()),
      background: Container(
        width: getwidth(context) * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: fontcolorprimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SvgPicture.asset(
                "assets/images/img_trash_bin.svg",
                width: 35,
                height: 35,
              ),
            ),
          ],
        ),
      ),
      //onDismissed: (){},
      child: Container(
        padding: EdgeInsets.all(10),
        height: getheight(context) * 0.1719,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: fontcolorprimary.withOpacity(0.05),
              spreadRadius: 4,
              blurRadius: 5,
              offset: Offset(
                2,
                4,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: AssetImage(
                  "assets/images/img_bg.png",
                ),
                width: getwidth(context) * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryText(words: "Airforce Jump", fontsize: 14),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SecondlyText(words: "Dark Grey")
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    PrimaryText(words: '\$245.00 ', fontsize: 14),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            border: Border.all(
                              color: Color(0XFFA2A5B1),
                            )),
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: SvgPicture.asset(
                                "assets/images/img_minus_blue_gray_300.svg")),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SecondlyText(words: "1", wight: FontWeight.w700),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset("assets/images/img_plus_primary.svg"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
Widget buildcheckButton(
    {required context, required String name, Color? Textcolor}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {
        /*Get.off(homescreen(),
            transition: Transition.circularReveal,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 3));*/
      },
      child: Container(
        width: double.infinity,
        height: height! * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Textcolor == null ? fontcolorprimary : Colors.white,
          border: Textcolor != null
              ? Border.all(
                  color: Textcolor,
                  style: BorderStyle.solid,
                  width: 1,
                )
              : null,
        ),
        child: Center(
            child: PrimaryText(
          words: name,
          color: Textcolor != null ? Textcolor : Colors.white,
          fontsize: 18,
          fontfami: "Inter",
        )),
      ),
    ),
  );
}

Widget buildeditButton(
    {required context, required String name, Color? Textcolor}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {
        /*Get.off(homescreen(),
            transition: Transition.circularReveal,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 3));*/
      },
      child: Container(
        width: width! * 0.25,
        height: height! * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: fontcolorprimary.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 5,
              offset: Offset(
                2,
                4,
              ),
            ),
          ],
          color: Textcolor == null ? fontcolorprimary : Colors.white,
          border: Textcolor != null
              ? Border.all(
                  color: Textcolor,
                  style: BorderStyle.solid,
                  width: 1,
                )
              : null,
        ),
        child: Center(
            child: PrimaryText(
          words: name,
          color: Textcolor != null ? Textcolor : Colors.white,
          fontsize: 18,
          fontfami: "Inter",
        )),
      ),
    ),
  );
}

Widget buildsignoutButton(
    {required context, required String name, Color? Textcolor}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {
        /*Get.off(homescreen(),
            transition: Transition.circularReveal,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 3));*/
      },
      child: Container(
        width: width! * 0.25,
        height: height! * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: fontcolorsecond,
          boxShadow: [
            BoxShadow(
              color: fontcolorprimary.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 5,
              offset: Offset(
                2,
                4,
              ),
            ),
          ],
          border: Textcolor != null
              ? Border.all(
                  color: Textcolor,
                  style: BorderStyle.solid,
                  width: 1,
                )
              : null,
        ),
        child: Center(
            child: PrimaryText(
          words: name,
          color: Textcolor != null ? Textcolor : Colors.white,
          fontsize: 18,
          fontfami: "Inter",
        )),
      ),
    ),
  );
}

Widget buildHeader() {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
            width: 1, color: fontcolorprimary, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(100))),
    child: Stack(alignment: Alignment.bottomRight, children: [
      CircleAvatar(
        radius: 102,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage("assets/images/profile.jpg"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/addphoto.png"),
          radius: 25,
        ),
      )
    ]),
  );
}

Widget buildinfo() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          height: height! * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            border: Border.all(
              color: fontcolorprimary,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  words: "User Name",
                  color: fontcolorsecond,
                  fontsize: 12,
                  fontfami: "Inter",
                ),
                SizedBox(
                  height: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: PrimaryText(
                    words: "Ali Sheikh",
                    color: fontcolorprimary,
                    fontsize: 16,
                    fontfami: "Inter",
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          height: height! * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            border: Border.all(
              color: fontcolorprimary,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  words: "Email",
                  color: fontcolorsecond,
                  fontsize: 12,
                  fontfami: "Inter",
                ),
                SizedBox(
                  height: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: PrimaryText(
                    words: "AliSheikh@gmail.com",
                    color: fontcolorprimary,
                    fontsize: 16,
                    fontfami: "Inter",
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          height: height! * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            border: Border.all(
              color: fontcolorprimary,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  words: "Phone",
                  color: fontcolorsecond,
                  fontsize: 12,
                  fontfami: "Inter",
                ),
                SizedBox(
                  height: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: PrimaryText(
                    words: "+971 50 164 6033",
                    color: fontcolorprimary,
                    fontsize: 16,
                    fontfami: "Inter",
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
