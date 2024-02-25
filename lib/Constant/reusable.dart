import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Control/homecontroller.dart';
import 'package:omega/Control/logincontroller.dart';
import 'package:omega/Model/adressmodel.dart';
import 'package:omega/Model/categorymodel.dart';
import 'package:omega/Model/productmodel.dart';
import 'package:omega/View/Screens/address/updateaddress.dart';
import 'package:omega/View/Screens/home_screen.dart';
import 'package:omega/View/Screens/productdetails.dart';
import 'package:toastification/toastification.dart';

import '../Control/dashboardcontroller.dart';
import 'Components.dart';

double? width;
double? height;
logincontroller checkcon = Get.put(logincontroller());
homecontroller homecontrol=Get.put(homecontroller());
dashcontroller dashcontrol = Get.put(dashcontroller());
getwidth(BuildContext context) {
  width = MediaQuery.of(context).size.width;
  return MediaQuery.of(context).size.width;
}

getheight(BuildContext context) {
  height = MediaQuery.of(context).size.height;
  return MediaQuery.of(context).size.height;
}
enum ButtonAction {
  cancel,
  Agree,
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
          TextAlign? align,
        FontWeight? wight}) =>
    Text(
      words,
      textAlign:align ==null ? TextAlign.start:align ,
      style: TextStyle(
        color: color == null ? fontcolorsecond : color,
        fontSize: fontsize == null ? sizesecond : fontsize,
        fontFamily: fontfami == null ? fontfamilysecond : fontfami,
        fontWeight: wight == null ? fontwightsecond : wight,
        decoration: decoration == null ? TextDecoration.none : decoration,

      ),
    );

Widget textinput(
        {required TextEditingController controller,
        required TextInputType type,
        required String hint,
        required bool obscure,
        Widget? eyeicon,
          InputBorder? border,
          String? lab,
        String? Function(String?)? validator}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: eyeicon,
          hintText: hint,
          border: border,
          label: lab!=null ?Text(lab):null,
        ),
        style: TextStyle(
            fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w200),
      ),
    );
Widget textinput2({
  required TextEditingController controller,
  required TextInputType type,
  required String hint,
  required bool obscure,
  Widget? eyeicon,
  List<TextInputFormatter>? inputformat,
  String? obscuretype,
  void Function()? ontap,
  int? maxlenght,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 10, right: 16),
      child: TextFormField(
        inputFormatters: inputformat,
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        textAlignVertical: TextAlignVertical.bottom,
        obscuringCharacter: obscuretype != null ? obscuretype : '•',
        onTap: ontap,
        maxLength: maxlenght,
        decoration: InputDecoration(
          suffixIcon: eyeicon,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        ),
        style: TextStyle(
            fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w200),
      ),
    );
