import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Model/adressmodel.dart';
import 'package:omega/View/Screens/address/all%20address.dart';
import 'package:omega/View/Screens/home_screen.dart';

import '../../../Constant/Components.dart';
import '../../../Constant/reusable.dart';
import '../../../Control/logincontroller.dart';

class updateaddress extends StatelessWidget {
addressmodel model;
updateaddress({required this.model});

TextEditingController adressController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController firstname = TextEditingController();
TextEditingController lastname = TextEditingController();
TextEditingController postalcode = TextEditingController();
TextEditingController country = TextEditingController();


logincontroller controller = Get.put(logincontroller());
GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    adressController.text=model.address1!;
    cityController.text=model.city!;
    country.text=model.country!;
    stateController.text=model.state!;
    phoneController.text=model.phoneaddress!;
    firstname.text=model.firstname!;
    lastname.text=model.lastname!;
    postalcode.text=model.postcode!;
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      lab: "First Name",
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      lab: "Last Name",
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      lab: "Adress",
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      lab: "Phone",
                      type: TextInputType.number),
                  SizedBox(height: 20,),
                  textinput(
                      controller: country,
                      hint: "Country",
                      obscure: false,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Country Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      lab: "Country",
                      type: TextInputType.text),
                  SizedBox(height: 20,),
                  textinput(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "City Must Not Be Empty ";
                      } else {
                        return null;
                      }
                    },
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    lab: "City",
                    type: TextInputType.text,
                    obscure: false,
                    hint: "City",
                    controller: cityController,
                  ),
                  SizedBox(height: 20,),
                  textinput(
                    type: TextInputType.text,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    lab: "State",
                    obscure: false,
                    hint: "State",
                    controller: stateController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "State Must Not Be Empty ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  textinput(
                      controller: postalcode,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      lab: "Postal Code",
                      hint: "Postal Code",
                      obscure: false,
                      validator: (String? value) {
                        if (value!.length<5) {
                          return "Postal Code Must Not Be 5 Numbers";
                        } else {
                          return null;
                        }
                      },
                      type: TextInputType.number),
                  SizedBox(height: 20,),
                  ConditionalBuilder(
                      condition: controller.isLoading.isFalse,
                      builder: (context) => buildButton(
                          context: context,
                          name: "Update",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await controller.addressupdate(
                                id: model.id!,
                                  address1: adressController.text,
                                  city: cityController.text,
                                  phoneaddress: phoneController.text,
                                  state_name: stateController.text,
                                  context: context, token: token, postcode: postalcode.text, first_name: firstname.text, last_name: lastname.text, country: country.text);
                              if(controller.successaddress.isTrue){
                                Get.off(() => homescreen(),
                                    transition: Transition.rightToLeft,
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
