class addressmodel {
  int? id;
  String? firstname;
  String? lastname;
  String? country;
  String? address1;
  String? city;
  String? phoneaddress;
  String? state;
  String? postcode;

  addressmodel({
    required this.address1,
    required this.id,
    required this.city,
    required this.phoneaddress,
    required this.state,
    required this.firstname,
    required this.lastname,
    required this.postcode,
    required this.country,
  });
  addressmodel.fromJson(dynamic data) {
    id = data["id"];
    address1 = data["address1"][0];
    city = data["city"];
    phoneaddress = data["phone"];
    state = data["state"];
    firstname = data["first_name"];
    lastname = data["last_name"];
    country = data["country"];
    postcode = data["postcode"];
  }
}
