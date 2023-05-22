import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/controllers/alamat_controller.dart';
import 'package:rumah_kreatif_toba/models/alamat_model.dart';
import '../../base/show_custom_message.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class DaftarAlamatPage extends GetView<AlamatController> {
  int index = 0;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Get.find<AlamatController>().getAlamat();

    Future<void> _hapusAlamat(int? user_address_id) async {
      var cartController = Get.find<AlamatController>();
      cartController.hapusAlamat(user_address_id).then((status) {
        if (status.isSuccess) {
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height30,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(HomePage(initialIndex: 3));
                        },
                        child: AppIcon(
                          icon: Icons.arrow_back,
                          iconColor: AppColors.redColor,
                          backgroundColor: Colors.white,
                          iconSize: Dimensions.iconSize24,
                        ),
                      ),
                      BigText(
                        text: "Daftar Alamat",
                        size: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getTambahAlamatPage());
                        },
                        child: Container(
                            child: Icon(
                              Icons.add,
                              color: AppColors.redColor,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GetBuilder<AlamatController>(
              builder: (AlamatController) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: AlamatController.daftarAlamatList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Alamat alamat =
                    AlamatController.daftarAlamatList[index];
                    return Container(
                      width: Dimensions.screenWidth,
                      height: Dimensions.height45 * 4,
                      margin: EdgeInsets.only(
                          bottom: Dimensions.height10,
                          top: Dimensions.height10 / 2,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.buttonBackgroundColor),
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: "Alamat ${index + 1}", fontWeight: FontWeight.bold, ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  alamat.province_name?.toString() ?? "",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  alamat.city_name?.toString() ?? "",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  alamat.subdistrict_name?.toString() ?? "",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  alamat.user_street_address?.toString() ?? "",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              _hapusAlamat(alamat.user_address_id);
                            },
                            child: AppIcon(
                                iconSize: Dimensions
                                    .iconSize16,
                                iconColor: AppColors
                                    .redColor,
                                backgroundColor:
                                Colors.white,
                                icon: Icons.delete),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GetBuilder<AlamatController>(
            //       builder: (AlamatController) {
            //         return ListView.builder(
            //           physics: const NeverScrollableScrollPhysics(),
            //           shrinkWrap: true,
            //           itemCount: AlamatController.daftarAlamatList.length,
            //           itemBuilder: (BuildContext context, int index) {
            //             Alamat alamat =
            //             AlamatController.daftarAlamatList[index];
            //             return Container(
            //               width: Dimensions.screenWidth,
            //               height: Dimensions.height45 * 2.5,
            //               margin: EdgeInsets.only(
            //                   bottom: Dimensions.height10,
            //                   top: Dimensions.height10 / 2,
            //                   left: Dimensions.width20,
            //                   right: Dimensions.width20),
            //               padding: EdgeInsets.all(Dimensions.height20),
            //               decoration: BoxDecoration(
            //                   border: Border.all(
            //                       color: AppColors.buttonBackgroundColor),
            //                   borderRadius:
            //                   BorderRadius.circular(Dimensions.radius20),
            //                   color: Colors.white),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   BigText(text: "Alamat ${index + 1}", fontWeight: FontWeight.bold,),
            //                   BigText(text: alamat.user_street_address?.toString() ?? "")
            //                 ],
            //               ),
            //             );
            //           },
            //         );
            //       },
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //       },
            //       child: AppIcon(
            //           iconSize: Dimensions
            //               .iconSize16,
            //           iconColor: AppColors
            //               .redColor,
            //           backgroundColor:
            //           Colors.white,
            //           icon: Icons.delete),
            //     )
            //   ],
            // )

          ],
        ),
      ),
    );
  }
}
