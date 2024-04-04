import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Model/oredermodel.dart';

import '../../../Constant/Components.dart';
import '../../../Constant/reusable.dart';
import '../../../Control/logincontroller.dart';

class orderdetails extends StatelessWidget {
  ordermodel model;
  orderdetails({required this.model});

  logincontroller controller = Get.put(logincontroller());
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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
        elevation: 0.0,
        title: PrimaryText(words: "Order Details"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: getcolor(option: model.status!),
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

                child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SecondlyText(words: "${model.status}",color: Colors.white),
                )
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
                child: PrimaryText(words: "Order Info",fontsize: 14),
              ),
              Container(
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SecondlyText(words: "-OrderId : #${model.id}"),
                          SizedBox(height: 3,),
                          SecondlyText(words: "-Shipping : ${model.shipping_description}"),
                          SizedBox(height: 3,),
                          SecondlyText(words: "-Shipping Fee : ${model.formatted_shipping_amount}"),
                          SizedBox(height: 3,),
                          SecondlyText(words: "-Total Price Before Discount : ${model.formatted_sub_total}"),
                          SizedBox(height: 3,),
                          SecondlyText(words: "-Discount : ${model.formatted_discount_amount}"),
                          SizedBox(height: 3,),
                          SecondlyText(words: "-Total Price : ${model.formatted_grand_total}"),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
                child: PrimaryText(words: "Items : ${model.total_item_count}",fontsize: 14),
              ),
              FutureBuilder(
                future:  controller.getorderbyid(token: token!, orderid: model.id!,context: context),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot){
                  if (snapshot.connectionState == ConnectionState.done){
                    return controller.isLoaditems.isFalse?
                        Obx(() =>
                            ConditionalBuilder(
                                condition: controller.isLoaditems.isFalse,
                                builder: (context) => Container(
                                  width: width!,
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
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        listorders.length == 0
                                            ? Center(
                                          child:
                                          PrimaryText(words: "No Orders"),
                                        )
                                            : AnimationLimiter(
                                              child: ListView.separated(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 38.0),
                                                  child: Container(
                                              
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          fontcolorprimary,
                                                          fontcolorsecond,
                                                          Colors.black26
                                                        ], // Replace with your desired gradient colors
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ),
                                                    ),
                                                    height: 1,
                                                  ),
                                                );
                                              },
                                              itemCount: listorders.length,
                                              itemBuilder: (context, index) {
                                                return AnimationConfiguration.staggeredList(
                                                  position: index,
                                                  delay: Duration(milliseconds: 100),
                                                  child: SlideAnimation(
                                                    duration:
                                                    Duration(milliseconds: 2500),
                                                    curve: Curves.fastLinearToSlowEaseIn,
                                                    horizontalOffset: 30,
                                                    verticalOffset: 300.0,
                                                    child: FlipAnimation(
                                                      duration:
                                                      Duration(milliseconds: 3000),
                                                      curve:
                                                      Curves.fastLinearToSlowEaseIn,
                                                      flipAxis: FlipAxis.y,
                                                      child: orderlistItemWidget(
                                                        context,
                                                        listorders[index],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                fallback: (context)=>loadorderlistItemWidget(),
                            ),
                        )
                        :loadorderlistItemWidget();
                  }
                  else{
                    return loadorderlistItemWidget();
                  }
                }

              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
                child: Row(

                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(words: "Shipping Address",fontsize: 14),
                      ],
                    ),),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(words: "Billing Address",fontsize: 14),
                      ],
                    ),)
                  ],
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Name : ${model.shipfname} ${model.shiplname}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Address : ${model.shipaddress}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-City : ${model.shipcity}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Emirate : ${model.shipstate}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Country : ${model.shipcountry}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Phone : ${model.shipphone}",)),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  SizedBox(width: 5,),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(

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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Name : ${model.billfname} ${model.billlname}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Address : ${model.billaddress}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-City : ${model.billcity}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Emirate : ${model.billstate}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Country : ${model.billcountry}",)),
                                  SizedBox(height: 3,),
                                  Container(width:width!*0.4,child: SecondlyText(words: "-Phone : ${model.billphone}",)),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
