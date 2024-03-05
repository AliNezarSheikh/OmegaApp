import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:omega/Control/homecontroller.dart';
import 'package:omega/Model/cartmodel.dart';
import 'package:omega/Model/categorymodel.dart';
import 'package:omega/Model/productmodel.dart';
import '../Constant/Components.dart';
import '../Constant/reusable.dart';

class dashcontroller extends GetxController {
  RxInt selectedlistindex = 0.obs;
  Rx<Color> selectedlistcolor = fontcolorprimary.obs;
  RxBool isLoad = false.obs;
  RxBool isLoadingaddress = false.obs;

  RxBool successaddress=false.obs;
  RxBool isLoadsearch=false.obs;
  RxBool isLoadremove = false.obs;
  RxBool accept = false.obs;
  RxInt totalItems = 0.obs;
  RxString itemscost = "0".obs;
  RxString shippingfee = "0".obs;
  RxString totalprice = "0".obs;
  RxBool loadadd = false.obs;
  RxBool loadcart = false.obs;
  RxBool isLoadwish = false.obs;
  RxBool isListempty = false.obs;

  RxList<productmodel> listwishs = <productmodel>[].obs;
  RxMap<int, bool> maploadfav = <int, bool>{}.obs;
  RxMap<int, bool> maploadcart = <int, bool>{}.obs;


  @override




  void startLoadingfav(int id) {
    final index = listproducts.indexWhere((item) => item.id == id);
    if (index != -1) {
      listproducts[index].isLoading = true;
      maploadfav[listproducts[index].id!] = listproducts[index].isLoading;
    }
  }

  void stopLoadingfav(int id) {
    final index = listproducts.indexWhere((item) => item.id == id);
    if (index != -1) {
      listproducts[index].isLoading = false;
      maploadfav[listproducts[index].id!] = listproducts[index].isLoading;
    }
  }

  void startLoadingcart(int id) {
    final index = listproducts.indexWhere((item) => item.id == id);
    if (index != -1) {
      listproducts[index].isLoading = true;
      maploadcart[listproducts[index].id!] = listproducts[index].isLoading;
    }
  }

  void stopLoadingcart(int id) {
    final index = listproducts.indexWhere((item) => item.id == id);
    if (index != -1) {
      listproducts[index].isLoading = false;
      maploadcart[listproducts[index].id!] = listproducts[index].isLoading;
    }
  }

  Future<void> increasequantity(int id,{required BuildContext context}) async {
    final index = listcart.indexWhere((item) => item.itemidincart == id);
    if (index != -1) {
      int qty = listcart[index].counter!.value;
      qty++;
      listcart[index].counter!.value = qty;

      await updateitemincart(productidincart: listcart[index].itemidincart!, count: listcart[index].counter!.value, token: token!, context: context,index: index);
      listcart[index].currenttotal!.value= listcart[index].formatted_total!;
      print(listcart[index].formatted_total!);
    }
  }

  Future<void> decreasequantity(int id,{required BuildContext context}) async {
    final index = listcart.indexWhere((item) => item.itemidincart == id);
    if (index != -1) {
      int qty = listcart[index].counter!.value;
      qty--;
      listcart[index].counter!.value = qty;

      await updateitemincart(productidincart: listcart[index].itemidincart!, count: listcart[index].counter!.value, token: token!, context: context,index: index);
      listcart[index].currenttotal!.value= listcart[index].formatted_total!;
    }
  }

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

