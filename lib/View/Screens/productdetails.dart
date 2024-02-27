import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:omega/Control/dashboardcontroller.dart';
import 'package:omega/Model/productmodel.dart';
import 'package:omega/View/Screens/home_screen.dart';

import '../../Constant/Components.dart';
import '../../Constant/reusable.dart';

class productdetails extends StatelessWidget {
  productmodel model;
  productdetails({required this.model});
  dashcontroller control = Get.put(dashcontroller());
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
            //  control.getproductbycategory(id: listcategories[control.selectedlistindex.value].id!);
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
        title: PrimaryText(
            words: "Product Details", wight: FontWeight.w400, fontsize: 20),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: width!,
                    height: width!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: fontcolorprimary.withOpacity(0.05),
                          spreadRadius: 6,
                          blurRadius: 4,
                          offset: Offset(
                            2,
                            4,
                          ),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage("${model.original_image_url}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        children: [
                          PrimaryText(
                              words: "${model.name}", wight: FontWeight.w300),
                          SizedBox(
                            height: 10,
                          ),
                          SecondlyText(words: "${model.short_description}"),
                          SizedBox(
                            height: 10,
                          ),
                          PrimaryText(
                              words: "${model.formatted_price}",
                              wight: FontWeight.w500),
                        ],
                      ),
                    ),
                    Spacer(),
                    Obx(
                      () => ConditionalBuilder(
                        condition: control.isLoad.isFalse,
                        builder: (BuildContext context) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, right: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0,
                                        0), // controls the position of the shadow
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await control.addorremovefromwish(
                                      productid: model.id!,
                                      token: token!,
                                      context: context);
                                  await control.getproductbycategory(
                                      id: listcategories[
                                              control.selectedlistindex.value]
                                          .id!);
                                  model.iswishlisted = !model.iswishlisted;
                                },
                                child: CircleAvatar(
                                  backgroundColor: model.iswishlisted
                                      ? Colors.red
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      "assets/images/img_heart_primary.svg",
                                      width: width! * 0.3,
                                    ),
                                  ),
                                  radius: 25,
                                ),
                              ),
                            ),
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
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: PrimaryText(
                      words: "Description",
                      fontsize: 20,
                      wight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SecondlyText(words: "${model.description}"),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
    ()=> ConditionalBuilder(
                  condition: control.loadadd.isFalse,
                  builder: (BuildContext context) {  return buildButton(
                      context: context,
                      name: "Add To Cart",
                      onTap: () async {
                        await control.addtocart(
                            productid: model.id!, token: token!, context: context);
                      });},
                  fallback: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15.0,bottom: 15.0),
                      child: CircleAvatar(
                          radius: 10,
                          child: CircularProgressIndicator()),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
