import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/home_screen.dart';

import '../../../Constant/reusable.dart';
import '../../../Control/logincontroller.dart';

class edituser extends StatelessWidget {

  TextEditingController emailFieldController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  logincontroller controller = Get.put(logincontroller());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    emailFieldController.text = currentuser!.email!;
    firstnameController.text = currentuser!.first_name == null
        ? firstnameController.text
        : currentuser!.first_name!;
    lastnameController.text = currentuser!.last_name == null
        ? lastnameController.text
        : currentuser!.last_name!;
    phoneController.text =
        currentuser!.phone == null ? phoneController.text : currentuser!.phone!;
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
                    controller: emailFieldController,
                    hint: "Email",
                    obscure: false,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Email Must Not Be Empty";
                      } else {
                        return null;
                      }
                    },
                    type: TextInputType.emailAddress,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    lab: "Email",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textinput(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "First Name Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      controller: firstnameController,
                      hint: "First_Name",
                      obscure: false,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      lab: "First Name",
                      type: TextInputType.text),
                  SizedBox(
                    height: 20,
                  ),
                  textinput(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Last Name Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      controller: lastnameController,
                      hint: "Last Name",
                      obscure: false,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      lab: "Last Name",
                      type: TextInputType.text),
                  SizedBox(
                    height: 20,
                  ),
                  textinput(
                    type: TextInputType.phone,
                    obscure: false,
                    hint: "New phone",
                    controller: phoneController,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    lab: "Phone",
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Phone Must Not Be Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
              Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 32.0),
                    child: PrimaryText(words: "Gender",wight: FontWeight.w300)
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Container(
                    width: width!*0.3,
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

                      value: controller.dropdownValue.value,
                     // hint: currentuser?.gender==null?Text("choose"):Text('${currentuser!.gender}'),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style:  TextStyle(color: fontcolorprimary),

                      onChanged: (String? value) {
                        controller.dropdownValue=value!.obs;

                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),



                  SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                      condition: controller.isLoading.isFalse,
                      builder: (context) => buildButton(
                          context: context,
                          name: "Update",
                          onTap: () async {
                            print(controller.dropdownValue.value);
                            if (formKey.currentState!.validate()) {
                              await controller.updateuser(
                                  email: emailFieldController.text,
                                  phone: phoneController.text,
                                  firstname: firstnameController.text,
                                  lastname: lastnameController.text,
                                  context: context,
                                  token: token,gender:controller.dropdownValue.value.toString() );

                              if (controller.successupdate.isTrue) {
                                Get.off(() => homescreen(),
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
