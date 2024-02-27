import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/View/Screens/payment_screen.dart';

import '../../Constant/Components.dart';
import '../../Control/dashboardcontroller.dart';

class cartscreen extends StatelessWidget {
  dashcontroller dashcon = Get.put(dashcontroller(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: FutureBuilder(
            future: dashcon.getcart(token: token!, context: context),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 36.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          currentcart == null
                            ? PrimaryText(words: "Items in Cart :   0 ")
                            : Obx(
                      ()=> PrimaryText(
                              words:
                              "Items in Cart :    ${dashcon.totalItems}"),
                            ),


                          SizedBox(
                            height: 20,
                          ),
                          AnimationLimiter(
                            child: listcart.length == 0
                                ? Center(
                                    child: PrimaryText(words: "No items in Cart"),
                                  )
                                : ListView.separated(
                                    itemCount: listcart.length,
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(height: 20);
                                    },
                                    itemBuilder: (BuildContext context, int index) {
                                      final item = listcart[index];
                                      return AnimationConfiguration.staggeredList(
                                        position: index,
                                        delay: Duration(milliseconds: 100),
                                        child: SlideAnimation(
                                          duration: Duration(milliseconds: 1000),
                                          curve: Curves.easeInToLinear,
                                          horizontalOffset: 30,
                                          verticalOffset: 300.0,
                                          child: FlipAnimation(
                                              duration: Duration(milliseconds: 1000),
                                              curve: Curves.easeInToLinear,
                                              flipAxis: FlipAxis.y,
                                              child: CartlistItemWidget(context,
                                                  listcart[index], item, dashcon)),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            width: getwidth(context),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      SecondlyText(words: "Items Cost"),
                                      Spacer(),
                                     currentcart == null
                                          ? PrimaryText(words: "\$0.0", fontsize: 16)
                                          : Obx(
                                         ()=> PrimaryText(
                                                words:
                                                    "${dashcon.itemscost.value}",
                                                fontsize: 16),
                                          )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      SecondlyText(words: "Shipping Fee"),
                                      Spacer(),
                                    currentcart == null
                                          ? PrimaryText(words: "\$0.0", fontsize: 16)
                                          : Obx(
                                        ()=> PrimaryText(
                                                words:
                                                    "${dashcon.shippingfee}",
                                                fontsize: 16),
                                          )
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      SecondlyText(words: "Total Price"),
                                      Spacer(),
                                     currentcart == null
                                          ? PrimaryText(words: "\$0.0", fontsize: 16)
                                          : Obx(
                                         ()=> PrimaryText(
                                                words:
                                                    "${dashcon.totalprice}",
                                                fontsize: 20),
                                          )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          buildButton(
                              context: context,
                              name: "Checkout",
                              onTap: () {
                                Get.to(paymentscreen(),
                                    transition: Transition.topLevel,
                                    curve: Curves.easeInOut,
                                    duration: Duration(seconds: 3));
                              }),
                        ],
                      ),

                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

        ),
    Offstage(
      offstage:dashcon.isLoadremove.isFalse,
      child: Opacity(opacity: 0.3,
        child: Container(
          color: Colors.cyanAccent,
          width: width!,
          height: height!,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),

      ),
    )
      ],
    );

  }
}
