import 'package:accordion/accordion.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/logincontroller.dart';

import '../../Constant/Components.dart';
import 'add_new_card_screen.dart';

class paymentscreen extends StatelessWidget {
logincontroller controller=Get.put(logincontroller());
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
          SingleChildScrollView(
            child: Column(
            
              children: [
                Container(
                width: width!,
                height: height!*0.4,
                color: Color(0xFFF6F6F6),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimationLimiter(
                          child: ListView.separated(
                            itemCount: listcart.length,
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
                                      child: paymentlist(listcart[index],context)),
                                ),
                              );
                            },
                          ),
                        ),
            
                      ],
                    ),
                  ),
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
                Container(
                  width: width!,
                  height: height!*0.25,
                  color: Color(0xFFF6F6F6),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimationLimiter(
                            child: ListView.separated(
                              itemCount: listpaymentmethods.length,
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
                                        child: paymentmethodlist(listpaymentmethods[index],context,controller)),
                                  ),
                                );
                              },
                            ),
                          ),
            
                        ],
                      ),
                    ),
                  ),
                ),
            
                SizedBox(
                  height: height!*0.2,
                ),
            
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              width: width!,
              height: height!*0.2,
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
                        PrimaryText(words: "${currentcart!.formatted_grand_total}")
                      ],

                    ),
                  ),
                  Obx(
                      ()=> ConditionalBuilder(
                        condition: controller.isloadmethod.isFalse,
                        builder: (BuildContext context){
                          return   buildButton(context: context,name: "Apply Filter",onTap: () async {
                            if(controller.setpaymethod.value !=""){
                              await controller.setmethodpayment(token: token!,context: context,method:controller.setpaymethod.value  );
                            }else{
                              showresult(context, Colors.red, "Select Payment Method");
                            }
                          });
                        },
                        fallback: (BuildContext context){
                          return Center(child:  CircularProgressIndicator(),);
                        }),
                  )

                ],
              )
            ),
          )
        ]
      ),
    );
  }
}
