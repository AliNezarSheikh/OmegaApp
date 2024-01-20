import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:omega/Constant/reusable.dart';

class cartscreen extends StatelessWidget {
  const cartscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(words: "Items in Cart :      4"),
                SizedBox(
                  height: 20,
                ),
                AnimationLimiter(
                  child: ListView.separated(
                    itemCount: 2,
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
                          curve: Curves.easeInToLinear,
                          horizontalOffset: 30,
                          verticalOffset: 300.0,
                          child: FlipAnimation(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeInToLinear,
                              flipAxis: FlipAxis.y,
                              child: CartlistItemWidget(context)),
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
                            SecondlyText(words: "Item Cost"),
                            Spacer(),
                            PrimaryText(words: "\$169.00", fontsize: 16)
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
                            PrimaryText(words: "\$29.00", fontsize: 16)
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
                            PrimaryText(words: "\$198.00", fontsize: 20)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                buildcheckButton(context: context, name: "Checkout"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
