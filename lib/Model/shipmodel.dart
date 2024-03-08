import 'dart:convert';

class shipmodel{
  String? carrier_title;
  String? method;
  String? formatted_price;
  List<dynamic>? rates;
  shipmodel({required this.carrier_title,required this.formatted_price,required this.method,required this.rates});
  shipmodel.fromJson(dynamic json){
  carrier_title=json["carrier_title"];
  rates=json["rates"];
 rates!.forEach((element) {
   method=element["method"];
   formatted_price=element["formatted_price"];
  });
  }
}