Widget buildRememberMeRow(bool value, void Function(bool?)? onChanged) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Checkbox(
          value: value,
          onChanged: onChanged,
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

Widget buildAgreeRow(bool value, void Function(bool?)? onChanged) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Checkbox(
          value: value,
          onChanged: onChanged,
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

Widget buildButton(
    {required context,
    required String name,
    Color? Textcolor,
    void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: onTap,
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

/*Widget buildannoymusButton(context, String sentence) {
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
}*/

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

Widget buildlist(int index,categorymodel model,dashcontroller control) =>
    Obx(
        ()=> TextButton(
          onPressed:     () async {
            control.changenlistindex(index);
await control.getproductbycategory(id: model.id!)  ;  },
          child: SecondlyText(
            words: "${model.name}",
            wight: FontWeight.w400,

            decoration:  control.selectedlistindex== index
                ? TextDecoration.underline
                : TextDecoration.none,
            color: control.selectedlistindex == index
                ? fontcolorprimary
                : fontcolorsecond),),
    );
Widget ProductList(BuildContext context,productmodel model,dashcontroller control)=> InkWell(
  onTap: (){
    Get.to(productdetails(model: model));
  },
  child: Padding(
    padding:
      const EdgeInsets.all( 6.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: fontcolorprimary.withOpacity(0.05),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(
              2,
              4,
            ),
          ),
        ],
      ),
      child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(15),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                      Image(
                          image: NetworkImage(
                            "${model.medium_image_url}",
                          ),
                          width: width! *
                              0.5,
                          fit: BoxFit.cover,
                        ),


                    Padding(
                      padding:
                      const EdgeInsets.only(
                          top: 8.0,
                          right: 8.0),
                      child: InkWell(
                        onTap: () async {
                         await control.addorremovefromwish(productid: model.id!, token: token, context: context);
                         await control.getproductbycategory(id: listcategories[ control.selectedlistindex.value ].id!);
                        },
                        child: CircleAvatar(
                          child: Image(
                            image: AssetImage(
                              "assets/images/img_heart.png",

                            ),
                            width: width! *
                                0.03,
                           // color: model.iswishlisted?Colors.red:null,
                          ),
                          backgroundColor:model.iswishlisted?Colors.red
                              .withOpacity(
                              0.5)
                        :  Colors.black
                              .withOpacity(
                              0.5),
                          radius: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 14.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    PrimaryText(
                        words: "${model.name}",
                        fontsize: 14),
                    SecondlyText(
                        words: "${model.short_description}",
                        fontsize: 12),
                    SizedBox(
                      height: height!*0.005,
                    ),
                    Row(
                      children: [
                        PrimaryText(
                            words: '${model.formatted_price} ',
                            fontsize: 14),
                        Spacer(),
                        Obx(
                          ()=> ConditionalBuilder(
                            condition: control.loadadd.isFalse,
                            builder: (BuildContext context) { return Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  right: 15.0),
                              child: InkWell(
                                onTap: () async {
                                  await control.addtocart(productid: model.id!,token: token,context: context);
                                },
                                child: SvgPicture.asset(
                                    "assets/images/img_plus_primary.svg",),
                              ),
                            ); },
                            fallback: (BuildContext context){
                              return Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: CircleAvatar(radius:10,child: CircularProgressIndicator()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    ),
  ),
);
Widget ProductlistItemWidget(context,productmodel model,dashcontroller control) =>
    Container(
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
                image: NetworkImage(
                  "${model.medium_image_url}",
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
                    PrimaryText(words: "${model.name}", fontsize: 14),
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
                        SecondlyText(words: "${model.short_description}")
                      ],
                    ),
                    SizedBox(
                      height: height! * 0.02,
                    ),
                    PrimaryText(words: '${model.formatted_price} ', fontsize: 14),
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
                    onTap: () async {
                      await control.addorremovefromwish(productid: model.id!, token: token, context: context);

                      Get.off(homescreen());
                    },
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
                      height: height! * 0.02,
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
Widget profileButton(
    {required context,
    required String name,
    Color? Textcolor,
    void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: onTap,
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
          color: name == "Edit" ? fontcolorprimary : fontcolorsecond,
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
/*Widget buildInfoCard(context) {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Card(
          elevation: 5.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 16.0, right: 10.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    PrimaryText(words: "Store Credits",fontsize: 18.0,wight: FontWeight.w400),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),

                      child: PrimaryText(words: currentuser!.store_credits.toString(),fontsize: 18.0,wight: FontWeight.w600,color: fontcolorsecond),
                    ),
                  ],
                ),
                new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    PrimaryText(words: "Completed Orders",fontsize: 18.0,wight: FontWeight.w400),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),

                      child: PrimaryText(words: currentuser!.completed_orders.toString(),fontsize: 18.0,wight: FontWeight.w600,color: fontcolorsecond),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    ],
  );
}*/
Widget buildinfo() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: width!*0.35,
              height: height! * 0.09,
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
                      words: "First Name",
                      color: fontcolorsecond,
                      fontsize: 12,
                      fontfami: "Inter",
                    ),
                    SizedBox(
                      height: height! * 0.008,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: PrimaryText(
                        words: currentuser!.first_name==null? "": "${currentuser!.first_name}",
                        color: fontcolorprimary,
                        fontsize: 16,
                        fontfami: "Inter",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              width: width!*0.35,
              height: height! * 0.09,
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
                      words: "Last Name",
                      color: fontcolorsecond,
                      fontsize: 12,
                      fontfami: "Inter",
                    ),
                    SizedBox(
                      height: height! * 0.008,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: PrimaryText(
                        words: currentuser!.last_name==null? "": "${currentuser!.last_name}",
                        color: fontcolorprimary,
                        fontsize: 16,
                        fontfami: "Inter",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: height! * 0.02,
        ),
        Container(
          width: double.infinity,
          height: height! * 0.09,
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
                  height: height! * 0.008,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: PrimaryText(
                    words: currentuser!.email==null ? "" :"${currentuser!.email}",
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
          height: height! * 0.02,
        ),
        /*Container(
          width: double.infinity,
          height: height! * 0.09,
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
                  height: height! * 0.008,
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
        ),*/
      ],
    ),
  );
}

Widget paymentlist(context) => Container(
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
                    height: height! * 0.02,
                  ),
                  PrimaryText(words: '\$245.00 ', fontsize: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget addcardButton(
    {required context,
    required String name,
    Color? Textcolor,
    void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DottedBorder(
          dashPattern: [5, 5],
          strokeWidth: 2,
          color: fontcolorprimary,
          child: Container(
            width: width!,
            height: height! * 0.06,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/img_icon.svg"),
                  SizedBox(
                    width: width! * 0.02,
                  ),
                  PrimaryText(
                    words: name,
                    color: fontcolorprimary,
                    fontsize: 14,
                    fontfami: "Inter",
                  ),
                ]),
          ),
        ),
      ),
    ),
  );
}

/*Widget buildpaymentButton(
    {required context,
    required String name,
    Color? Textcolor,
    String? object}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: InkWell(
      onTap: () {


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
}*/

void showresult(BuildContext context, Color color, String text,) =>
    toastification.show(
      context: context,
      icon: ImageIcon(AssetImage("assets/images/img_group_9.png"),color: Colors.blue,),
      backgroundColor: color,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.flat,
      description: PrimaryText(
        words: text,
        fontsize: 14,
        wight: FontWeight.w400,
      ),
      borderRadius: BorderRadius.circular(12),
    );
Widget adresslist(addressmodel model,context,) =>
     Container(
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

      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(words: "Adress: ${model.address1}", fontsize: 14),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SecondlyText(words: "Emarite : ${model.state}"),
                  SizedBox(
                    width: 10,
                  ),
                  SecondlyText(words: "City: ${model.city}")
                ],
              ),
              SizedBox(
                height: height! * 0.02,
              ),
              PrimaryText(words: 'Phone Number ${model.phoneaddress}', fontsize: 14),
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
              onTap: () {
                Get.to(() => updateaddress(model: model),
                    transition: Transition.rightToLeft,
                    curve: Curves.easeInOut,
                    duration: Duration(seconds: 2));
              },
              child: CircleAvatar(
                backgroundColor: Colors.green.withOpacity(0.5),
                radius: 15,
                child: Icon(
                  Icons.edit,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 15.0),
            child: InkWell(
              onTap: (){
                checkcon.showMaterialDialog(
                    context: context,
                    child: AlertDialog(
                      title: const Text(
                          'Are you sure you want to delete the adress?'),
                      content: Text(
                        'If you want to adress the item, choose AGREE or cancel the operation',
                      ),
                      actions: <Widget>[
                        InkWell(
                          child: const Text('Cancel'),
                          onTap: () {
                            Navigator.pop(
                                context, ButtonAction.cancel);
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          child: const Text('Agree'),
                          onTap:() async {
                            Navigator.pop(
                                context, ButtonAction.Agree);
                            await checkcon.deleteaddress(id: model.id!, context: context);

                          },
                        ),
                      ],
                    ),);
              },
              child: Icon(
                Icons.delete_outline,
              ),
            )
          ),
        ],
      ),
    ],
  ),
);

