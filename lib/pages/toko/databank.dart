import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rumah_kreatif_toba/controllers/bank_controller.dart';
import 'package:rumah_kreatif_toba/pages/account/account_page.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/pages/toko/alamattoko.dart';
import 'package:rumah_kreatif_toba/pages/toko/namatoko.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_dropdown_field.dart';
import 'package:rumah_kreatif_toba/widgets/app_text_field.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:rumah_kreatif_toba/widgets/monserrat_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/toko_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_dropdown_field_bank.dart';
import '../../widgets/app_icon.dart';
import '../home/home_page.dart';

class DataBankPage extends StatefulWidget {
  const DataBankPage({Key? key}) : super(key: key);

  @override
  State<DataBankPage> createState() => _DataBankPageState();
}

class _DataBankPageState extends State<DataBankPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var DataBankController = TextEditingController();
    var PemilikBankController = TextEditingController();
    var NomorBankController = TextEditingController();
    var DataBankValue;

    Future<void> _tambahRekening() async {
      String namabank = DataBankController.text.trim();
      String norekening = NomorBankController.text.trim();
      String atasnama = PemilikBankController.text.trim();

      if (namabank.isEmpty) {
        showCustomSnackBar("Nama bank masih kosong", title: "Nama");
      } else if (norekening.isEmpty) {
        showCustomSnackBar("No rekening masih kosong", title: "No Rekening");
      } else if (atasnama.isEmpty) {
        showCustomSnackBar("Atas nama masih kosong", title: "Atas Nama");
      } else {
        var userController = Get.find<UserController>().usersList[0];

        var controller = Get.find<BankController>();
        controller
            .tambahRekening(
                userController.id, namabank, norekening, atasnama)
            .then((status) async {
          Get.back();
        });
      }
    }

    return Scaffold(
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
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconColor: AppColors.redColor,
                        backgroundColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width20,
                    ),
                    BigText(
                      text: "Masukkan Info Bank",
                      size: Dimensions.font20,
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
                      AppDropdownFieldBank(
                        hintText: 'Nama Bank',
                        icon: Icons.comment_bank_rounded,
                        controller: DataBankController,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                    ],
                  ),
                ),
                //
                Container(
                  child: Column(
                    children: [
                      AppTextField(
                        hintText: 'No Rekening',
                        icon: Icons.book,
                        textController: NomorBankController,
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                    ],
                  ),
                ),
                //
                Container(
                  child: Column(
                    children: [
                      AppTextField(
                        hintText: 'Atas Nama',
                        icon: Icons.people,
                        textController: PemilikBankController,
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
                text: " * Pastikan data yang masukkan benar ",
                size: 14,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => {_tambahRekening()},
              child: Container(
                width: 306,
                height: 45,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
