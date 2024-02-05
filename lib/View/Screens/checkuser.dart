import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/View/Screens/edituser.dart';

import '../../Constant/Components.dart';
import '../../Control/logincontroller.dart';

class checkuser extends StatelessWidget {
  TextEditingController passwordFieldController = TextEditingController();

  logincontroller controller = Get.put(logincontroller());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: height!,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(words: "For Security Propose"),
                    SizedBox(
                      height: 10.0,
                    ),
                    SecondlyText(words: "Input Your Password"),
                    SizedBox(
                      height: 10.0,
                    ),
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
                    SizedBox(
                      height: 10.0,
                    ),
                    ConditionalBuilder(
                        condition: controller.isLoading.isFalse,
                        builder: (context) => buildButton(
                            context: context,
                            name: "Continue",
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await controller.loginuser(
                                    email: currentuser!.email,
                                    password: passwordFieldController.text,
                                    context: context,
                                isremember: controller.rememberMe.value);
                                if (controller.successlogin.isTrue) {
                                  passwordFieldController.clear();
                                  Get.to(edituser(),
                                      transition: Transition.fadeIn,
                                      curve: Curves.easeInOut,
                                      duration: Duration(milliseconds: 700));
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
      ),
    );
  }
}
