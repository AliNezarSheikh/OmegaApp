class categorymodel{
  int? id;
  String? name;
  categorymodel({
    required this.name,
    required this.id,

});
  categorymodel.fromJson(dynamic data){
    id=data["id"];
    name=data["name"];
  }
}