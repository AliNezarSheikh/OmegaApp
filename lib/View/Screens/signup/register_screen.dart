import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/logincontroller.dart';

import '../home_screen.dart';
import 'login_screen.dart';

class registerscreen extends StatelessWidget {
  TextEditingController emailFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController passwordFieldController2 = TextEditingController();

  logincontroller controller = Get.put(logincontroller());

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: getwidth(context),
          height: getheight(context),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: width! * 0.04,
                  top: height! * 0.1,
                  right: width! * 0.04,
                ),
                child: Column(
                  children: [
                    PrimaryText(
                      words: "Register to join us",
                    ),
                    SizedBox(height: 10),
                    SecondlyText(
                      words: "Welcome back! Please enter your details.",
                    ),
                    SizedBox(height: 64),
                    textinput(
                        controller: emailFieldController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Email Must Not Be Empty";
                          } else {
                            return null;
                          }
                        },
                        hint: "Email",
                        obscure: false,
                        type: TextInputType.emailAddress),
                    SizedBox(height: 24),
                    textinput(
                      type: TextInputType.visiblePassword,
                      validator: (String? value) {
                        if (value!.length < 6) {
                          return "Password is Short";
                        } else {
                          return null;
                        }
                      },
                      obscure: controller.notvisable.value,
                      hint: "Create Password",
                      controller: passwordFieldController,
                    ),
                    SizedBox(height: 24),
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
                    SizedBox(height: 24),
                    buildAgreeRow(
                      controller.agree.value,
                      (val) {
                        controller.getagree(val: val);
                      },
                    ),
                  controller.showError.value
                      ? Text(
                    'Please agree to the terms and conditions',
                    style: TextStyle(color: Colors.red),
                  )
                      : SizedBox(),
                    SizedBox(height: 15),
                    ConditionalBuilder(
                        condition: controller.isLoading.isFalse,
                        builder: (context) => buildButton(
                            context: context,
                            name: "Register",
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                               controller.submitForm();
                                if (controller.agree.isTrue) {
                                  await controller.registeruser(
                                      email: emailFieldController.text,
                                      password: passwordFieldController.text, context: context);
                                  if(controller.successregister.isTrue){
                                    Get.off(() => loginscreen(),
                                        transition: Transition.leftToRight,
                                        curve: Curves.easeInOut,
                                        duration: Duration(milliseconds: 700));
                                  }

                                }
                              }
                            }),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator())),
                    SizedBox(height: 10),
                    buildDividerRow(context),
                    SizedBox(height: 10),
                    buildIconButton(context, "Continue With Google"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SecondlyText(
                          words: "Have an account? ",
                        ),
                        TextButton(
                          onPressed: () {
                            Get.off(() => loginscreen(),
                                transition: Transition.leftToRight,
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 700));
                          },
                          child: PrimaryText(
                              words: " Login",
                              wight: FontWeight.bold,
                              fontsize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    ConditionalBuilder(
                      condition: dashcontrol.isLoad.isFalse,
                      builder: (BuildContext context) { return buildButton(
                          context: context,
                          name: 'Continue As Guest',
                          Textcolor: fontcolorprimary,
                          onTap: () async {


                            Get.off(()=>homescreen(),
                                transition: Transition.fadeIn,
                                curve: Curves.easeInOut,
                                duration: Duration(seconds: 1));

                          });},
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),

                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
