
class productmodel{
  int? id;
  String? name;
  String?  formatted_price;
  String? short_description;
  String? description;
  String? medium_image_url;
  String? original_image_url;
  bool iswishlisted=false;

  productmodel({
    required this.id,
    required this.name,
    required this.formatted_price,
    required this.short_description,
    required this.medium_image_url,
    required this.original_image_url,
    required this.description,
    required this.iswishlisted,
});
productmodel.fromJson(dynamic data){
  id=data["id"];
  name=data["name"];
  formatted_price=data["formatted_price"];
  short_description=data["short_description"];
  medium_image_url=data["base_image"]["medium_image_url"];
  original_image_url=data["base_image"]["original_image_url"];
  description=data["description"];
}

}