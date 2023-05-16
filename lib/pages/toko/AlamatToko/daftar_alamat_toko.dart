import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/models/alamat_toko_model.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/pages/toko/AlamatToko/tambah_alamat_toko.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/controllers/alamat_controller.dart';
import 'package:rumah_kreatif_toba/models/alamat_model.dart';
import '../../../utils/colors.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';

class DaftarAlamatTokoPage extends GetView<AlamatController> {
  int index = 0;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Get.find<AlamatController>().getAlamatToko();

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
                          Get.back();
                        },
                        child: AppIcon(
                          icon: Icons.arrow_back,
                          iconColor: AppColors.redColor,
                          backgroundColor: Colors.white,
                          iconSize: Dimensions.iconSize24,
                        ),
                      ),
                      BigText(
                        text: "Daftar Alamat Toko",
                        size: Dimensions.font20,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                              TambahAlamatToko()
                          );
                        },
                        child: BigText(
                          text: "Tambah Alamat",
                          size: Dimensions.font20,
                          color: AppColors.redColor,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              height: 220,
              width: double.maxFinite,
              child: Card(
                elevation: 5,
                child: InkWell(
                  // onTap: () {
                  //   if (index == _selectedIndex) {
                  //     _selectedIndex = -1;
                  //   } else {
                  //     _selectedIndex = index;
                  //   }
                  // },
                  child: Container(
                    // color: index == _selectedIndex
                    //     ? AppColors.redColor
                    //     : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(7),
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: GetBuilder<AlamatController>(
                              builder: (AlamatController) {
                                return ListView.builder(
                                  itemCount:
                                  AlamatController.daftarAlamatTokoList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    AlamatToko alamattoko =
                                    AlamatController.daftarAlamatTokoList[index];
                                    return ListTile(
                                      title: Text("Alamat Toko ${index + 1}"),
                                      subtitle: Text(alamattoko
                                          .merchant_street_address
                                          ?.toString() ??
                                          ""),
                                      trailing: Text(alamattoko
                                          .merchant_street_address
                                          ?.toString() ??
                                          ""),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
