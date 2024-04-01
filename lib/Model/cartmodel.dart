import 'package:get/get.dart';

class cartmodel {
  int? cartid;
  int? items_count;
  int? items_qty;
  String? coupon_code;
  String? formatted_discount;
  String? formatted_grand_total;
  String? selected_shipping_rate;
  String? formatted_sub_total;
  List<dynamic>? items;

  cartmodel({
    required this.cartid,
    required this.items_count,
    required this.formatted_grand_total,
    required this.formatted_sub_total,
    required this.selected_shipping_rate,
    required this.formatted_discount,
    required this.items,
    required this.items_qty,
    required this.coupon_code,
  });
  cartmodel.fromJson(dynamic data) {
    cartid = data["id"];
    items_count = data["items_count"];
    coupon_code=data["coupon_code"];
    formatted_discount=data["formatted_discount"];
    selected_shipping_rate = data["selected_shipping_rate"]!=null?data["selected_shipping_rate"]['formatted_price']:"\$0.0";
    formatted_grand_total = data["formatted_grand_total"];
    formatted_sub_total = data["formatted_sub_total"];
    items = data["items"];
    items_qty = data["items_qty"];
  }
}

class itemincart {
  int? itemidincart;
  int? quantity ;
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
    counter =quantity!.obs;
  }
}
