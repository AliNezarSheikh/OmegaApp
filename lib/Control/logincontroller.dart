import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Constant/Components.dart';

class logincontroller extends GetxController {
  RxBool notvisable = true.obs;
  RxBool rememberMe = false.obs;
  RxBool agree = true.obs;
  RxBool showError = false.obs;
  RxBool isLoading = false.obs;
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
  }) async {
    isLoading.value = true;
    Uri url = Uri.parse("$baseurl/api/v2/storefront/account");
    Map<String, dynamic> requestbody = {
      "email": email,
      "password": password,
      "password_confirmation": password,
    };
    Map<String, dynamic> user = {"user": requestbody};
    await http
        .post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(user),
    )
        .then((value) {
      if (value.statusCode == 200) {
        print(jsonDecode(value.body));
      } else {
        print(jsonDecode(value.body));
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> loginuser({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    Uri url = Uri.parse("$baseurl/spree_oauth/token");

    await http.post(url, body: {
      "username": email,
      "password": password,
      "grant_type": "password",
    }).then((value) async {
      if (value.statusCode == 200) {
        isLoading.value = false;
        Map<String, dynamic> result = jsonDecode(value.body);
        String token = result["access_token"];
        await getuser(token: token);
      } else {
        isLoading.value = false;
        print(jsonDecode(value.body));
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> getuser({
    required String token,

  }) async {
    isLoading.value = true;
    Uri url = Uri.parse("$baseurl/api/v2/storefront/account");

    await http.get(url,headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }).then((value) {
      if (value.statusCode == 200) {
        isLoading.value = false;
        Map<String, dynamic> result = jsonDecode(value.body);
        String id = result["data"]["id"];
        print(id);
      } else {
        print(jsonDecode(value.body));
      }
    }).catchError((error) {
      print(error);
    });
  }
}
