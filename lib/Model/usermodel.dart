import '../Constant/Components.dart';

class usermodel{
  String? id;
   String? email;
  String? first_name;
  String? last_name;
  int? store_credits;
  int? completed_orders;
  usermodel({
    required this.email,
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.store_credits,
    required this.completed_orders,
});
 usermodel.fromJson(dynamic data){
  var jsondata=data["data"];
  id=jsondata["id"];
  email=jsondata["attributes"]["email"];
  first_name=jsondata["attributes"]["first_name"];
  last_name=jsondata["attributes"]["last_name"];
  store_credits=jsondata["attributes"]["store_credits"];
  completed_orders=jsondata["attributes"]["completed_orders"];
}
   usermodel.signOut() {
    currentuser = usermodel(email: null, id: null, first_name: null, last_name: null, store_credits: null, completed_orders: null);
  }

}