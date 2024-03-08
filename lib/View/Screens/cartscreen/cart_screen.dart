import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/homecontroller.dart';
import 'package:omega/View/Screens/cartscreen/setbillingaddress.dart';
import 'package:omega/View/Screens/payment_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Constant/Components.dart';
import '../../../Control/dashboardcontroller.dart';
import '../address/addadress.dart';

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
                      children: <Widget>[
                        currentcart == null
                            ? PrimaryText(words: "Items in Cart :   0 ")
                            : Obx(
                                () => PrimaryText(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                            duration:
                                                Duration(milliseconds: 1000),
                                            curve: Curves.easeInToLinear,
                                            flipAxis: FlipAxis.y,
                                            child: CartlistItemWidget(
                                                context,
                                                listcart[index],
                                                item,
                                                dashcon)),
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
                                        ? PrimaryText(
                                            words: "\$0.0", fontsize: 16)
                                        : Obx(
                                            () => PrimaryText(
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
                                        ? PrimaryText(
                                            words: "\$0.0", fontsize: 16)
                                        : Obx(
                                            () => PrimaryText(
                                                words: "${dashcon.shippingfee}",
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
                                        ? PrimaryText(
                                            words: "\$0.0", fontsize: 16)
                                        : Obx(
                                            () => PrimaryText(
                                                words: "${dashcon.totalprice}",
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
                        ConditionalBuilder(
                            condition:   currentcart!=null||homecontroller.itemsincart.value>1,
                            builder: (context)=>buildButton(
                              context: context,
                              name: "Checkout",
                              onTap:  (){
                                if(homecontroller.itemsincart.value<1){
                                  showresult(context, Colors.red, "Cart is Empty");
                                         }
                                else{
                                  Get.to(()=>setbilling(),
                                  transition: Transition.downToUp,
                                  curve: Curves.easeIn,
                                  duration: Duration(seconds: 1));
                                /*  showModalBottomSheet(
                                    enableDrag: true,
                                    context: context,
                                    isScrollControlled: true,
                                    showDragHandle: true,
                                    builder: (BuildContext context,) {
                                      listadress=[];
                                      return Container(
                                        height: height! * 0.5,
                                        child: FutureBuilder(
                                          future: checkcon.getadress(token: token!,),
                                          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              return checkcon.isLoadingaddress.isFalse
                                                  ? Obx(
                                                    () =>
                                                        ConditionalBuilder(
                                                  condition: checkcon.isLoadingaddress.isFalse,
                                                  builder: (context) => Stack(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                                                        child: Align(
                                                            alignment: Alignment.topCenter,
                                                            child: PrimaryText(words: "Set Billing Address", fontsize: 14, wight: FontWeight.w400)),
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 18),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              listadress.length == 0
                                                                  ? Center(
                                                                child: PrimaryText(
                                                                    words:
                                                                    "No Address"),
                                                              )
                                                                  : AnimationLimiter(
                                                                child: ListView.separated(
                                                                    physics: BouncingScrollPhysics(),
                                                                    shrinkWrap: true,
                                                                    separatorBuilder: (context, index) {
                                                                      return SizedBox(height: 20);
                                                                    },
                                                                    itemCount: listadress.length,
                                                                    itemBuilder: (context, index) {

                                                                      return AnimationConfiguration.staggeredList(
                                                                        position: index,
                                                                        delay: Duration(milliseconds: 100),
                                                                        child: SlideAnimation(
                                                                          duration: Duration(milliseconds: 2500),
                                                                          curve: Curves.fastLinearToSlowEaseIn,
                                                                          horizontalOffset: 30,
                                                                          verticalOffset: 300.0,
                                                                          child: FlipAnimation(duration: Duration(milliseconds: 3000), curve: Curves.fastLinearToSlowEaseIn, flipAxis: FlipAxis.y,
                                                                              child: adresslistbilling(listadress[index], checkcon,context,)),
                                                                        ),
                                                                      );
                                                                    }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: width! * 0.50,
                                                              height: width! * 0.2,
                                                              child: buildsmallButton(
                                                                  context: context,
                                                                  name: "Add New Address",
                                                                  buttoncolor:fontcolorprimary,
                                                                  Textcolor:  Colors.white,
                                                                  onTap: () {
                                                                    Get.to(() => addadress(),
                                                                        transition: Transition.rightToLeft,
                                                                        curve: Curves.easeInOut,
                                                                        duration: Duration(milliseconds: 700));
                                                                  }),
                                                            ),
                                                            Container(
                                                              width: width! * 0.5,
                                                              height: width! * 0.2,
                                                              child: Obx(
                                                                    ()=> ConditionalBuilder(
                                                                  condition: dashcon.isLoadingaddress.isFalse,
                                                                  builder: (BuildContext context) {
                                                                    return  buildsmallButton(
                                                                        context: context,
                                                                        name: "Save",
                                                                        Textcolor:  Colors.white,
                                                                        buttoncolor:fontcolorprimary,
                                                                        onTap: (){
                                                                          if(checkcon.setbillingaddress.value.id != null){
                                                                            showModalBottomSheet(
                                                                              enableDrag: true,
                                                                              context: context,
                                                                              isScrollControlled: true,
                                                                              showDragHandle: true,
                                                                              builder: (BuildContext context,) {
                                                                                listadress=[];
                                                                                return Container(
                                                                                  height: height! * 0.5,
                                                                                  child: FutureBuilder(
                                                                                    future: checkcon.getadress(token: token!,),
                                                                                    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                                                                                      if (snapshot.connectionState == ConnectionState.done) {
                                                                                        return checkcon.isLoadingaddress.isFalse
                                                                                            ? Obx(() =>
                                                                                              ConditionalBuilder(
                                                                                                condition: checkcon.isLoadingaddress.isFalse,
                                                                                                builder: (context) => Stack(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                                                                                                      child: Align(alignment: Alignment.topCenter,
                                                                                                          child: PrimaryText(
                                                                                                              words:
                                                                                                              "Set Shipping Address", fontsize: 14, wight: FontWeight.w400)),
                                                                                                    ),
                                                                                                    SingleChildScrollView(
                                                                                                      child: Padding(
                                                                                                        padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 18),
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            SizedBox(
                                                                                                              height: 20,
                                                                                                            ),
                                                                                                            listadress.length == 0
                                                                                                                ? Center(
                                                                                                              child: PrimaryText(
                                                                                                                  words:
                                                                                                                  "No Address"),
                                                                                                            )
                                                                                                                : AnimationLimiter(
                                                                                                              child: ListView.separated(
                                                                                                                  physics: BouncingScrollPhysics(),
                                                                                                                  shrinkWrap: true,
                                                                                                                  separatorBuilder: (context, index) {
                                                                                                                    return SizedBox(height: 20);
                                                                                                                  },
                                                                                                                  itemCount: listadress.length,
                                                                                                                  itemBuilder: (context, index) {

                                                                                                                    return AnimationConfiguration.staggeredList(
                                                                                                                      position: index,
                                                                                                                      delay: Duration(milliseconds: 100),
                                                                                                                      child: SlideAnimation(
                                                                                                                        duration: Duration(milliseconds: 2500),
                                                                                                                        curve: Curves.fastLinearToSlowEaseIn,
                                                                                                                        horizontalOffset: 30,
                                                                                                                        verticalOffset: 300.0,
                                                                                                                        child: FlipAnimation(duration: Duration(milliseconds: 3000), curve: Curves.fastLinearToSlowEaseIn, flipAxis: FlipAxis.y,
                                                                                                                            child: adresslistshipping(listadress[index], checkcon,context,)),
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  }),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),

                                                                                                    Align(
                                                                                                      alignment: Alignment.bottomCenter,
                                                                                                      child: Row(
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            width: width! * 0.50,
                                                                                                            height: width! * 0.2,
                                                                                                            child: buildsmallButton(
                                                                                                                context: context,
                                                                                                                name: "Add New Address",
                                                                                                                buttoncolor:fontcolorprimary,
                                                                                                                Textcolor:  Colors.white,
                                                                                                                onTap: () {
                                                                                                                  Get.to(() => addadress(),
                                                                                                                      transition: Transition.rightToLeft,
                                                                                                                      curve: Curves.easeInOut,
                                                                                                                      duration: Duration(milliseconds: 700));
                                                                                                                }),
                                                                                                          ),
                                                                                                          Container(
                                                                                                            width: width! * 0.5,
                                                                                                            height: width! * 0.2,
                                                                                                            child: Obx(
                                                                                                                  ()=> ConditionalBuilder(
                                                                                                                condition: dashcon.isLoadingaddress.isFalse,
                                                                                                                builder: (BuildContext context) {
                                                                                                                  return  buildsmallButton(
                                                                                                                      context: context,
                                                                                                                      name: "Save",
                                                                                                                      Textcolor:  Colors.white,
                                                                                                                      buttoncolor:fontcolorprimary,
                                                                                                                      onTap: () async {
                                                                                                                        if(checkcon.setshippingaddress.value.id !=null){
                                                                                                                          await dashcon.setbillingandshippingaddress(
                                                                                                                              idbil: checkcon.setbillingaddress.value.id!,
                                                                                                                              phoneaddressbil: checkcon.setbillingaddress.value.phoneaddress!,
                                                                                                                              state_namebil:  checkcon.setbillingaddress.value.state!,
                                                                                                                              address1bil: checkcon.setbillingaddress.value.address1!,
                                                                                                                              first_namebil:  checkcon.setbillingaddress.value.firstname!,
                                                                                                                              last_namebil:  checkcon.setbillingaddress.value.lastname!,
                                                                                                                              citybil:  checkcon.setbillingaddress.value.city!,
                                                                                                                              emailbil: currentuser!.email!,
                                                                                                                              address1shi: checkcon.setshippingaddress.value.address1!,
                                                                                                                              cityshi: checkcon.setshippingaddress.value.city! ,
                                                                                                                              emailshi:  currentuser!.email!,
                                                                                                                              first_nameshi: checkcon.setshippingaddress.value.firstname! ,
                                                                                                                              idshi: checkcon.setshippingaddress.value.id!,
                                                                                                                              last_nameshi: checkcon.setshippingaddress.value.lastname!,
                                                                                                                              phoneaddressshi: checkcon.setshippingaddress.value.phoneaddress!,
                                                                                                                              state_nameshi: checkcon.setshippingaddress.value.state!,
                                                                                                                              context: context,
                                                                                                                              token: token!);
                                                                                                                          if(dashcon.successaddress.isTrue){

                                                                                                                            Get.to(()=>paymentscreen(),
                                                                                                                              transition: Transition.zoom,
                                                                                                                              curve: Curves.easeIn,
                                                                                                                              duration: Duration(seconds: 1)
                                                                                                                            );
                                                                                                                          }
                                                                                                                        }
                                                                                                                      });
                                                                                                                },
                                                                                                                fallback: (BuildContext context) {
                                                                                                                  return Center(child: CircularProgressIndicator(),);
                                                                                                                },

                                                                                                              ),
                                                                                                            ),
                                                                                                          ),

                                                                                                        ],
                                                                                                      ),
                                                                                                    )

                                                                                                  ],
                                                                                                ),
                                                                                                fallback: (context) => Stack(
                                                                                                  children: [
                                                                                                    SingleChildScrollView(
                                                                                                      child: Padding(
                                                                                                        padding:
                                                                                                        const EdgeInsets
                                                                                                            .symmetric(
                                                                                                            vertical:
                                                                                                            26.0,
                                                                                                            horizontal:
                                                                                                            18),
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment:
                                                                                                          CrossAxisAlignment
                                                                                                              .start,
                                                                                                          children: [
                                                                                                            SizedBox(
                                                                                                              height: 20,
                                                                                                            ),
                                                                                                            AnimationLimiter(
                                                                                                              child: ListView
                                                                                                                  .separated(
                                                                                                                  physics:
                                                                                                                  BouncingScrollPhysics(),

                                                                                                                  separatorBuilder:
                                                                                                                      (context,
                                                                                                                      index) {
                                                                                                                    return SizedBox(
                                                                                                                        height: 20);
                                                                                                                  },
                                                                                                                  itemCount:
                                                                                                                  3,
                                                                                                                  itemBuilder:
                                                                                                                      (context,
                                                                                                                      index) {
                                                                                                                    return AnimationConfiguration
                                                                                                                        .staggeredList(
                                                                                                                      position:
                                                                                                                      index,
                                                                                                                      delay:
                                                                                                                      Duration(milliseconds: 100),
                                                                                                                      child:
                                                                                                                      SlideAnimation(
                                                                                                                        duration: Duration(milliseconds: 2500),
                                                                                                                        curve: Curves.fastLinearToSlowEaseIn,
                                                                                                                        horizontalOffset: 30,
                                                                                                                        verticalOffset: 300.0,
                                                                                                                        child: FlipAnimation(duration: Duration(milliseconds: 3000), curve: Curves.fastLinearToSlowEaseIn, flipAxis: FlipAxis.y, child: adresslistload(context)),
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  }),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Align(
                                                                                                      alignment: Alignment
                                                                                                          .bottomCenter,
                                                                                                      child: Row(
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            width: width! * 0.50,
                                                                                                            height: width! * 0.2,
                                                                                                            child:
                                                                                                            buildsmallButton(
                                                                                                              context:
                                                                                                              context,
                                                                                                              name:
                                                                                                              "Add New Address",
                                                                                                              buttoncolor:
                                                                                                              Colors
                                                                                                                  .transparent,
                                                                                                              Textcolor: fontcolorprimary,
                                                                                                              onTap: () {},
                                                                                                            ),
                                                                                                          ),
                                                                                                          Container(
                                                                                                            width:
                                                                                                            width! * 0.5,
                                                                                                            height:
                                                                                                            width! * 0.2,
                                                                                                            child:
                                                                                                            buildsmallButton(
                                                                                                              context:
                                                                                                              context,
                                                                                                              name:
                                                                                                              "Save",
                                                                                                              Textcolor: fontcolorprimary,
                                                                                                              buttoncolor:
                                                                                                              Colors
                                                                                                                  .transparent,
                                                                                                              onTap: () {},
                                                                                                            ),
                                                                                                          ),

                                                                                                        ],
                                                                                                      ),
                                                                                                    )
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                        )
                                                                                            : loadaddressbottomshet();
                                                                                      }
                                                                                      else {
                                                                                        return loadaddressbottomshet();
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                          }else{
                                                                            showresult(context, Colors.red, "select address");
                                                                          }

                                                                        });
                                                                  },
                                                                  fallback: (BuildContext context) {
                                                                    return Center(child: CircularProgressIndicator(),);
                                                                  },

                                                                ),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      )

                                                    ],
                                                  ),
                                                  fallback: (context) => Stack(
                                                    children: [
                                                      SingleChildScrollView(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical:
                                                              26.0,
                                                              horizontal:
                                                              18),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              AnimationLimiter(
                                                                child: ListView
                                                                    .separated(
                                                                    physics:
                                                                    BouncingScrollPhysics(),

                                                                    separatorBuilder:
                                                                        (context,
                                                                        index) {
                                                                      return SizedBox(
                                                                          height: 20);
                                                                    },
                                                                    itemCount:
                                                                    3,
                                                                    itemBuilder:
                                                                        (context,
                                                                        index) {
                                                                      return AnimationConfiguration
                                                                          .staggeredList(
                                                                        position:
                                                                        index,
                                                                        delay:
                                                                        Duration(milliseconds: 100),
                                                                        child:
                                                                        SlideAnimation(
                                                                          duration: Duration(milliseconds: 2500),
                                                                          curve: Curves.fastLinearToSlowEaseIn,
                                                                          horizontalOffset: 30,
                                                                          verticalOffset: 300.0,
                                                                          child: FlipAnimation(duration: Duration(milliseconds: 3000), curve: Curves.fastLinearToSlowEaseIn, flipAxis: FlipAxis.y, child: adresslistload(context)),
                                                                        ),
                                                                      );
                                                                    }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: width! * 0.50,
                                                              height: width! * 0.2,
                                                              child:
                                                              buildsmallButton(
                                                                context:
                                                                context,
                                                                name:
                                                                "Add New Address",
                                                                buttoncolor:
                                                                Colors
                                                                    .transparent,
                                                                Textcolor: fontcolorprimary,
                                                                onTap: () {},
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                              width! * 0.5,
                                                              height:
                                                              width! * 0.2,
                                                              child:
                                                              buildsmallButton(
                                                                context:
                                                                context,
                                                                name:
                                                                "Save",
                                                                Textcolor: fontcolorprimary,
                                                                buttoncolor:
                                                                Colors
                                                                    .transparent,
                                                                onTap: () {},
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                                  : loadaddressbottomshet();
                                            }
                                            else {
                                              return loadaddressbottomshet();
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  );*/
                                }

                              }
                            ),
                            fallback: (context)=>buildButton(
                                context: context, name: "Checkout",buttoncolor: themesecond,Textcolor:Colors.white)),

                      ],
                    ),
                  ),
                );
              }
              else {
                return loadScreen();
              }
            },
          ),
        ),
      ],
    );
  }
}




