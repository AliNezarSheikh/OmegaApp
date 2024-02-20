import 'dart:convert';
import 'dart:ui';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:omega/Model/categorymodel.dart';
import 'package:omega/Model/productmodel.dart';
import '../Constant/Components.dart';
import 'package:http/http.dart' as http;


class dashcontroller extends GetxController {
  RxInt selectedlistindex = 0.obs;
  Rx<Color> selectedlistcolor = fontcolorprimary.obs;
  RxBool isLoad=false.obs;

  void changenlistindex(int index) {
    selectedlistindex.value = index;
    selectedlistcolor.value = fontcolorprimary;

  }
  Future<void> getcategories() async {
    Uri url = Uri.parse("$baseurl/categories?sort=id&order=asc");
    listcategories = [];
    await http.get(
      url,
      headers: {
        "Accept": "application/json",
      }
    ).then((value) async {
      if(value.statusCode==200){
        var categories=jsonDecode(value.body);

        categories["data"].forEach((element){
          listcategories.add(categorymodel.fromJson(element));

        });

      }

    }).catchError((error){
      print(error.toString());

    });
  }
  Future<void> getallproducts() async {
    isLoad.value=true;
    Uri url = Uri.parse("$baseurl/products");
    listproducts = [];
    await http.get(
        url,
        headers: {
          "Accept": "application/json",
        }
    ).then((value) {
      if(value.statusCode==200){
        var products=jsonDecode(value.body);

        products["data"].forEach((element){

          listproducts.add(productmodel.fromJson(element));

        });
        isLoad.value=false;
      }
    }).catchError((error){
      print(error.toString());
      isLoad.value=false;
    });
  }
  Future<void> getproductbycategory({required int id}) async {
    listproducts = [];
    isLoad.value=true;
    Uri url = Uri.parse("$baseurl/products?category_id=$id");
  if(id==1){
    await getallproducts();
  }else{
    await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type":"application/json",
        }
    ).then((value) {
      if(value.statusCode==200){
        var products=jsonDecode(value.body);
        products["data"].forEach((element){

          listproducts.add(productmodel.fromJson(element));

        });

        isLoad.value=false;
      }
    }).catchError((error){
      print(error.toString());
      isLoad.value=false;
    });
  }
  
 
  }
}
