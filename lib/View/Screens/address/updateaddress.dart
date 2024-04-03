import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:omega/Model/adressmodel.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Constant/Components.dart';
import '../../../Constant/reusable.dart';
import '../../../Control/logincontroller.dart';

class updateaddress extends StatelessWidget {
  addressmodel model;
  updateaddress({required this.model});
  late GoogleMapController gmc;
  TextEditingController adressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  logincontroller controller = Get.put(logincontroller());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    adressController.text = model.address1!;
    cityController.text = model.city!;
    controller.dropdownValueemarite.value = model.state!;
    phoneController.text = model.phoneaddress!;
    firstname.text = model.firstname!;
    lastname.text = model.lastname!;
    controller.getposition(context: context);

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          leadingWidth: 70.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(
                "assets/images/img_arrow_left.svg",
                width: 70,
                height: 70,
              ),
            ),
          ),
          elevation: 0.0,
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: height! * 0.67,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                textinput(
                                    controller: firstname,
                                    hint: "First Name",
                                    obscure: false,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "First Name Must Not Be Empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    lab: "First Name",
                                    type: TextInputType.text),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                textinput(
                                    controller: lastname,
                                    hint: "Last Name",
                                    obscure: false,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "Last Name Must Not Be Empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    lab: "Last Name",
                                    type: TextInputType.text),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        textinput(
                            controller: adressController,
                            hint: "Adress",
                            obscure: false,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Adress Must Not Be Empty";
                              } else {
                                return null;
                              }
                            },
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            lab: "Adress",
                            type: TextInputType.text),
                        SizedBox(
                          height: 20,
                        ),
                        textinput(
                            controller: phoneController,
                            hint: "Phone",
                            obscure: false,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Phone Must Not Be Empty ";
                              } else {
                                return null;
                              }
                            },
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            lab: "Phone",
                            type: TextInputType.number),
                        SizedBox(
                          height: 20,
                        ),
                        textinput(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "City Must Not Be Empty ";
                            } else {
                              return null;
                            }
                          },
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          lab: "City",
                          type: TextInputType.text,
                          obscure: false,
                          hint: "City",
                          controller: cityController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: SecondlyText(words: "Emarite")),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: width! * 0.55,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: fontcolorprimary,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                borderRadius: BorderRadius.circular(20.0),
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                value: controller.dropdownValueemarite.value,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: TextStyle(color: fontcolorprimary),
                                onChanged: (String? value) {
                                  controller.dropdownValueemarite = value!.obs;
                                },
                                items: emarites.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                            condition: controller.isLoadingaddress.isFalse,
                            builder: (context) => buildButton(
                                context: context,
                                name: "Update",
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    await controller.addressupdate(
                                      id: model.id!,
                                      address1: adressController.text,
                                      city: cityController.text,
                                      phoneaddress: phoneController.text,
                                      state_name: controller.dropdownValueemarite.value,
                                      context: context,
                                      token: token!,
                                      first_name: firstname.text,
                                      last_name: lastname.text,
                                    );
                                    if (controller.successaddress.isTrue) {
                                      controller.getadress(
                                        token: token!,
                                      );
                                      Get.back();
                                    }
                                  }
                                }),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  width: width! * 0.9,
                  height: width! * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: fontcolorprimary.withOpacity(0.05),
                        spreadRadius: 4,
                        blurRadius: 5,
                        offset: Offset(
                          2,
                          4,
                        ),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ConditionalBuilder(
                          condition: controller.isloadmap.isFalse,
                          builder: (context) => controller.getlocation.isTrue
                              ? Obx(
                                  () => GoogleMap(
                                    markers: Set<Marker>.of(
                                        [controller.marker.value]),
                                    onTap: (LatLng) async {
                                      controller.updateMarker(LatLng);
                                      controller.visiblesave = false.obs;
                                      await setLocaleIdentifier("en_US");
                                      List<Placemark> placemarks =
                                          await placemarkFromCoordinates(
                                        LatLng.latitude,
                                        LatLng.longitude,
                                      );
                                      adressController.text =
                                          placemarks[0].subThoroughfare! +
                                              placemarks[0].thoroughfare!;
                                      cityController.text =
                                          placemarks[0].subLocality!;
                                      emarites.contains(
                                              placemarks[0].administrativeArea!)
                                          ? controller
                                                  .dropdownValueemarite.value =
                                              placemarks[0].administrativeArea!
                                          : controller.dropdownValueemarite
                                              .value = emarites.first;
                                    },
                                    mapType: MapType.hybrid,
                                    initialCameraPosition:
                                        controller.kGooglePlex!,
                                    onMapCreated:
                                        (GoogleMapController _controller) {
                                      gmc = _controller;
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text("Can not Open Map"),
                                ),
                          fallback: (context) => Container(
                                width: width! * 0.9,
                                height: width! * 0.5,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Shimmer(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.grey[300]!,
                                          Colors.grey[100]!,
                                          Colors.grey[300]!
                                        ],
                                        stops: [0.4, 0.5, 0.6],
                                      ),
                                      child: Container(
                                        width: width! * 0.9,
                                        height: width! * 0.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                      Obx(
                        () => Visibility(
                          visible: controller.visiblesave.value,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: buildmapButton(
                                context: context,
                                name: "Save",
                                buttoncolor: Colors.blue,
                                onTap: () async {
                                  controller.visiblesave = false.obs;
                                  await setLocaleIdentifier("en_US");
                                  List<Placemark> placemarks =
                                      await placemarkFromCoordinates(
                                    currentlocation!.latitude,
                                    currentlocation!.longitude,
                                  );

                                  adressController.text =
                                      placemarks[0].subThoroughfare! +
                                          " " +
                                          placemarks[0].thoroughfare!;
                                  cityController.text =
                                      placemarks[0].subLocality!;
                                  emarites.contains(
                                          placemarks[0].administrativeArea!)
                                      ? controller.dropdownValueemarite.value =
                                          placemarks[0].administrativeArea!
                                      : controller.dropdownValueemarite.value =
                                          emarites.first;
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
