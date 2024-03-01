import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:omega/Model/adressmodel.dart';
import 'package:omega/Model/usermodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constant/Components.dart';
import '../Constant/reusable.dart';
import '../View/Screens/signup/login_screen.dart';

class logincontroller extends GetxController {
  RxBool notvisable = true.obs;
  RxBool rememberMe = false.obs;
  RxBool agree = true.obs;
  RxBool showError = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingaddress = false.obs;
  RxBool successregister = false.obs;
  RxBool successaddress = false.obs;
  RxBool successlogin = false.obs;
  RxBool successupdate = false.obs;
  RxString dropdownValue = list.first.obs;
  RxString dropdownValueemarite = emarites.first.obs;
  @override

  void getvisiblepassword() {
    notvisable.value = !notvisable.value;
  }

  void getremember({bool? val}) {
    rememberMe.value = val!;
  }

  void getagree({bool? val}) {
    agree.value = val!;
    showError.value = false;
  }

  void submitForm() {
    if (agree.value) {
      showError.value = false;
    } else {
      showError.value = true;
    }
  }

  Future<void> registeruser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    Uri url = Uri.parse("$baseurl/customer/register");

    int randomNumber = await generateRandomNumber(100000, 999999);
    //print(randomNumber);
    await http.post(
      url,
      headers: {
        "Accept": "application/json",
        // "Content-Type":"application/json",
      },
      body: {
        "first_name": "user",
        "last_name": randomNumber.toString(),
        "email": email,
        "password": password,
        "password_confirmation": password,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        isLoading.value = false;
        showresult(context, Colors.green, "Email has been Created Successfuly");
        successregister.value = true;
      } else {
        isLoading.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      isLoading.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }

  Future<void> loginuser({
    required String? email,
    required String password,
    required BuildContext context,
    required bool isremember,
  }) async {
    isLoading.value = true;

    Uri url = Uri.parse("$baseurl/customer/login?accept_token=true");
    await http.post(url, headers: {
      "Accept": "application/json",
    }, body: {
      "email": email,
      "password": password,
      "device_name": devicename,
    }).then((value) async {
      if (value.statusCode == 200) {

        Map<String, dynamic> result = jsonDecode(value.body);
        token = result["token"];
        currentuser = usermodel.fromJson(result);
        await dashcontrol.getcart(token: token!, context: context);
        await dashcontrol.getproductbycategory(id:1);
        if (isremember == true) {
          remeber.write("token", token);
        }
        successlogin.value = true;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
        Get.off(loginscreen());
        successlogin.value = false;
      }
    }).catchError((error) {
      isLoading.value = false;
      showresult(context, Colors.red, error.toString());
      successlogin.value = false;
    });
  }

  /*Future<void> getuser(
      {required String token, required BuildContext context}) async {
    isLoading.value = true;
    Uri url = Uri.parse("$baseurl/api/v2/storefront/account");
    await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }).then((value) {
      if (value.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(value.body);
        currentuser = usermodel.fromJson(result);
        successlogin.value = true;
      } else {
        isLoading.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["error"]);
        Get.off(loginscreen());
      }
    }).catchError((error) {
      isLoading.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }*/
  Future<void> logout({
    required String token,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () async {
      await remeber.remove("token");
      currentuser=null;
      homecontrol.currentindex = 0.obs;
    });
    isLoading.value = false;
    Get.off(loginscreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeOut,
        duration: Duration(seconds: 1));

   /* Uri url = Uri.parse("$baseurl/customer/logout");
    await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((value) {
      if (value.statusCode == 200) {
        isLoading.value = false;
        remeber.remove("token");
        currentuser=null;
        homecontrol.currentindex = 0.obs;
        Get.off(loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeOut,
            duration: Duration(seconds: 1));
      } else {
        isLoading.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["error"]);
        remeber.remove("token");
        currentuser=null;
        homecontrol.currentindex = 0.obs;
        Get.off(loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeOut,
            duration: Duration(seconds: 1));
      }
    }).catchError((error) {
      isLoading.value = false;
      showresult(context, Colors.red, error.toString());
    });*/
  }
  Future<void> openWhatsApp({required BuildContext context}) async {
    Uri url = Uri.parse("https://wa.me/+971501646033");
    if (!await launchUrl(url)) {
     showresult(context, Colors.red, "Could not launch Whatsapp");
    }
  }
  Future<void> openEmail({required BuildContext context}) async {
    Uri url = Uri.parse("mailto:alinsheikh2020@gmail.com?subject=Problem&body=Need Help:");
    if (!await launchUrl(url)) {
      showresult(context, Colors.red, "Could not launch Email");
    }
  }
  Future<void> openphone({required BuildContext context}) async {
    Uri url = Uri.parse("tel:+971-54-376-6177");
    if (!await launchUrl(url)) {
      showresult(context, Colors.red, "Could not launch Phone");
    }
  }
  Future<void> updateuser({
    required String email,
    required String token,
    required String? firstname,
    required String? lastname,
    required String? phone,
    required String? gender,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    Uri url = Uri.parse("$baseurl/customer/profile");

    await http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "email": email,
      "first_name": firstname,
      "last_name": lastname,
      "gender": gender,
      "phone": phone,
    }).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(value.body);
        print(result);
        currentuser = usermodel.fromJson(result);

        showresult(context, Colors.green, "Info has been updated Successfuly");
        successupdate.value = true;
      } else if (value.statusCode == 401) {
        isLoading.value = false;
        successupdate.value = false;
        showresult(context, Colors.red, "You need to login");
        Get.off(loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeOut,
            duration: Duration(seconds: 3));
      } else {
        isLoading.value = false;
        successupdate.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      isLoading.value = false;
      successupdate.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }

