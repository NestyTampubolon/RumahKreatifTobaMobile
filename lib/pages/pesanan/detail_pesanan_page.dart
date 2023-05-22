import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/pesanan_controller.dart';
import '../../controllers/popular_produk_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

import 'package:get/get.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/price_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/tittle_text.dart';

class DetailPesananPage extends StatefulWidget {
  const DetailPesananPage({Key? key}) : super(key: key);

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  @override
  void initState() {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUser();
      Get.find<PesananController>().getPesanan();
    }
  }

  @override
  Widget build(BuildContext context) {
    var detailPesanan = Get.find<PesananController>().detailPesanan;
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
                      iconColor: AppColors.redColor,
                      backgroundColor: Colors.white.withOpacity(0.0),
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20,
                  ),
                  BigText(
                    text: "Detail Pesanan",
                    size: Dimensions.font20,
                    fontWeight: FontWeight.bold,
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
                          text: detailPesanan[0].statusPembelian.toString(),
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  Container(
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        BigText(
                          text: detailPesanan[0].kodePembelian.toString(),
                          size: Dimensions.font16,
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
                          text: "Detail Produk",
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  GetBuilder<PesananController>(builder: (pesananController) {
                    print(pesananController.detailPesananList.length);
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: Dimensions.height45 * 3.8),
                        itemCount: pesananController.detailPesananList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var gambarproduk = Get.find<PopularProdukController>().imageProdukList.where(
                                  (produk) =>
                              produk.productId ==
                                  pesananController.detailPesananList[index].productId);
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
                                                pesananController
                                                    .detailPesananList[index]
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
                                                        image: NetworkImage(
                                                          '${AppConstants.BASE_URL_IMAGE}u_file/product_image/${gambarproduk.single.productImageName}',
                                                        )
                                                    ),
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
                                                    text: pesananController
                                                        .detailPesananList[index]
                                                        .productName,
                                                    size: Dimensions.font16,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SmallText(
                                                        text: "${pesananController
                                                            .detailPesananList[index].jumlahPembelianProduk} x "),
                                                    PriceText(
                                                      text: CurrencyFormat
                                                          .convertToIdr(
                                                          pesananController
                                                              .detailPesananList[
                                                          index]
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
                                                          pesananController
                                                              .detailPesananList[
                                                                  index]
                                                              .hargaPembelianProduk,
                                                          0),
                                                  size: Dimensions.font16,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     var produkIndex = pesananController
                                      //         .detailPesananList[index]
                                      //         .productId!;
                                      //     if (produkIndex >= 0) {
                                      //       Get.toNamed(
                                      //           RouteHelper.getProdukDetail(
                                      //               produkIndex));
                                      //     }
                                      //   },
                                      //   child: Container(
                                      //     padding: EdgeInsets.only(
                                      //         top: Dimensions.height10 / 2,
                                      //         bottom: Dimensions.height10 / 2,
                                      //         left: Dimensions.height10,
                                      //         right: Dimensions.height10),
                                      //     decoration: BoxDecoration(
                                      //         border: Border.all(
                                      //             color: AppColors.redColor),
                                      //         borderRadius:
                                      //             BorderRadius.circular(
                                      //                 Dimensions.radius20 / 2),
                                      //         color: Colors.white),
                                      //     child: BigText(
                                      //       text: "Beli Lagi",
                                      //       size: Dimensions.iconSize16,
                                      //       color: AppColors.redColor,
                                      //     ),
                                      //   ),
                                      // )
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
                    child: Row(
                      children: [
                        BigText(
                          text: "Rincian Pembayaran",
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            BigText(
                              text: "Total Harga",
                              size: Dimensions.font16,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            PriceText(
                              text: CurrencyFormat
                                  .convertToIdr(
                                  detailPesanan[0].hargaPembelian,
                                  0),
                              size: Dimensions.font16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "Total Ongkos Kirim",
                          size: Dimensions.font16,
                        ),
                        PriceText(
                          text: CurrencyFormat
                              .convertToIdr(
                              detailPesanan[0].ongkir,
                              0),
                          size: Dimensions.font16,
                        ),
                      ],
                    ),
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "Total Belanja",
                        size: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                      ),
                      PriceText(
                        text: CurrencyFormat
                            .convertToIdr(
                            detailPesanan[0].hargaPembelian,
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
    );
  }
}
