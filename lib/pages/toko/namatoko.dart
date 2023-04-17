import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/pages/toko/infotokoktp.dart';
import 'package:rumah_kreatif_toba/pages/toko/toko.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_text_field.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../home/home_page.dart';

class NamaToko extends StatefulWidget {
  const NamaToko({Key? key}) : super(key: key);

  @override
  State<NamaToko> createState() => _NamaTokoState();
}

class _NamaTokoState extends State<NamaToko> {
  @override
  Widget build(BuildContext context) {
    var NamaTokoController = TextEditingController();
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
                        GestureDetector(
                          onTap: () {
                            Get.to(() => TokoPage());
                          },
                          child: AppIcon(icon: Icons.arrow_back),
                        ),
                        Container(
                          width: 250,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: BigText(
                            text: "Masukkan Info Toko",
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
              height: 100,
            ),
            Container(
              // padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: AppTextField(
                      textController: NamaTokoController,
                      hintText: "Apa nama Tokomu",
                      icon: Icons.shopping_bag,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.height20,
                      right: Dimensions.height20,
                    ),
                    child: Text(
                      "Nama yang menarik lebih mudah diingat pembeli nama yang sudah dipilih tidak dapat diubah",
                      // style: TextStyle(color: Color.fromARGB(1, 66, 84, 102)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () => {Get.to(() => TokoKTP())},
              child: Container(
                  width: 306,
                  height: 45,
                  // alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border, width: 3),
                      color: AppColors.border),
                  child: Center(
                    child: BigText(
                      text: "Lanjut",
                      fontWeight: FontWeight.bold,
                      size: Dimensions.font20,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
