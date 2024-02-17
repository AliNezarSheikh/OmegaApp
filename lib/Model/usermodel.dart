import '../Constant/Components.dart';

class usermodel{
 int? id;
  String? email;
  String? first_name;
  String? last_name;
  String? gender;
  dynamic phone;
 //String? token;

  usermodel({
    required this.email,
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.gender,
    //required this.token,
    required this.phone,

});
 usermodel.fromJson(dynamic data){
  var jsondata=data["data"];
  id=jsondata["id"];
  email=jsondata["email"];
  first_name=jsondata["first_name"];
  last_name=jsondata["last_name"];
  gender=jsondata["gender"];
 // token=data["token"];
 phone=jsondata["phone"];

}
   usermodel.signOut() {
    currentuser = usermodel(email: null,id: null, first_name: null, last_name: null, gender: null, phone: null);
  }

}