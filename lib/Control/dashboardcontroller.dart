import 'dart:convert';
import 'dart:ui';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:omega/Model/categorymodel.dart';
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
    isLoad.value=true;
    Uri url = Uri.parse("$baseurl/categories");
    listcategories = [];
    await http.get(
      url,
      headers: {
        "Accept": "application/json",
      }
    ).then((value) {
      if(value.statusCode==200){
        var categories=jsonDecode(value.body);

        categories["data"].forEach((element){
          print(element);
          listcategories.add(categorymodel.fromJson(element));

        });
        isLoad.value=false;
      }
    }).catchError((error){
      print(error.toString());
      isLoad.value=false;
    });
  }
}
