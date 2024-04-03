import 'dart:convert';

import '../Constant/Components.dart';
import 'package:http/http.dart' as http;
class ordermodel{
  int? id;
  String? status;
  String? shipping_description;
  int? total_item_count;
  String? formatted_grand_total;
  String? formatted_sub_total;
  String? formatted_discount_amount;
  String? formatted_shipping_amount;
  String? shipfname;
  String? shiplname;
  String? shipaddress;
  String? shipcountry;
  String? shipstate;
  String? shipcity;
  String? shipphone;
  String? billfname;
  String? billlname;
  String? billaddress;
  String? billcountry;
  String? billstate;
  String? billcity;
  String? billphone;


  ordermodel({
    required this.id,
    required this.status,
    required this.shipping_description,
    required this.total_item_count,
    required this.formatted_grand_total,
    required this.formatted_sub_total,
    required this.formatted_discount_amount,
    required this.formatted_shipping_amount,
    required this.shipfname,
    required this.shiplname,
    required this.shipaddress,
    required this.shipcountry,
    required this.shipstate,
    required this.shipcity,
    required this.shipphone,
    required this.billfname,
    required this.billlname,
    required this.billaddress,
    required this.billcountry,
    required this.billstate,
    required this.billcity,
    required this.billphone,


});
  ordermodel.fromJson(dynamic data){
    id=data["id"];
    status=data["status"];
    shipping_description=data["shipping_description"];
    total_item_count=data["total_item_count"];
    formatted_grand_total=data["formatted_grand_total"];
    formatted_sub_total=data["formatted_sub_total"];
    formatted_discount_amount=data["formatted_discount_amount"];
    formatted_shipping_amount=data["formatted_shipping_amount"];

    shipfname=data["shipping_address"]["first_name"];
    shiplname=data["shipping_address"]["last_name"];
    shipaddress=data["shipping_address"]["address1"][0];
    shipcountry=data["shipping_address"]["country"];
    shipstate=data["shipping_address"]["state"];
    shipcity=data["shipping_address"]["city"];
    shipphone=data["shipping_address"]["phone"];
    billfname=data["billing_address"]["first_name"];
    billlname=data["billing_address"]["last_name"];
    billaddress=data["billing_address"]["address1"][0];
    billcountry=data["billing_address"]["country"];
    billstate=data["billing_address"]["state"];
    billcity=data["billing_address"]["city"];
    billphone=data["billing_address"]["phone"];
  }

}
class iteminorder{
 int? itemid;
 int? qty_ordered;
 String? formatted_price;
 String? formatted_grant_total;
 String? imageurl;
 iteminorder({
   required this.itemid,
   required this.qty_ordered,
   required this.formatted_price,
   required this.formatted_grant_total,
   required this.imageurl,
});
 iteminorder.fromjson(dynamic element)  {
   itemid=element["product_id"];
   qty_ordered=element["qty_ordered"];
   formatted_price=element["formatted_price"];
   formatted_grant_total=element["formatted_grant_total"];
   getproduct(id: itemid!);
   imageurl=urlimage;

 }
 String? urlimage;
 Future<String?> getproduct({required int id})async{
   Uri url = Uri.parse("$baseurl/products/${id}");
   await http.get(url,headers: {
     'Accept': 'application/json',
   }).then((value) {
     if(value.statusCode==200){
       var result = jsonDecode(value.body);
       urlimage= result["data"]["base_image"]["medium_image_url"];
     }else{
       return null;
     }
   }).catchError((error){
     return null;
   });

 }
}