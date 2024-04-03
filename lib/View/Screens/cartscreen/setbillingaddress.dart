import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/View/Screens/cartscreen/setshippingaddress.dart';

import '../../../Constant/Components.dart';
import '../../../Constant/reusable.dart';
import '../../../Control/logincontroller.dart';
import '../address/addadress.dart';
import 'payment_screen.dart';
class setbilling extends StatelessWidget {
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
        title: PrimaryText(words: "Set Billing Address"),
      ),
      body: FutureBuilder(
        future: controller.getadress(
          token: token!,
        ),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return controller.isLoadingaddress.isFalse
                ? Obx(
                  () => ConditionalBuilder(
                condition: controller.isLoadingaddress.isFalse,
                    builder: (context) => Stack(
                      children: [
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
                                                child: adresslistbilling(listadress[index], controller,context,)),
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
                          child: Container(

                            width: width!,
                            height: height!*0.20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                ()=> Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                                  child: buildsavesameadress(
                                        controller.setsameadress.value,
                                            (val){
                                      controller.getsameadress(val: val);
                                    }),
                                ),
                                ),

                                Row(
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
                                          condition: dashcontrol.isLoadingaddress.isFalse,
                                          builder: (BuildContext context) {
                                            return  buildsmallButton(
                                                context: context,
                                                name: "Save",
                                                Textcolor:  Colors.white,
                                                buttoncolor:fontcolorprimary,
                                                onTap: () async {
                                                  if(controller.setbillingaddress.value.id != null){
                                                    if(controller.setsameadress.isTrue){
                                                      await dashcontrol.setbillingandshippingaddress(
                                                          idbil: controller.setbillingaddress.value.id!,
                                                          phoneaddressbil: controller.setbillingaddress.value.phoneaddress!,
                                                          state_namebil:  controller.setbillingaddress.value.state!,
                                                          address1bil: controller.setbillingaddress.value.address1!,
                                                          first_namebil:  controller.setbillingaddress.value.firstname!,
                                                          last_namebil:  controller.setbillingaddress.value.lastname!,
                                                          citybil:  controller.setbillingaddress.value.city!,
                                                          emailbil: currentuser!.email!,
                                                          address1shi: controller.setbillingaddress.value.address1!,
                                                          cityshi: controller.setbillingaddress.value.city! ,
                                                          emailshi:  currentuser!.email!,
                                                          first_nameshi: controller.setbillingaddress.value.firstname! ,
                                                          idshi: controller.setbillingaddress.value.id!,
                                                          last_nameshi: controller.setbillingaddress.value.lastname!,
                                                          phoneaddressshi: controller.setbillingaddress.value.phoneaddress!,
                                                          state_nameshi: controller.setbillingaddress.value.state!,
                                                          context: context,
                                                          token: token!);
                                                      if(dashcontrol.successaddress.isTrue){
                                                        showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled: true,
                                                            showDragHandle: true,
                                                            enableDrag: true,
                                                            builder: (BuildContext context){
                                                          return Container(
                                                            height: height! * 0.5,
                                                            child: Stack(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                                                                  child: Align(
                                                                      alignment: Alignment.topCenter,
                                                                      child: PrimaryText(words: "Select Shipping Method", fontsize: 14, wight: FontWeight.w400)),
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
                                                                        listship.length == 0
                                                                            ? Center(
                                                                          child: PrimaryText(
                                                                              words:
                                                                              "No Ship Methods"),
                                                                        )
                                                                            : AnimationLimiter(
                                                                          child: ListView.separated(
                                                                              physics: BouncingScrollPhysics(),
                                                                              shrinkWrap: true,
                                                                              separatorBuilder: (context, index) {
                                                                                return SizedBox(height: 20);
                                                                              },
                                                                              itemCount: listship.length,
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
                                                                                        child: lsitshipmethods(listship[index], controller,context,)),
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
                                                                            name: "Cancel",
                                                                            buttoncolor:fontcolorprimary,
                                                                            Textcolor:  Colors.white,
                                                                            onTap: () {
                                                                             Navigator.pop(context);
                                                                            }),
                                                                      ),
                                                                      Container(
                                                                        width: width! * 0.50,
                                                                        height: width! * 0.2,
                                                                        child: Obx(
                                                                            ()=> ConditionalBuilder(
                                                                            condition: controller.isloadmethod.isFalse,

                                                                            builder: (BuildContext context) {
                                                                              return buildsmallButton(
                                                                                  context: context,
                                                                                  name: "Save",
                                                                                  buttoncolor:fontcolorprimary,
                                                                                  Textcolor:  Colors.white,
                                                                                  onTap: () async {
                                                                                    if(controller.setshipmethod.value !=""){
                                                                                      await controller.setmethodtype(token: token!, context: context, method: controller.setshipmethod.value );
                                                                                      if(controller.successmethod.isTrue){
                                                                                        Get.to(()=>paymentscreen(),
                                                                                            transition: Transition.zoom,
                                                                                            curve: Curves.easeIn,
                                                                                            duration: Duration(seconds: 1)
                                                                                        );
                                                                                      }

                                                                                    }else{
                                                                                      showresult(context, Colors.red, "Select method for Shippment");
                                                                                    }

                                                                                  });
                                                                            },
                                                                              fallback: (BuildContext context){
                                                                              return Center(child: CircularProgressIndicator(),);
                                                                              }
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                            });


                                                      }
                                                    }
                                                    else{

                                                      Get.to(()=>setshipping(),
                                                          transition: Transition.downToUp,
                                                          curve: Curves.easeIn,
                                                          duration: Duration(seconds: 1));
                                                    }

                                                  }
                                                  else{
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
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                fallback: (context) => loadaddress(),
              ),
            )
                : loadaddress();
          } else {
            return loadaddress();
          }
        },
      ),
    );
  }
}
