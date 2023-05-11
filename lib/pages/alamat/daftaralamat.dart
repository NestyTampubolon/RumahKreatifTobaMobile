import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/controllers/alamat_controller.dart';

import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class DaftarAlamatPage extends GetView<AlamatController> {
  int index = 0;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
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
                        text: "Daftar Alamat",
                        size: Dimensions.font20,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getTambahAlamatPage());
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
                              builder: (GetAlamat) {
                                return GetAlamat.isLoading
                                    ? ListView.builder(
                                        itemBuilder: (context, index) {
                                          AddressUserId();
                                          AddressUser();
                                          DeleteButton();
                                        },
                                      )
                                    : Container(
                                        height:
                                            50, // set the height of the container to your desired height
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.redColor,
                                          ),
                                        ),
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

Widget AddressUserId() {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: "Alamat 1",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}

Widget AddressUser() {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: "Jalan Sisingamangaraja Balige jkaya jaya jaya",
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

Widget DeleteButton() {
  return Padding(
    padding: const EdgeInsets.only(
      left: 15.0,
      top: 15.0,
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => {
          Get.to(
            () => HomePage(initialIndex: 3),
          ),
        },
        child: Container(
          width: 306,
          height: 45,
          // alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              color: AppColors.redColor),
          child: Center(
            child: BigText(
              text: "Hapus",
              fontWeight: FontWeight.bold,
              size: Dimensions.font20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
