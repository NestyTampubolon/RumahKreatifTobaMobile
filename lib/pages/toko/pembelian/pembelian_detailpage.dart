import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/pembelian_controller.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/pesanan_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/currency_format.dart';
import '../../../widgets/price_text.dart';
import '../../../widgets/small_text.dart';


class PembelianDetailPage extends StatefulWidget {
  const PembelianDetailPage({Key? key}) : super(key: key);

  @override
  State<PembelianDetailPage> createState() => _PembelianDetailPageState();
}

class _PembelianDetailPageState extends State<PembelianDetailPage> {
  @override
  void initState() {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    var detailPembelian = Get.find<PembelianController>().detailPembelianList;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      iconColor: Colors.white,
                      backgroundColor: AppColors.redColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20,
                  ),
                  BigText(
                    text: "Detail Pesanan",
                    size: Dimensions.font20,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
              margin: EdgeInsets.only(
                  top: Dimensions.height20
              ),

              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        BigText(
                          text: detailPembelian[0].kodePembelian,
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //List View Detail Produk
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
              margin: EdgeInsets.only(
                  top: Dimensions.height20
              ),

              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        BigText(
                          text: "Detail Pembayaran",
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  GetBuilder<PembelianController>(builder: (controller) {
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: Dimensions.height45 * 3.8),
                        itemCount: controller.detailPembelianList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            width: Dimensions.screenWidth,
                            height: Dimensions.height45 * 3.5,
                            margin: EdgeInsets.only(
                              bottom: Dimensions.height10,),
                            padding: EdgeInsets.all(Dimensions.height10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.buttonBackgroundColor),
                                borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(

                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                var produkIndex =
                                                controller
                                                    .detailPembelianList[index]
                                                    .productId!;
                                                if (produkIndex >= 0) {
                                                  Get.toNamed(RouteHelper
                                                      .getProdukDetail(
                                                      produkIndex));
                                                }
                                              },
                                              child: Container(
                                                width:
                                                Dimensions.height20 *
                                                    3,
                                                height:
                                                Dimensions.height20 *
                                                    3,
                                                margin: EdgeInsets.only(
                                                    top: Dimensions
                                                        .height10),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "assets/images/coffee.jpg")),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radius20),
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.width20,),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width : Dimensions.screenWidth/1.6,
                                                  child: BigText(
                                                    text: controller
                                                        .detailPembelianList[index]
                                                        .productName,
                                                    size: Dimensions.font16,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SmallText(
                                                        text: "${ controller
                                                            .detailPembelianList[index]
                                                            .jumlahPembelianProduk} x "),
                                                    PriceText(
                                                      text: CurrencyFormat
                                                          .convertToIdr(
                                                          controller
                                                              .detailPembelianList[index]
                                                              .price,
                                                          0),
                                                      size: Dimensions.font16,
                                                    ),
                                                  ],
                                                ),


                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: AppColors.buttonBackgroundColor),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SmallText(
                                                    text: "Total Harga"),
                                                PriceText(
                                                  text: CurrencyFormat
                                                      .convertToIdr(
                                                      controller
                                                          .detailPembelianList[index]
                                                          .hargaPembelianProduk,
                                                      0),
                                                  size: Dimensions.font16,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
              margin: EdgeInsets.only(
                  top: Dimensions.height20
              ),

              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        SmallText(
                          text: "Jika pesanan telah disiapkan. SILAHKAN KONFIRMASI PESANAN.",
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Container(
                        width: Dimensions.width45*3,
                        height: Dimensions.height30,
                        // alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.redColor),
                        child: Center(
                          child: BigText(
                            text: "Konfirmasi",
                            size: Dimensions.font16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
