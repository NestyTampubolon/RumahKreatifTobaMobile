import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  var DataBankController = TextEditingController();
  var PemilikBankController = TextEditingController();
  var NomorBankController = TextEditingController();
  var DataBankValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String Bank = DataBankController.text.trim();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.border),
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
                        Container(
                          width: 250,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: BigText(
                            text: "Masukkan Info Bank",
                            color: Colors.white,
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
                        hintText: 'Nama Pemilik Bank',
                        icon: Icons.people,
                        textController: PemilikBankController,
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
                        hintText: 'Nomor Rekening Bank',
                        icon: Icons.book,
                        textController: NomorBankController,
                        textInputType: TextInputType.number,
                        // textInputType: TextInputType.number,
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
                text: " * Pastikan data yang pilih benar ",
                size: 14,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => {
                Get.to(
                  () => AlamatTokoPage(),
                ),
              },
              child: Container(
                width: 306,
                height: 45,
                // alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.border,
                      width: 3,
                    ),
                    color: AppColors.border),
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
