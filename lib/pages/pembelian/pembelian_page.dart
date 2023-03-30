import 'package:flutter/material.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class PembelianPage extends StatefulWidget {
  const PembelianPage({Key? key}) : super(key: key);

  @override
  State<PembelianPage> createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getKeranjangPage());
                },
                child: AppIcon(
                  icon: Icons.arrow_back,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.redColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ),
              SizedBox(
                width: Dimensions.width20,
              ),
              BigText(
                text: "Pembelian",
                size: Dimensions.font20,
              ),
            ],
          )),
      body: Container(
          margin: EdgeInsets.all(Dimensions.height15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(
                    text: "Alamat Pengiriman",
                    size: Dimensions.font16,
                    fontWeight: FontWeight.bold,
                  ),
                  BigText(
                    text: "Pilih Alamat Lain",
                    size: Dimensions.font16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.notification_success,
                  )
                ],
              ),
              SizedBox(height: Dimensions.height10,),
              Divider(color: AppColors.buttonBackgroundColor),
            ],
          )),
    );
  }
}
