
class addressmodel{
  int? id;
  String? address1;
  String? city;
  String? phone;
  String? state_name;

  addressmodel({
    required this.address1,
    required this.id,
    required this.city,
    required this.phone,
    required this.state_name,

  });
  addressmodel.fromJson(dynamic data){
    var jsondata=data["data"];
    id=jsondata["id"];
    address1=jsondata["attributes"]["address1"];
    city=jsondata["attributes"]["city"];
    phone=jsondata["attributes"]["phone"];
    state_name=jsondata["attributes"]["state_name"];

  }


}