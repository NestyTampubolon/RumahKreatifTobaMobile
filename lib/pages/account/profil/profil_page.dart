import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import 'package:get/get.dart';
class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      text: "Profil",
                      size: Dimensions.font20,
                    ),
                  ],
                ),
              ),
              Container(
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
                              children: [
                                BigText(text: "Informasi Akun "),
                                Container(
                                  width: Dimensions.height45,
                                  height: Dimensions.height45,
                                  child: Icon(
                                    Icons.info_outline,
                                    color: AppColors.redColor,
                                    size: Dimensions.iconSize24,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(text: "Username" , color: AppColors.signColor, size: Dimensions.font16,),
                                BigText(text: "Nesty Gloria Tampubolon", size: Dimensions.font16,),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(text: "Email", color: AppColors.signColor, size: Dimensions.font16),
                                BigText(text: "nestytampubolon@gmail.com", size: Dimensions.font16 ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(text: "Password", color: AppColors.signColor, size: Dimensions.font16),
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
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                          ],
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        child:  Column(
                          children: [
                            Divider(color: AppColors.buttonBackgroundColor),
                            Row(
                              children: [
                                BigText(text: "Biodata Diri "),
                                Container(
                                  width: Dimensions.height45,
                                  height: Dimensions.height45,
                                  child: Icon(
                                    Icons.info_outline,
                                    color: AppColors.redColor,
                                    size: Dimensions.iconSize24,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(text: "Nama" , color: AppColors.signColor, size: Dimensions.font16),
                                BigText(text: "Nesty Gloria Tampubolon" , size: Dimensions.font16),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(text: "Tanggal Lahir", color: AppColors.signColor, size: Dimensions.font16),
                                BigText(text: "ns1", size: Dimensions.font16 ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(text: "Jenis Kelamin", color: AppColors.signColor, size: Dimensions.font16),
                                BigText(text: "ns1", size: Dimensions.font16 ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(text: "No. HP", color: AppColors.signColor, size: Dimensions.font16),
                                BigText(text: "ns1", size: Dimensions.font16 ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
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
              )
            ],
          )
        ],
      ),
    );
  }
}
