import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/address/all%20address.dart';

import '../../../Constant/reusable.dart';
import '../../../Control/logincontroller.dart';

class addadress extends StatelessWidget {
  TextEditingController adressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  //TextEditingController postalcode = TextEditingController();
 // TextEditingController country = TextEditingController();


  logincontroller controller = Get.put(logincontroller());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Obx(
      ()=> Scaffold(
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  textinput(
                      controller: firstname,
                      hint: "First Name",
                      obscure: false,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "First Name Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      type: TextInputType.text),
                  SizedBox(height: 20,),
                  textinput(
                      controller: lastname,
                      hint: "Last Name",
                      obscure: false,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Last Name Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      type: TextInputType.text),
                  SizedBox(height: 20,),

                  textinput(
                      controller: adressController,
                      hint: "Adress",
                      obscure: false,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Adress Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      type: TextInputType.text),
                  SizedBox(height: 20,),
                  textinput(
                      controller: phoneController,
                      hint: "Phone",
                      obscure: false,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Phone Must Not Be Empty ";
                        } else {
                          return null;
                        }
                      },
                      type: TextInputType.number),

                  SizedBox(height: 20,),
                  textinput(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "City Must Not Be Empty ";
                      } else {
                        return null;
                      }
                    },
                    type: TextInputType.text,
                    obscure: false,
                    hint: "City",
                    controller: cityController,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 32.0),
                          child: SecondlyText(words: "Emarite")
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: width!*0.4,
                        height: 53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: fontcolorprimary,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border:InputBorder.none
                          ),

                          borderRadius:  BorderRadius.circular(20.0),
                          padding: EdgeInsets.only(
                            left: 10.0,
                          ),

                          value: controller.dropdownValueemarite.value,

                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style:  TextStyle(color: fontcolorprimary),

                          onChanged: (String? value) {
                            controller.dropdownValueemarite=value!.obs;

                          },
                          items: emarites.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 20,),
                  ConditionalBuilder(
                      condition: controller.isLoading.isFalse,
                      builder: (context) => buildButton(
                          context: context,
                          name: "Add",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await controller.addnewadress(
                                  address1: adressController.text,
                                  city: cityController.text,
                                  phoneaddress: phoneController.text,
                                  state_name: controller.dropdownValueemarite.value.toString(),
                                  context: context, token: token!, postcode: "00000", first_name: firstname.text, last_name: lastname.text, country: "UAE");
                              if(controller.successaddress.isTrue){
                                Get.off(() => alladdress(),
                                    transition: Transition.leftToRight,
                                    curve: Curves.easeInOut,
                                    duration: Duration(seconds: 2));
                              }


                            }
                          }),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator())),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
