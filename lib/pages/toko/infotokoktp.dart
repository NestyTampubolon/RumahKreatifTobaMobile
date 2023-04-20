import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/toko_controller.dart';
import 'package:rumah_kreatif_toba/pages/toko/daftarberhasil.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'dart:io';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/small_text.dart';

class TokoKTP extends StatefulWidget {
  const TokoKTP({Key? key}) : super(key: key);

  @override
  State<TokoKTP> createState() => _TokoKTPState();
}

class _TokoKTPState extends State<TokoKTP> {
  @override
  Widget build(BuildContext context) {

    Future<void> verifikasiToko() async {
      var userController = Get.find<UserController>();
      await userController.getUser();

      var controller = Get.find<TokoController>();
      controller.verifikasiToko(userController.users.id).then((status) async {

      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height45, bottom: Dimensions.height15),
                  padding: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.toNamed(RouteHelper.getInitial());
                          Get.back();
                        },
                        child: AppIcon(
                          icon: Icons.arrow_back,
                          iconColor:AppColors.redColor,
                          backgroundColor:  Colors.white,
                          iconSize: Dimensions.iconSize24,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      BigText(
                        text: "Masukkan Info Toko",
                        size: Dimensions.font20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "Foto KTP *",
                          fontWeight: FontWeight.bold,
                          size: Dimensions.font20,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        GetBuilder<TokoController>(builder: (controllertoko) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(Dimensions.height20),
                                padding: EdgeInsets.all(Dimensions.height20),
                                width: Dimensions.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                    color: AppColors.redColor),
                                child: GestureDetector(
                                    onTap: () {
                                      controllertoko.pickImage();
                                    },
                                    child: Row(children: [
                                      BigText(
                                        text: "Upload Foto KTP",
                                        color: Colors.white,
                                        size: Dimensions.height15,
                                      ),
                                    ])),
                              ),
                              controllertoko.pickedFileKTP != null
                                  ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    //to show image, you type like this.
                                    File(controllertoko.pickedFileKTP!.path),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                  ),
                                ),
                              )
                                  : Text(
                                "Tidak Ada Gambar",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          child: SmallText(
                            text:
                            "Pastikan gambar yang anda masukkan dapat dilihat dengan jelas",
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                      ],
                    ) ,
                  ),
                  SizedBox(
                    height: Dimensions.height45,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "Foto Selfie Bersama KTP *",
                          fontWeight: FontWeight.bold,
                          size: Dimensions.font20,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        GetBuilder<TokoController>(builder: (controllertoko) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(Dimensions.height20),
                                padding: EdgeInsets.all(Dimensions.height20),
                                width: Dimensions.screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                    color: AppColors.redColor),
                                child: GestureDetector(
                                    onTap: () {
                                      controllertoko.pickImageSelfieKTP();
                                    },
                                    child: Row(children: [
                                      BigText(
                                        text: "Upload Foto Selfie dengan KTP",
                                        color: Colors.white,
                                        size: Dimensions.height15,
                                      ),
                                    ])),
                              ),
                              controllertoko.pickedFileSelfieKTP != null
                                  ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    //to show image, you type like this.
                                    File(controllertoko.pickedFileSelfieKTP!.path),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                  ),
                                ),
                              )
                                  : Text(
                                "Tidak Ada Gambar",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          child: SmallText(
                            text:
                            "Pastikan gambar yang anda masukkan dapat dilihat dengan jelas",
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: (){ verifikasiToko();},
                    child: Container(
                        width: 306,
                        height: 45,
                        // alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.redColor),
                        child: Center(
                          child: BigText(
                            text: "Kirim",
                            fontWeight: FontWeight.bold,
                            size: Dimensions.font20,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: Dimensions.height45,
                  ),
                ],
              )
            ],
          ))
    );
  }

}
