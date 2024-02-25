import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:omega/Model/categorymodel.dart';
import 'package:omega/Model/productmodel.dart';

import '../Constant/Components.dart';
import '../Constant/reusable.dart';

class dashcontroller extends GetxController {
  RxInt selectedlistindex = 0.obs;
  Rx<Color> selectedlistcolor = fontcolorprimary.obs;
  RxBool isLoad = false.obs;
  RxBool loadadd = false.obs;
  RxList<productmodel> listwishs = <productmodel>[].obs;

  void changenlistindex(int index) {
    selectedlistindex.value = index;
    selectedlistcolor.value = fontcolorprimary;
  }

  Future<void> getcategories() async {
    Uri url = Uri.parse("$baseurl/categories?sort=id&order=asc");
    listcategories = [];
    await http.get(url, headers: {
      "Accept": "application/json",
    }).then((value) async {
      if (value.statusCode == 200) {
        var categories = jsonDecode(value.body);

        categories["data"].forEach((element) {
          listcategories.add(categorymodel.fromJson(element));
        });
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> getallproducts() async {
    isLoad.value = true;
    Uri url = Uri.parse("$baseurl/products");
    listproducts = [];
    await http.get(url, headers: {
      "Accept": "application/json",
    }).then((value) {
      if (value.statusCode == 200) {
        var products = jsonDecode(value.body);

        products["data"].forEach((element) {
          listproducts.add(productmodel.fromJson(element));
        });
        isLoad.value = false;
      }
    }).catchError((error) {
      print(error.toString());
      isLoad.value = false;
    });
  }

  Future<void> getproductbycategory({required int id}) async {
    listproducts = [];
    isLoad.value = true;
    Uri url = Uri.parse("$baseurl/products?category_id=$id");
    if (id == 1) {
      await getallproducts();
    } else {
      await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      }).then((value) {
        if (value.statusCode == 200) {
          var products = jsonDecode(value.body);
          products["data"].forEach((element) {
            listproducts.add(productmodel.fromJson(element));
          });

          isLoad.value = false;
        }
      }).catchError((error) {
        print(error.toString());
        isLoad.value = false;
      });
    }
  }
  Future<void> addorremovefromwish(
      {required int productid,
        required String token,
        required BuildContext context}) async {

    Uri url = Uri.parse("$baseurl/customer/wishlist/${productid}");
    await http.post(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }
    ).then((value) async {
      if (value.statusCode == 200) {
        await getwishlist();
        showresult(context, Colors.green, jsonDecode(value.body)["message"]);
      } else if (value.statusCode == 401) {
        loadadd.value = false;
        showresult(context, Colors.red, "You need to Login");
      } else {
        loadadd.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      loadadd.value = false;

      showresult(context, Colors.red, error.toString());
    });
  }

  Future<void> getwishlist() async {
    isLoad.value = true;
    Uri url = Uri.parse("$baseurl/customer/wishlist");
    listwishs.value = [];
    await http.get(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }).then((value) {
      if (value.statusCode == 200) {
        var wishproduct = jsonDecode(value.body);
        wishproduct["data"].forEach((element) {
          listwishs.add(productmodel.fromJson(element["product"]));
        });
        isLoad.value = false;
      }
    }).catchError((error) {
      print(error.toString());
      isLoad.value = false;
    });
  }

  Future<void> addtocart(
      {required int productid,
      required String token,
      required BuildContext context}) async {
    loadadd.value = true;
    Uri url = Uri.parse("$baseurl/customer/cart/add/${productid}");
    await http.post(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      "product_id": "${productid}",
      "quantity": "1",
      "is_buy_now": "false",
    }).then((value) {
      if (value.statusCode == 200) {
        loadadd.value = false;
        showresult(context, Colors.green, jsonDecode(value.body)["message"]);
      } else if (value.statusCode == 401) {
        loadadd.value = false;

        showresult(context, Colors.red, "You need to Login");
      } else {
        loadadd.value = false;

        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      loadadd.value = false;

      showresult(context, Colors.red, error.toString());
    });
  }
}
