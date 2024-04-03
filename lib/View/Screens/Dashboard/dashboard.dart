import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/dashboardcontroller.dart';
import 'package:omega/View/Screens/Dashboard/searchscreen.dart';
import 'package:omega/View/Screens/signup/login_screen.dart';
import 'package:omega/View/Screens/signup/register_screen.dart';
import 'package:omega/View/web/webpage.dart';

class dashboard extends StatefulWidget {
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> with TickerProviderStateMixin {
  dashcontroller dashcon = Get.put(dashcontroller(), permanent: true);
  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  bool _bool = true;
   bool isinternet=false;

  void initState()  {
    super.initState();
    checkinternet();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _animation1 = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _bool = true;
        }
      });
    _animation2 = Tween<double>(begin: 0, end: .3).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animation3 = Tween<double>(begin: .9, end: 1).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });
  }
  Future<void> checkinternet()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult==ConnectivityResult.none){
      setState(() {
        isinternet=false;
      });
    }else{
      setState(() {
        isinternet=true;
      });
    }
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
            child: InkWell(
              onTap: () {
                if (_bool == true) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {
                  _bool = !_bool;
                });
            print(_bool);
              },
              child: SvgPicture.asset(
                'assets/images/img_megaphone.svg',
              ),
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
                  dashcon.isListempty.value = false;
                  listsearch = [];
                  Get.to(() => searchscreen(),
                      transition: Transition.cupertinoDialog,
                      curve: Curves.bounceInOut,
                      duration: Duration(seconds: 1));
                },
                child: SvgPicture.asset(
                  'assets/images/img_search.svg',
                ),
              ),
            ),
          ),
        ],
      ),
      body: PopScope(
        canPop: _bool ,
        onPopInvoked: (bool){
          setState(() {
            _bool=!_bool;
          });

        },
        child:  ConditionalBuilder(
            condition: isinternet,
            builder: (BuildContext context) {
              return Stack(

                children: [
                  FutureBuilder(
                    future: dashcon.getcategories(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          width: getwidth(context),
                          height: getheight(context),
                          color: Colors.white,
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
                                Container(
                                  height: 50,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return buildlist(
                                        index,
                                        listcategories[index],
                                        dashcon,
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listcategories.length,
                                  ),
                                ),
                                FutureBuilder(
                                  future: dashcon.getproductbycategory(
                                      id: listcategories[dashcon.selectedlistindex.value].id!),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<void> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Obx(
                                            () => ConditionalBuilder(
                                          condition: dashcon.isLoad.isFalse,
                                          builder: (context) => Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                    childAspectRatio: 1 / 1.4,
                                                    children: List.generate(
                                                        listproducts.length, (index) {
                                                      var item = listproducts[index];
                                                      return AnimationConfiguration
                                                          .staggeredGrid(
                                                        position: index,
                                                        duration: Duration(
                                                            milliseconds: 1000),
                                                        columnCount: 2,
                                                        child: ScaleAnimation(
                                                          duration: Duration(
                                                              milliseconds: 1200),
                                                          curve: Curves
                                                              .fastLinearToSlowEaseIn,
                                                          child: FadeInAnimation(
                                                            child: ProductList(
                                                                context,
                                                                listproducts[index],
                                                                dashcon,
                                                                item),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          fallback: (context) => GridView.count(
                                              crossAxisCount: 2,
                                              shrinkWrap: true,
                                              physics:
                                              BouncingScrollPhysics(), //BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                              mainAxisSpacing: 10.0,
                                              crossAxisSpacing: 1.0,
                                              childAspectRatio: 1 / 1.3,

                                              // Replace with your desired number of shimmer items
                                              children: List.generate(4, (index) {
                                                return ProductListLoading(context);
                                              })),
                                        ),
                                      );
                                    } else {
                                      return GridView.count(
                                          crossAxisCount: 2,
                                          shrinkWrap: true,
                                          physics:
                                          BouncingScrollPhysics(), //BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                          mainAxisSpacing: 10.0,
                                          crossAxisSpacing: 1.0,
                                          childAspectRatio: 1 / 1.3,

                                          // Replace with your desired number of shimmer items
                                          children: List.generate(4, (index) {
                                            return ProductListLoading(context);
                                          }));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: width!,
                          height: height!,
                          child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: loadingbanner(context),
                                  ),
                                  Container(
                                    height: 25,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return loadinglist(context);
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                    ),
                                  ),
                                ],
                              )),
                        );
                      }
                    },
                  ),
                  !_bool?CustomNavigationDrawer():SizedBox(),
                ],
              );
            },
            fallback: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child:PrimaryText(words: "No Internet"),

                  ),
                  SizedBox(height: 5,),
                  IconButton(
                      onPressed: (){
                        checkinternet();
                      },
                      icon: Icon(Icons.autorenew_rounded)),
                ],
              );
            },

          ),


      ),
    );
  }

  Widget CustomNavigationDrawer() {
    double _height = height!;
    double _width = width!;
    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaY: _animation1.value, sigmaX:_animation1.value),
      child: Container(
        height:  _bool ? 0 : _height,
        width: _bool ? 0 : _width,
        color: Colors.transparent,
        child: Center(
          child: Transform.scale(
            scale:_animation3.value,
            child: Container(
              width: _width * .9,
              height: _width * 1.3,
              decoration: BoxDecoration(
                color: fontcolorprimary.withOpacity(_animation2.value),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black12,
                    radius: 35,
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
                      MyTile(Icons.info_outline_rounded, 'About', () {
                        HapticFeedback.lightImpact();
                        Get.to(()=>webview(url: "https://www.google.com", Pagename: "About"));


                      }),
                      MyTile(Icons.feedback_outlined, 'Feedback', () {
                        HapticFeedback.lightImpact();
                        Get.to(()=>webview(url: "https://www.youtube.com/", Pagename: "Feedback"));

                      }),
                      MyTile(Icons.find_in_page_outlined, 'Privacy & Policy', () {
                        HapticFeedback.lightImpact();
                        Get.to(()=>webview(url: "https://www.linkedin.com/in/ali-sheikh98/", Pagename: "Privacy & Policy"));

                      }),
                    ],
                  ),
                  //

                  currentuser==null?
                  Row(
                    children: [
                      Container(
                        width: width!*0.35,
                        height:width!*0.25 ,
                        child: buildsmallButton(context: context, name: "Signup",buttoncolor: Colors.transparent,onTap: (){
                          homecontrol.currentindex=0.obs;
                          dashcon.isLoad.value = false;
                          Get.off(registerscreen(),
                              transition: Transition.fadeIn,
                              curve: Curves.easeOut,
                              duration: Duration(seconds: 1));
                        },),
                      ),
                      SizedBox(width: width!*0.05,),
                      SecondlyText(words: "OR",color: Colors.white),
                      SizedBox(width: width!*0.05,),
                      Container(
                        width: width!*0.35,
                        height:width!*0.25 ,
                        child: buildsmallButton(context: context, name: "Login",buttoncolor: Colors.transparent,onTap: (){
                          homecontrol.currentindex=0.obs;
                          dashcon.isLoad.value = false;
                          Get.off(loginscreen(),
                              transition: Transition.fadeIn,
                              curve: Curves.easeOut,
                              duration: Duration(seconds: 1));
                        }),
                      ),
                    ],
                  )
                  :SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget MyTile(
    IconData icon,
    String title,
    VoidCallback voidCallback,
  ) {
    return Column(
      children: [
        ListTile(
          tileColor: Colors.black.withOpacity(.08),
          leading: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          onTap: voidCallback,
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
          trailing: Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
        ),
        divider(),

      ],
    );
  }

  Widget divider() {
    return Container(
      height: 5,
      width: width!,
    );
  }
}

