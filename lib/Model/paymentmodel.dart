class paymentmodel{
  String? method;
  String? method_title;
  String? image;
  paymentmodel({required this.method,required this.image,required this.method_title});
  paymentmodel.fromJson(dynamic json){
    method=json["method"];
    method_title=json["method_title"];
    image=json["image"];
  }
}