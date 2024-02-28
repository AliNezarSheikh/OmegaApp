import 'dart:convert';

import 'package:get/get.dart';

class cartmodel {
  int? cartid;
  int? items_count;
  int? items_qty;
  String? formatted_grand_total;
  String? formatted_tax_total;
  String? formatted_sub_total;
  List<dynamic>? items;

  cartmodel({
    required this.cartid,
    required this.items_count,
    required this.formatted_grand_total,
    required this.formatted_sub_total,
    required this.formatted_tax_total,
    required this.items,
    required this.items_qty,
  });
  cartmodel.fromJson(dynamic data) {
    cartid = data["id"];
    items_count = data["items_count"];
    formatted_tax_total = data["formatted_tax_total"];
    formatted_grand_total = data["formatted_grand_total"];
    formatted_sub_total = data["formatted_sub_total"];
/* if (data['items'] != null) {
    items = <itemincart>[];
    data['items'].forEach((v) {
      items!.add(new itemincart.fromJson(v));
    });
  }*/
    items = data["items"];
    items_qty = data["items_qty"];
  }
}

class itemincart {
  int? itemidincart;
  String? quantity = "";
  String? name;
  RxInt? counter;
  String? formatted_total;
  RxString? currenttotal;
  int? product_id;
  String? short_description;
  String? medium_image_url;
  itemincart({
    required this.medium_image_url,
    required this.short_description,
    required this.name,
    required this.formatted_total,
    required this.itemidincart,
    required this.product_id,
    required this.quantity,
    required this.counter,
    required this.currenttotal,
  });
  itemincart.fromJson(dynamic element) {
    itemidincart = element["id"];
    quantity = element["quantity"];
    name = element["name"];
    formatted_total= element["formatted_total"];
    currenttotal= formatted_total!.obs;
    product_id = element["product"]["id"];
    short_description = element["product"]["short_description"];
    medium_image_url = element["product"]["base_image"]["medium_image_url"];
    counter = int.parse(element["quantity"]).obs;

  }
}