  bool isInwishList(int id) {
    try {
      listwishs.firstWhere((element) => element.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getallproducts() async {
   // isLoad.value = true;
    Uri url = Uri.parse("$baseurl/products");
    listproducts = [];
    listmiddle = [];
    await http.get(url, headers: {
      "Accept": "application/json",
    }).then((value) {
      if (value.statusCode == 200) {
        var products = jsonDecode(value.body);
        products["data"].forEach((element) {
          listmiddle.add(productmodel.fromJson(element));
        });
      }
     // isLoad.value = false;
    }).catchError((error) {
      print(error.toString());
      isLoad.value = false;
    });
  }

  Future<void> getproductbycategory({required int id,}) async {
    listproducts = [];
    listmiddle = [];
    isLoad.value = true;

    Uri url = Uri.parse("$baseurl/products?category_id=$id");
    if (id == 1) {
      await getallproducts();
      await getwishlist();
      listmiddle.forEach((element) {
        int id = element.id!;
        bool isinwish = isInwishList(id);
        maploadfav.addAll({element.id!: false});
        maploadcart.addAll({element.id!: false});
        listproducts.add(productmodel(
            isLoading: false,
            id: element.id,
            name: element.name,
            formatted_price: element.formatted_price,
            short_description: element.short_description,
            medium_image_url: element.medium_image_url,
            original_image_url: element.original_image_url,
            description: element.description,
            iswishlisted: isinwish));
      });
      isLoad.value = false;
    } else {
      await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      }).then((value) async {
        if (value.statusCode == 200) {
          var products = jsonDecode(value.body);
          products["data"].forEach((element) {
            listmiddle.add(productmodel.fromJson(element));
          });
          await getwishlist();
          listmiddle.forEach((element) {
            int id = element.id!;
            bool isinwish = isInwishList(id);
            maploadfav.addAll({element.id!: false});
            maploadcart.addAll({element.id!: false});
            listproducts.add(productmodel(
                isLoading: false,
                id: element.id,
                name: element.name,
                formatted_price: element.formatted_price,
                short_description: element.short_description,
                medium_image_url: element.medium_image_url,
                original_image_url: element.original_image_url,
                description: element.description,
                iswishlisted: isinwish));
          });
          isLoad.value = false;
        }
      }).catchError((error) {
        print(error.toString());
        isLoad.value = false;
      });
    }
  }

  Future<void> getproductbycategoryforguest({required int id}) async {
    listproducts = [];
    listmiddle = [];
    isLoad.value = true;
    Uri url = Uri.parse("$baseurl/products?category_id=$id");
    if (id == 1) {
      await getallproducts();
      homecontroller.itemsincart.value = 0;
      listmiddle.forEach((element) {
        listproducts.add(element);
      });
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
          homecontroller.itemsincart.value = 0;
          isLoad.value = false;
        }
        isLoad.value = false;
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
    startLoadingfav(productid);
    Uri url = Uri.parse("$baseurl/customer/wishlist/${productid}");
    await http.post(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }).then((value) async {
      if (value.statusCode == 200) {
        await getwishlist();
        accept.value = true;
        showresult(context, Colors.green, jsonDecode(value.body)["message"]);
        stopLoadingfav(productid);
      } else if (value.statusCode == 401) {
        showresult(context, Colors.red, "You need to Login");
        stopLoadingfav(productid);
        accept.value = false;
      } else {
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
        stopLoadingfav(productid);
        accept.value = false;
      }
    }).catchError((error) {
      stopLoadingfav(productid);
      accept.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }

  Future<void> getwishlist() async {
    isLoadwish.value = true;
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
        isLoadwish.value = false;
      } else if (value.statusCode == 401) {
        isLoadwish.value = false;
      } else {
        isLoadwish.value = false;
      }
    }).catchError((error) {
      print(error.toString());
      isLoadwish.value = false;
    });
  }

  Future<void> addtocart(
      {required int productid,
      required String token,
      required BuildContext context}) async {
    startLoadingcart(productid);
    loadadd.value = true;
    Uri url = Uri.parse("$baseurl/customer/cart/add/${productid}");
    await http.post(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      "product_id": "${productid}",
      "quantity": "1",
    }).then((value) {
      if (value.statusCode == 200) {
        stopLoadingcart(productid);
        var cart = jsonDecode(value.body);
        homecontroller.itemsincart.value = cart["data"]["items_count"];
        showresult(context, Colors.green, jsonDecode(value.body)["message"]);
        loadadd.value = false;
      } else if (value.statusCode == 401) {
        stopLoadingcart(productid);
        loadadd.value = false;
        showresult(context, Colors.red, "You need to Login");
      } else {
        stopLoadingcart(productid);
        loadadd.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      stopLoadingcart(productid);
      loadadd.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }

  Future<void> getcart({
    required String token,
    required BuildContext context,
  }) async {
    listcart = [];
    currentcart = null;
    loadcart.value = true;
    Uri url = Uri.parse("$baseurl/customer/cart");
    await http.get(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    }).then((value) {
      if (value.statusCode == 200) {
        loadcart.value = true;
        var cart = jsonDecode(value.body);
        if (cart["data"] != null) {
          currentcart = cartmodel.fromJson(cart["data"]);
          totalItems.value = currentcart!.items_qty!;
          itemscost.value = currentcart!.formatted_grand_total!;
          shippingfee.value = currentcart!.formatted_tax_total!;
          totalprice.value = currentcart!.formatted_sub_total!;
          homecontroller.itemsincart.value = cart["data"]["items_count"];
          currentcart!.items!.forEach((element) {
            listcart.add(itemincart.fromJson(element));
          });
        } else {
          homecontroller.itemsincart.value = 0;
        }

        loadcart.value = false;
      } else if (value.statusCode == 401) {
        loadadd.value = false;
        showresult(context, Colors.red, "You need to Login");
      } else {
        loadadd.value = false;

        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      loadadd.value = false;
        print(error);
      showresult(context, Colors.red, error.toString());
    });
  }

  Future<void> removeitemfromcart(
      {required int productidincart,
      required String token,
      required BuildContext context}) async {
    isLoadremove.value = true;
    Uri url = Uri.parse("$baseurl/customer/cart/remove/${productidincart}");
    await http.delete(
      url,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        var cart = jsonDecode(value.body);
        print(cart["data"]);

        if (cart["data"] != null) {
          currentcart = cartmodel.fromJson(cart["data"]);
          totalItems.value = currentcart!.items_qty!;
          itemscost.value = currentcart!.formatted_grand_total!;
          shippingfee.value = currentcart!.formatted_tax_total!;
          totalprice.value = currentcart!.formatted_sub_total!;
          homecontroller.itemsincart.value = cart["data"]["items_count"];
          currentcart!.items!.forEach((element) {
            listcart.add(itemincart.fromJson(element));
          });
        } else {
          totalItems.value = 0;
          itemscost.value = "\$0.0";
          shippingfee.value = "\$0.0";
          totalprice.value = "\$0.0";
          homecontroller.itemsincart.value = 0;
          currentcart=null;
        }
        isLoadremove.value = false;
      } else if (value.statusCode == 401) {
        showresult(context, Colors.red, "You need to Login");
        isLoadremove.value = false;
      } else {
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
        isLoadremove.value = false;
      }
    }).catchError((error) {
      showresult(context, Colors.red, error.toString());
      isLoadremove.value = false;
    });
  }

  Future<void> updateitemincart(
      {required int productidincart,
      required int count,
      required String token,
        required var index,
      required BuildContext context}) async {
    Map requestbody={"qty": {"${productidincart}": count}};
    Uri url = Uri.parse("$baseurl/customer/cart/update");
    await http
        .put(url,
            headers: {
              "Accept": "application/json",
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: json.encode(
              requestbody
            ))
        .then((value) async {
      if (value.statusCode == 200) {
        print("success");
        var cart = jsonDecode(value.body);
        if (cart["data"] != null) {
          currentcart = cartmodel.fromJson(cart["data"]);
          totalItems.value = currentcart!.items_qty!;
          itemscost.value = currentcart!.formatted_grand_total!;
          shippingfee.value = currentcart!.formatted_tax_total!;
          totalprice.value = currentcart!.formatted_sub_total!;
          homecontroller.itemsincart.value = cart["data"]["items_count"];

          currentcart!.items!.forEach((element) {
            if(element["id"]==listcart.elementAt(index).itemidincart){
              listcart.elementAt(index).formatted_total=(itemincart.fromJson(element).formatted_total);
            }

            print(listcart.elementAt(0).formatted_total);
          });

        } else {
          totalItems.value = 0;
          itemscost.value = "\$0.0";
          shippingfee.value = "\$0.0";
          totalprice.value = "\$0.0";
          homecontroller.itemsincart.value = 0;
        }
      } else if (value.statusCode == 401) {
        showresult(context, Colors.red, "You need to Login");
      } else {
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
      }
    }).catchError((error) {
      showresult(context, Colors.red, error.toString());
    });
  }
  Future<void> searchproducts({required String name}) async {
    isLoadsearch.value = true;
    isListempty.value=false;
    Uri url = Uri.parse("$baseurl/products?url_key=${name}");
    listsearch = [];
    listmiddle = [];
    await http.get(url, headers: {
      "Accept": "application/json",
    }).then((value) async {
      if (value.statusCode == 200) {
        var products = jsonDecode(value.body);
        products["data"].forEach((element) {
          listmiddle.add(productmodel.fromJson(element));
        });
        await getwishlist();
        listmiddle.forEach((element) {
          int id = element.id!;
          bool isinwish = isInwishList(id);
          listsearch.add(productmodel(
              isLoading: false,
              id: element.id,
              name: element.name,
              formatted_price: element.formatted_price,
              short_description: element.short_description,
              medium_image_url: element.medium_image_url,
              original_image_url: element.original_image_url,
              description: element.description,
              iswishlisted: isinwish));
        });
        if(listsearch.isEmpty){
          isListempty.value=true;
        }
        isLoadsearch.value = false;
      }

    }).catchError((error) {
      print(error.toString());
      isLoadsearch.value = false;
    });
  }

  Future<void> setbillingaddress({
    required int id,
    required String phoneaddress,
    required String state_name,
    required String address1,
    required String first_name,
    required String last_name,
    required String city,
    required String email,

    required BuildContext context,
    required String token,
  }) async {
    isLoadingaddress.value = true;
    Uri url = Uri.parse("$baseurl/customer/checkout/save-address");
    Map<String,dynamic> listadd={
      "0":address1
    };
   // List<String> listadd = [address1];
    Map<String, dynamic> requestbody = {
      "billing": {
        "address_id": id,
        "email": email,
        "save_as_address": false,
        "use_for_shipping": false,
        "phone": phoneaddress,
        "state": state_name,
        "address1": listadd,
        "city": city,
        "first_name": first_name,
        "last_name": last_name,
        "postcode": "00000",
        "country": "UAE",
      },
    };

    print(jsonEncode(requestbody));
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
        isLoadingaddress.value = false;
        showresult(context, Colors.green, "Billing has been set Successfuly");
        successaddress.value = true;
      } else if (value.statusCode == 401) {
        isLoadingaddress.value = false;
        successaddress.value = false;
        showresult(context, Colors.red, "You need to login");

      } else {
        isLoadingaddress.value = false;
        successaddress.value = false;
        showresult(context, Colors.red, jsonDecode(value.body)["message"]);
        print( jsonDecode(value.body));
      }
    }).catchError((error) {
      isLoadingaddress.value = false;
      successaddress.value = false;
      showresult(context, Colors.red, error.toString());
    });
  }
}
