import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/homecontroller.dart';
import 'package:omega/View/Screens/cartscreen/setbillingaddress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            leadingWidth: 70.0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.shopping_cart_outlined,)
              ),
            ),
            elevation: 0.0,
            title: PrimaryText(words: "Cart",),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  child: Icon(
                    Icons.remove_shopping_cart_outlined
                  ),
                  onTap: () {
                    checkcon.showMaterialDialog(
                      context: context,
                      child: AlertDialog(
                        title: const Text(
                            'Are you sure you want to empty the Cart?'),
                        content: Text(
                          'If you want to Empty the Cart, choose AGREE or cancel the operation',
                        ),
                        actions: <Widget>[
                          InkWell(
                            child: const Text('Cancel'),
                            onTap: () {
                              Navigator.pop(context, ButtonAction.cancel);
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            child: const Text('Agree'),
                            onTap: () async {
                              Navigator.pop(context, ButtonAction.Agree);
                              await dashcon.emptycart(
                                  token: token!, context: context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              FutureBuilder(
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
                            Obx(
                            ()=> AnimationLimiter(
                                child: dashcon.lencart.value == 0
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
                                          final ind=index;
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
                                                      dashcon,
                                                  ind)),
                                            ),
                                          );
                                        },
                                      ),
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
                            Obx(
                  ()=> ConditionalBuilder(
                                  condition:   homecontroller.itemsincart.value>0,
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

                                      }

                                    }
                                  ),
                                  fallback: (context)=>buildButton(
                                      context: context, name: "Checkout",buttoncolor: themesecond,Textcolor:Colors.white)),
                            ),

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
              Obx(
                ()=> Visibility(
                  visible:dashcon.isLoadupdate.value ,
                    child: Container(
                      width: width!,
                      height: height!,
                      color:themesecond.withOpacity(0.3),
                      child: Center(
                        child: SpinKitChasingDots(color:Colors.blue),
                      ),
                ),),
              )
            ],
          ),
        ),
      ],
    );
  }
}




