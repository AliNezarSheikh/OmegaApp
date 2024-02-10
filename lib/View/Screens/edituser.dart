import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/View/Screens/home_screen.dart';

import '../../Constant/reusable.dart';
import '../../Control/logincontroller.dart';

class edituser extends StatelessWidget {
  TextEditingController emailFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController passwordFieldController2 = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  logincontroller controller = Get.put(logincontroller());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    emailFieldController.text=currentuser!.email!;
    firstnameController.text=currentuser!.first_name==null? firstnameController.text: currentuser!.first_name!;
    lastnameController.text=currentuser!.last_name==null? lastnameController.text: currentuser!.last_name!;
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
                    type: TextInputType.emailAddress),
                SizedBox(height: 20,),
                textinput(
                    controller: firstnameController,
                    hint: "First_Name",
                    obscure: false,

                    type: TextInputType.text),
                SizedBox(height: 20,),
                textinput(
                    controller: lastnameController,
                    hint: "Last Name",
                    obscure: false,

                    type: TextInputType.text),
                SizedBox(height: 20,),
                textinput(
                  type: TextInputType.visiblePassword,
                  obscure: controller.notvisable.value,
                  hint: "New Password",
                  controller: passwordFieldController,
                ),
                SizedBox(height: 20,),
                textinput(
                  type: TextInputType.visiblePassword,
                  obscure: controller.notvisable.value,
                  hint: "Confirm Password",
                  controller: passwordFieldController2,
                  validator: (String? value) {
                    if (value! != passwordFieldController.text) {
                      return "Password does not Match";
                    } else {
                      return null;
                    }
                  },
                  eyeicon: IconButton(
                    onPressed: () {
                      controller.getvisiblepassword();
                    },
                    icon: Icon(controller.notvisable == true
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                  ),
                ),
                SizedBox(height: 20,),
                ConditionalBuilder(
                    condition: controller.isLoading.isFalse,
                    builder: (context) => buildButton(
                        context: context,
                        name: "Update",
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                              await controller.updateuser(
                                  email: emailFieldController.text,
                                  password: passwordFieldController.text,
                                  firstname: firstnameController.text,
                                  lastname: lastnameController.text,
                                  context: context, token: token);
                              if(controller.successupdate.isTrue){
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
    );
  }
}
