import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Control/dashboardcontroller.dart';

import '../../../Constant/reusable.dart';


class searchscreen extends StatelessWidget {
  TextEditingController searchcon = TextEditingController();
  var formkey = GlobalKey<FormState>();
  dashcontroller controller = Get.put(dashcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leadingWidth: 70.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            onPressed: () async {
              controller.isLoad.value=true;
              await controller.getproductbycategory(
                  id: listcategories[controller.selectedlistindex.value].id!);
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
        title:
            PrimaryText(words: "Search", wight: FontWeight.w400, fontsize: 20),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: TextFormField(
                        controller: searchcon,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Search Must Not be Empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Input Name Of Product",
                            suffixIcon: InkWell(
                                onTap: () async {
                                  String mysearch = searchcon.text;
                                  if (formkey.currentState!.validate()) {
                                    await controller.searchproducts(
                                        name: mysearch);
                                    if (listsearch.length == 0) {
                                      showresult(context, Colors.red,
                                          "No Product In this Name");
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.search,
                                  color: themesecond,
                                ))),
                        onFieldSubmitted: (value) async {
                          if (formkey.currentState!.validate()) {
                            String mysearch = searchcon.text;
                            await controller.searchproducts(name: mysearch);
                            if (listsearch.length == 0) {
                              showresult(context, Colors.red,
                                  "No Product In this Name");
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => ConditionalBuilder(
                        condition: controller.isLoadsearch.isFalse,
                        builder: (context) {
                          return AnimationLimiter(
                            child: controller.isListempty.isTrue
                                ? Center(
                                    child: PrimaryText(
                                        words: "No Item in this Name"),
                                  )
                                : ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 20);
                                    },
                                    itemCount: listsearch.length,
                                    itemBuilder: (context, index) {
                                      var item = listsearch[index];
                                      return AnimationConfiguration
                                          .staggeredList(
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
                                              child: searchlistItemWidget(
                                                  context,
                                                  listsearch[index],
                                                  controller,
                                                  item)),
                                        ),
                                      );
                                    }),
                          );
                        },
                        fallback: (context) {
                          return AnimationLimiter(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 20);
                                },
                                itemCount: 5,
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
                                        child: favoriteloading(context),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Offstage(
                offstage: controller.isLoad.isFalse,
                child: Container(
                    width: width!,
                    height: height!,
                    child: Center(child: CircularProgressIndicator()))),
          ),
        ],
      ),
    );
  }
}
