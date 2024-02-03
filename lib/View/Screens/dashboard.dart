import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/dashboardcontroller.dart';
import 'package:omega/Control/homecontroller.dart';
import 'package:omega/View/Screens/favorite.dart';

class dashboard extends StatelessWidget {
  //final homecontroller con = Get.find<homecontroller>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: fontcolorprimary,
            child: SvgPicture.asset(
              'assets/images/img_megaphone.svg',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: fontcolorprimary,
              child: InkWell(
                onTap: () {
                  print(user!.email);
                },
                child: SvgPicture.asset(
                  'assets/images/img_search.svg',
                ),
              ),
            ),
          ),
        ],
      ),
 
      body:Container(
        width: getwidth(context),
        height: getheight(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: [
                  buildbanner(context),
                  buildbanner(context),
                  buildbanner(context),
                  buildbanner(context),
                ],
                options: CarouselOptions(

                  reverse: false,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 6.0),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: PrimaryText(words: "Popular", fontsize: 20)),
                    Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: SecondlyText(words: "See all"))
                  ],
                ),
              ),

              GetBuilder<dashcontroller>(
                init: dashcontroller(),
                  builder: (dashcontroller control)=> Container(
                    height: 50,
                    child: ListView.builder(
                      itemBuilder: (context, index) => buildlist(index),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                    ),
                  ),),


              Column(
                children: [
                  Container(
                    child: AnimationLimiter(
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics:
                        BouncingScrollPhysics(), //BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1 / 1.35,
                        children: List.generate(10, (index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: Duration(milliseconds: 1000),
                            columnCount: 2,
                            child: ScaleAnimation(
                              duration: Duration(milliseconds: 1200),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                  "assets/images/img_bg.png",
                                                ),
                                                width:
                                                getwidth(context) * 0.5,
                                                fit: BoxFit.cover,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 8.0, right: 8.0),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: CircleAvatar(
                                                    child: Image(
                                                      image: AssetImage(
                                                        "assets/images/img_heart.png",
                                                      ),
                                                      width:
                                                      getwidth(context) *
                                                          0.03,
                                                      //color: Colors.red,
                                                    ),
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.5),
                                                    radius: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 14.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              PrimaryText(
                                                  words: 'Airprods USA',
                                                  fontsize: 14),
                                              SecondlyText(
                                                  words: "chair",
                                                  fontsize: 12),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  PrimaryText(
                                                      words: '\$245.00 ',
                                                      fontsize: 14),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        right: 15.0),
                                                    child: SvgPicture.asset(
                                                        "assets/images/img_plus_primary.svg"),
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
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
