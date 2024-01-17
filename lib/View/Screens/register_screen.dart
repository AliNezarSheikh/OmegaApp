import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/logincontroller.dart';
import 'package:omega/View/Screens/login_screen.dart';

class registerscreen extends StatelessWidget {
  TextEditingController emailFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController passwordFieldController2 = TextEditingController();

  logincontroller controller = logincontroller();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      words: "Register to join us",
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
                        type: TextInputType.emailAddress),
                    SizedBox(height: 24),
                    GetBuilder<logincontroller>(
                      init: logincontroller(),
                      builder: (controller) => textinput(
                        type: TextInputType.visiblePassword,
                        obscure: controller.notvisable,
                        hint: "Create Password",
                        controller: passwordFieldController,
                       /* eyeicon: IconButton(
                          onPressed: () {
                            controller.getvisiblepassword();
                          },
                          icon: Icon(controller.notvisable == true
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ),*/
                      ),
                    ),
                    SizedBox(height: 24),
                    GetBuilder<logincontroller>(
                      init: logincontroller(),
                      builder: (controller) => textinput(
                        type: TextInputType.visiblePassword,
                        obscure: controller.notvisable,
                        hint: "Confirm Password",
                        controller: passwordFieldController2,
                        eyeicon: IconButton(
                          onPressed: () {
                            controller.getvisiblepassword();
                          },
                          icon: Icon(controller.notvisable == true
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    GetBuilder<logincontroller>(
                      init: logincontroller(),
                      builder: (controller) => buildAgreeRow(),
                    ),
                    SizedBox(height: 15),
                    buildLoginButton(context: context, name: "Register"),
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
                          onPressed: (){
                            Get.off(()=> loginscreen(),transition: Transition.leftToRight,curve: Curves.easeInOut,duration: Duration(seconds: 2));
                          },
                          child: PrimaryText(
                              words: " Login",
                              wight: FontWeight.bold,
                              fontsize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    buildLoginButton(
                        context: context,
                        name: 'Continue As Guest',
                        Textcolor: fontcolorprimary),
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
