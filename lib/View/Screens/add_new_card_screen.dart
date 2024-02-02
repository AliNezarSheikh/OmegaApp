import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../Constant/Components.dart';
import '../../Constant/reusable.dart';

class addcardscreen extends StatelessWidget {
  TextEditingController cardnumbercontrol = TextEditingController();
  TextEditingController expdate = TextEditingController();
  TextEditingController cvscontrol = TextEditingController();
  TextEditingController namecontrol = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final RxString displaycardnumber = ''.obs;
    final RxString displayname = ''.obs;
    final RxString displaydate = ''.obs;


    cardnumbercontrol.addListener(() {
      displaycardnumber.value = cardnumbercontrol.text;

    });
    namecontrol.addListener(() {

      displayname.value=namecontrol.text;
    });
    expdate.addListener(() {
      displaydate.value=expdate.text;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6),
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
        title: PrimaryText(words: "Add New Card", fontsize: 20),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: width!,
        height: height!,
        color: Color(0xFFF6F6F6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      height: width! * 0.6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/Card.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/images/img_logo.svg",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          height: height! * 0.035,
                        ),
                        Obx(
                          () => PrimaryText(
                              words: "${displaycardnumber.value}",
                              color: Colors.white,
                              fontfami: "Plus Jakarta Sans",
                              wight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: height! * 0.07,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                SecondlyText(
                                    words: "Cashholder name",
                                    fontfami: "Plus Jakarta Sans",
                                    wight: FontWeight.w400),
                                SizedBox(
                                  height: height! * 0.01,
                                ),
                                Obx(() => SecondlyText(
                                    words: "${displayname.value}",
                                    fontfami: "Plus Jakarta Sans",
                                    wight: FontWeight.w500,
                                    color: Colors.white), ),

                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                SecondlyText(
                                    words: "Exp Date",
                                    fontfami: "Plus Jakarta Sans",
                                    wight: FontWeight.w400),
                                SizedBox(
                                  height: height! * 0.01,
                                ),
                                Obx(() =>  SecondlyText(
                                    words: "${displaydate.value}",
                                    fontfami: "Plus Jakarta Sans",
                                    wight: FontWeight.w500,
                                    color: Colors.white),)

                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: width! * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:12.0),
                          child: SecondlyText(words: "Card Number"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: height! * 0.06,
                          child: textinput2(
                            controller: cardnumbercontrol,

                            hint: "",
                            obscure: false,
                            type: TextInputType.number,
                            inputformat: [
                              SpacingTextInputFormatter(),
                            ]
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 14.0,top: 8.0),
                                      child: SecondlyText(words: "Expiry Date"),
                                    ),
                                    Container(
                                      width: width! * 0.4,
                                      height: height! * 0.05,
                                      child: textinput2(
                                          controller: expdate,
                                          hint: "",
                                          obscure: false,
                                          type: TextInputType.datetime,
                                        ontap:(){
                                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate:  DateTime(1900), lastDate: DateTime.parse('3000-01-01'),)
                                              .then((value) {
                                            expdate.text=DateFormat('MM/yy').format(value!);
                                          });
                                        },

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 14.0,top: 8.0),
                                      child: SecondlyText(words: "CVC/CVV"),
                                    ),
                                    Container(
                                      width: width! * 0.4,
                                      height: height! * 0.05,
                                      child: textinput2(
                                          controller: cvscontrol,

                                          hint: "",
                                          obscure: true,
                                          type: TextInputType.number,
                                      obscuretype: "*"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 12),
                          child: SecondlyText(words: "Cardholder Name"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: height! * 0.06,
                          child: textinput2(
                            controller: namecontrol,
                            hint: "",
                            obscure: false,
                            type: TextInputType.text,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height!*0.1,),
              buildButton(context: context,name: "Add New Card",),
            ],
          ),
        ),
      ),
    );
  }
}
