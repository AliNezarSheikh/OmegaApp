import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';

import '../../Control/dashboardcontroller.dart';

class favorite extends GetView<dashcontroller> {
  dashcontroller dashcon = Get.put(dashcontroller());
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: dashcon.getwishlist(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 36.0, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    words: "Your Favorite  ",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => ConditionalBuilder(
                      condition: dashcon.isLoadwish.isFalse,
                      builder: (BuildContext context) {
                        return AnimationLimiter(
                          child:dashcon.listwishs.length == 0?Center(
                            child:
                            PrimaryText(words: "No Favorite"),): ListView.separated(
                              physics: BouncingScrollPhysics(),

                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 20);
                              },
                              itemCount: dashcon.listwishs.length,
                              itemBuilder: (context, index) {
                                var item=dashcon.listwishs[index];
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
                                              child: ProductlistItemWidget(
                                                  context,
                                                  dashcon.listwishs[index],
                                                  dashcon,item)),
                                        ),
                                      );
                              }),
                        );
                      },
                      fallback: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
