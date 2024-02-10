import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';

import 'package:accordion/accordion.dart';
import 'package:omega/View/Screens/home_screen.dart';

import '../../Constant/Components.dart';
import 'add_new_card_screen.dart';

class paymentscreen extends StatelessWidget {
  late String payment = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6),
        scrolledUnderElevation: 0.0,
        leadingWidth: 70.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/images/img_arrow_left.svg",
              width: 70,
              height: 70,
            ),
          ),
        ),
        title: PrimaryText(words: "Payment", fontsize: 20),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Stack(
        children:[
          Container(
          width: width!,
          height: height!,
          color: Color(0xFFF6F6F6),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimationLimiter(
                    child: ListView.separated(
                      itemCount: 3,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 20);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeOutCirc,
                            horizontalOffset: 30,
                            verticalOffset: 300.0,
                            child: FlipAnimation(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeInToLinear,
                                flipAxis: FlipAxis.y,
                                child: paymentlist(context)),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: PrimaryText(words: "Payment Method"),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: double.infinity,
                      height: height! * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        border: Border.all(
                          color: fontcolorsecond,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 8),
                            child: SvgPicture.asset(
                              "assets/images/img_settings_black_900.svg",
                              width: width! * 0.04,
                              height: width! * 0.04,
                            ),
                          ),
                          SizedBox(
                            width: width! * 0.05,
                          ),
                          SecondlyText(words: "Apple Pay"),
                          Spacer(),
                          Radio(
                              value: "Apple Pay",
                              groupValue: payment,
                              onChanged: (val) {})
                        ],
                      ),
                    ),
                  ),
                  Accordion(
                    children: [
                      AccordionSection(
                          isOpen: false,
                          headerBackgroundColor: Colors.white,
                          contentVerticalPadding: 20,
                          headerBackgroundColorOpened: Colors.white,
                          headerBorderColor: fontcolorsecond,
                          headerBorderColorOpened: fontcolorsecond,
                          headerPadding: EdgeInsets.all(12.0),
                          contentBorderColor: Colors.white,
                          rightIcon:
                          SvgPicture.asset("assets/images/img_arrow_up.svg"),
                          leftIcon: SvgPicture.asset(
                              "assets/images/img_television.svg"),
                          header: const Text(
                            'Credit Card',
                          ),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: double.infinity,
                                  height: height! * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    border: Border.all(
                                      color: fontcolorsecond,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0, vertical: 8),
                                        child: SvgPicture.asset(
                                          "assets/images/img_payment_method.svg",
                                          width: width! * 0.05,
                                          height: width! * 0.05,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width! * 0.05,
                                      ),
                                      SecondlyText(words: "**** 7658"),
                                      Spacer(),
                                      Radio(
                                          value: "Master Card",
                                          groupValue: payment,
                                          onChanged: (val) {})
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  width: double.infinity,
                                  height: height! * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    border: Border.all(
                                      color: fontcolorsecond,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0, vertical: 8),
                                        child: SvgPicture.asset(
                                          "assets/images/img_payment_method_indigo_900.svg",
                                          width: width! * 0.05,
                                          height: width! * 0.05,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width! * 0.05,
                                      ),
                                      SecondlyText(words: "**** 2322"),
                                      Spacer(),
                                      Radio(
                                          value: "Visa",
                                          groupValue: payment,
                                          onChanged: (val) {})
                                    ],
                                  ),
                                ),
                              ),
                              addcardButton(
                                  context: context, name: "Add New Card",onTap: (){
                                Get.to(addcardscreen(),
                                    transition: Transition.circularReveal,
                                    curve: Curves.easeInOut,
                                    duration: Duration(seconds: 3));
                              }),
                            ],
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: double.infinity,
                      height: height! * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        border: Border.all(
                          color: fontcolorsecond,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 8),
                            child: SvgPicture.asset(
                              "assets/images/img_settings_errorcontainer.svg",
                              width: width! * 0.04,
                              height: width! * 0.04,
                            ),
                          ),
                          SizedBox(
                            width: width! * 0.05,
                          ),
                          SecondlyText(words: "Google Pay"),
                          Spacer(),
                          Radio(
                              value: "Google Pay",
                              groupValue: payment,
                              onChanged: (val) {})
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height!*0.2,
                  ),

                ],
              ),
            ),
          ),
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              width: width!,
              height: height!*0.20,
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
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
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 16),
                    child: Row(
                      children: [
                        SecondlyText(words: "Total Payment"),
                        Spacer(),
                        PrimaryText(words: "\$245.00")
                      ],

                    ),
                  ),
                  buildButton(context: context,name: "Apply Filter",onTap: (){

                  })
                ],
              )
            ),
          )
        ]
      ),
    );
  }
}
