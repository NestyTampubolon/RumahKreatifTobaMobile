import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/toko_controller.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/bank_controller.dart';
import '../../controllers/categories_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_text_field_password.dart';
import '../home/home_page.dart';

class PasswordTokoPage extends StatefulWidget {
  const PasswordTokoPage({Key? key}) : super(key: key);

  @override
  State<PasswordTokoPage> createState() => _PasswordTokoPageState();
}

class _PasswordTokoPageState extends State<PasswordTokoPage> {
  var PasswordTokoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var PasswordTokoController = TextEditingController();


    Future<void> _tambahRekening() async {
      String password = PasswordTokoController.text.trim();

      if(password.isEmpty){
        showCustomSnackBar("Password masih kosong", title: "Password");
      }else{
        var userController = Get.find<UserController>().usersList[0];

        var controller = Get.find<TokoController>();
        controller.masukToko(userController.id, password).then((status) async {
          Get.find<CategoriesController>().getKategoriList();
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
             // decoration: BoxDecoration(color: AppColors.redColor),
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(
                                  () => HomePage(initialIndex: 3),
                            );
                          },
                          child: Container(
                            width: Dimensions.height45,
                            height: Dimensions.height45,
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.redColor,
                              size: Dimensions.iconSize24,
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: BigText(
                            text: "Password Toko",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      AppTextFieldPassword(
                        hintText: 'Password',
                        icon: Icons.lock,
                        textController: PasswordTokoController,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: SmallText(
                text: " * Pastikan password yang Anda masukkan benar!",
                size: 14,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => {
                _tambahRekening(),
              },
              child: Container(
                width: 306,
                height: 45,
                // alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.redColor),
                child: Center(
                  child: BigText(
                    text: "Masuk",
                    fontWeight: FontWeight.bold,
                    size: Dimensions.font20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
