import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/account/account_page.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/pages/toko/namatoko.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../home/home_page.dart';

class TokoPage extends StatefulWidget {
  const TokoPage({Key? key}) : super(key: key);

  @override
  State<TokoPage> createState() => _TokoPageState();
}

class _TokoPageState extends State<TokoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.border,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
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
                            Get.to(() => AccountPage());
                          },
                          child: AppIcon(icon: Icons.arrow_back),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/logo_rkt.png"))),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/Bangga_Buatan_Indonesia_Logo.png"))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height45,
                          bottom: Dimensions.height10),
                      padding: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText(
                        text: "Ciptakan Toko Onlinemu Sekarang!!",
                        fontWeight: FontWeight.bold,
                        size: 35,
                      )),
                  Container(
                      width: 380,
                      height: 380,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/DaftarToko.png")))),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            GestureDetector(
              onTap: () => {Get.to(() => NamaToko())},
              child: Container(
                  width: 306,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border, width: 3),
                      color: Colors.white),
                  child: Center(
                    child: BigText(
                      text: "Daftar",
                      fontWeight: FontWeight.bold,
                      size: Dimensions.font20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