  Future<void> changepassword({
    required String? password,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    Uri url = Uri.parse("$baseurl/customer/profile");

    await http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "email": currentuser!.email,
      "first_name": currentuser!.first_name,
      "last_name": currentuser!.last_name,
      "gender": currentuser!.gender == null ? "undefined" : currentuser!.gender,
      "phone": currentuser!.phone == null ? "00000" : currentuser!.phone,
      "password": password,
      "password_confirmation": password,
    }).then((value) {
      if (value.statusCode == 200) {
        isLoading.value = false;
        var result = jsonDecode(value.body);
        currentuser = usermodel.fromJson(result);
        showresult(context, Colors.green, "Info has been updated Successfuly");
        successupdate.value = true;
      } else if (value.statusCode == 401) {
        isLoading.value = false;
        successupdate.value = false;
        showresult(context, Colors.red, "You need to login");
        Get.off(loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeOut,
            duration: Duration(seconds: 3));
      } else {
        isLoading.value = false;
        successupdate.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      isLoading.value = false;
      successupdate.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }

  Future<void> addnewadress({
    required String phoneaddress,
    required String postcode,
    required String state_name,
    required String address1,
    required String first_name,
    required String last_name,
    required String city,
    required String country,
    required BuildContext context,
    required String token,
  }) async {
    isLoading.value = true;
    Uri url = Uri.parse("$baseurl/customer/addresses");
    List<String> listadd = [address1];
    Map<String, dynamic> requestbody = {
      "phone": phoneaddress,
      "state": state_name,
      "address1": listadd,
      "city": city,
      "first_name": first_name,
      "last_name": last_name,
      "postcode": postcode,
      "country": country,
    };
    await http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestbody),
    )
        .then((value) {
      if (value.statusCode == 200) {
        isLoading.value = false;
        showresult(
            context, Colors.green, "Adress has been Created Successfuly");
        successaddress.value = true;
      } else if (value.statusCode == 401) {
        isLoading.value = false;
        successaddress.value = false;
        showresult(context, Colors.red, "You need to login");
        Get.off(loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeOut,
            duration: Duration(seconds: 3));
      } else {
        isLoading.value = false;
        successaddress.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      isLoading.value = false;
      successaddress.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }

  Future<void> getadress(
      {required String token, }) async {
    isLoadingaddress.value = true;
    listadress = [];
    Uri url = Uri.parse("$baseurl/customer/addresses");
    await http.get(url, headers: {
      'Authorization': 'Bearer $token',

    }).then((value) {

      if (value.statusCode == 200) {
        isLoadingaddress.value = false;
        var result = jsonDecode(value.body);
       result["data"].forEach((element) {
          listadress.add(addressmodel.fromJson(element));
        });
      } else if (value.statusCode == 401){
        isLoadingaddress.value = false;
       // showresult(context, Colors.red, "You need to login");
        Get.off(loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeOut,
            duration: Duration(seconds: 3));
      }else {
        isLoadingaddress.value = false;
        //showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      isLoadingaddress.value = false;
      //showresult(context, Colors.red, error.toString());
      print(error.toString());
    });
  }
  Future<void> deleteaddress({required int id,required BuildContext context})async{
    isLoadingaddress.value = true;
    Uri url = Uri.parse("$baseurl/customer/addresses/${id}");
    await http.delete(url,headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((value) async {
      if(value.statusCode==200){
        await getadress(token: token!,);
        showresult(context, Colors.green, "Adress deleted Success");
      }else  if(value.statusCode==401){
        isLoadingaddress.value = false;
        showresult(context, Colors.red, "You need to login");
        Get.off(loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeOut,
            duration: Duration(seconds: 3));
      }
    }).catchError((error){
      isLoadingaddress.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }
  Future<void> addressupdate({
    required int id,
    required String phoneaddress,
    required String postcode,
    required String state_name,
    required String address1,
    required String first_name,
    required String last_name,
    required String city,
    required String country,
    required BuildContext context,
    required String token,
  }) async {
    isLoadingaddress.value = true;
    Uri url = Uri.parse("$baseurl/customer/addresses/${id}");
    List<String> listadd = [address1];
    Map<String, dynamic> requestbody = {
      "phone": phoneaddress,
      "state": state_name,
      "address1": listadd,
      "city": city,
      "first_name": first_name,
      "last_name": last_name,
      "postcode": postcode,
      "country": country,
    };
    await http
        .put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestbody),
    )
        .then((value) {
      if (value.statusCode == 200) {
        isLoadingaddress.value = false;
        showresult(
            context, Colors.green, "Adress has been Updated Successfuly");
        successaddress.value = true;
      } else if (value.statusCode == 401) {
        isLoadingaddress.value = false;
        successaddress.value = false;
        showresult(context, Colors.red, "You need to login");
        Get.off(loginscreen(),
            transition: Transition.circularReveal,
            curve: Curves.easeOut,
            duration: Duration(seconds: 3));
      } else {
        isLoadingaddress.value = false;
        successaddress.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      isLoadingaddress.value = false;
      successaddress.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }
  void showMaterialDialog<T>({required BuildContext context, required Widget child})
  {
    showDialog<T>(context: context,
      builder: (BuildContext context)=>child,);
  }



}
