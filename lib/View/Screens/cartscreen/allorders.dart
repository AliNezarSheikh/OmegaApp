import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';

import '../../../Constant/Components.dart';
import '../../../Control/logincontroller.dart';

class allorders extends StatelessWidget {
  logincontroller controller = Get.put(logincontroller());

  @override
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
        title: PrimaryText(words: "My Orders"),
      ),
      body: FutureBuilder(
        future: controller.getorders(
          token: token!,
        ),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return controller.isLoadingorders.isFalse
                ? Obx(
                  () => ConditionalBuilder(
                condition: controller.isLoadingorders.isFalse,
                builder: (context) => Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 26.0, horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            orders.length == 0
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
                                    return SizedBox(height: 20);
                                  },
                                  itemCount: orders.length,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration
                                        .staggeredList(
                                      position: index,
                                      delay: Duration(
                                          milliseconds: 100),
                                      child: SlideAnimation(
                                        duration: Duration(
                                            milliseconds: 2500),
                                        curve: Curves
                                            .fastLinearToSlowEaseIn,
                                        horizontalOffset: 30,
                                        verticalOffset: 300.0,
                                        child: FlipAnimation(
                                            duration: Duration(
                                                milliseconds: 3000),
                                            curve: Curves
                                                .fastLinearToSlowEaseIn,
                                            flipAxis: FlipAxis.y,
                                            child: orderslist(
                                                orders[index],
                                                controller,
                                                context)),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                fallback: (context) => loadorders(),
              ),
            )
                : loadorders();;
          } else {
            return loadorders();
          }
        },
      ),
    );
  }
}

class loadorders extends StatelessWidget {
  const loadorders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 26.0, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                AnimationLimiter(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            horizontalOffset: 30,
                            verticalOffset: 300.0,
                            child: FlipAnimation(
                                duration: Duration(milliseconds: 3000),
                                curve: Curves.fastLinearToSlowEaseIn,
                                flipAxis: FlipAxis.y,
                                child: ordersload(context)),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
