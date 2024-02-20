import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/logincontroller.dart';
import 'package:omega/View/Screens/signup/register_screen.dart';

import '../home_screen.dart';



class loginscreen extends StatelessWidget {
  TextEditingController emailFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();

  logincontroller controller = Get.put(logincontroller());

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
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
                        words: "Welcome Back",
                      ),
                      SizedBox(height: 10),
                      SecondlyText(
                        words: "Welcome back! Please enter your details.",
                      ),
                      SizedBox(height: 64),
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
                      SizedBox(height: 24),
                      textinput(
                        type: TextInputType.visiblePassword,
                        obscure: controller.notvisable.value,
                        hint: "Password",
                        validator: (String? value) {
                          if (value!.length < 6) {
                            return "Password is Short";
                          } else {
                            return null;
                          }
                        },
                        controller: passwordFieldController,
                        eyeicon: IconButton(
                          onPressed: () {
                            controller.getvisiblepassword();
                          },
                          icon: Icon(controller.notvisable.isTrue
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                      SizedBox(height: 24),
                      buildRememberMeRow(controller.rememberMe.value, (val) {
                        controller.getremember(val: val);
                      }),
                      SizedBox(height: 15),
                      ConditionalBuilder(
                          condition: controller.isLoading.isFalse,
                          builder: (context) => buildButton(
                              context: context,
                              name: "Login",
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                //  await dashcontrol.getcategories();
                                  await controller.loginuser(
                                      email: emailFieldController.text,
                                      password: passwordFieldController.text, context: context,
                                  isremember: controller.rememberMe.value);

                                  if(controller.successlogin.isTrue){
                                    controller.successlogin.value=false;
                                    if(controller.rememberMe.isTrue){
                                      remeber.write("token", token);
                                      print(remeber.read("token", ));
                                    }
                                    Get.off(homescreen(),
                                        transition: Transition.circularReveal,
                                        curve: Curves.easeInOut,
                                        duration: Duration(seconds: 3));
                                  }

                                }
                              }),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator())),
                      SizedBox(height: 10),
                      buildDividerRow(context),
                      SizedBox(height: 10),
                      buildIconButton(context, "Continue With Google"),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SecondlyText(
                            words: "Don’t have an account? ",
                          ),
                          TextButton(
                              onPressed: () {
                                Get.off(() => registerscreen(),
                                    transition: Transition.rightToLeft,
                                    curve: Curves.easeInOut,
                                    duration: Duration(seconds: 2));
                              },
                              child: PrimaryText(
                                  words: " Register",
                                  wight: FontWeight.bold,
                                  fontsize: 16)),
                        ],
                      ),
                      SizedBox(height: 5),
                      buildButton(
                          context: context,
                          name: 'Continue As Guest',
                          Textcolor: fontcolorprimary,
                      onTap: (){
                        Get.off(homescreen(),
                            transition: Transition.circularReveal,
                            curve: Curves.easeInOut,
                            duration: Duration(seconds: 3));
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
