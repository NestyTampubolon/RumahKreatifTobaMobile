import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/utils/app_constants.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../../controllers/toko_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import 'package:get/get.dart';
class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<TokoController>().profilToko();
    var profilToko = Get.find<TokoController>().profilTokoList;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconColor: AppColors.redColor,
                        backgroundColor: Colors.white.withOpacity(0.0),
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width20,
                    ),
                    BigText(
                      text: "Profil Toko",
                      size: Dimensions.font20,
                    ),
                  ],
                ),
              ),
              GetBuilder<TokoController>(builder: (controller) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          child:  Column(
                            children: [
                              Divider(color: AppColors.buttonBackgroundColor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(text: "Nama Toko" , color: AppColors.signColor, size: Dimensions.font16),
                                  BigText(text: profilToko[0].nama_merchant.toString(), size: Dimensions.font16),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(text: "Deskripsi Toko", color: AppColors.signColor, size: Dimensions.font16),
                                  BigText(text: profilToko[0].deskripsi_toko.toString(), size: Dimensions.font16 ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(text: "Kontak Toko", color: AppColors.signColor, size: Dimensions.font16),
                                  BigText(text: profilToko[0].kontak_toko.toString(), size: Dimensions.font16 ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BigText(text: "Gambar Toko", color: AppColors.signColor, size: Dimensions.font16),
                                  Container(
                                    height: Dimensions.height45*3,
                                    width: Dimensions.width45*3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius15)),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              '${AppConstants.BASE_URL_IMAGE}u_file/foto_merchant/${profilToko[0].foto_merchant}',
                                            )  )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Dimensions.width20*3,
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height10/2,
                                        bottom: Dimensions.height10/2 ,
                                        left: Dimensions.width10,
                                        right: Dimensions.width10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.redColor),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 2),
                                        color: Colors.white),
                                    child: GestureDetector(
                                        onTap: () {
                                        },
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              BigText(
                                                text: "Edit",
                                                color: Colors.redAccent,
                                                size: Dimensions.height15,
                                              ),
                                            ])),
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                );
              }),

            ],
          )
        ],
      ),
    );
  }
}
