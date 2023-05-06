import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/pages/pesanan/detail_pesanan_page.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/pesanan_controller.dart';
import '../../controllers/popular_produk_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

import 'package:get/get.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/price_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/tittle_text.dart';
import '../home/home_page.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
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
    Future<void> _getDetailPesananList(String kode_pembelian) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PesananController>();
        controller.getDetailPesananList(kode_pembelian).then((status) async {
          if (status.isSuccess) {
            Get.to(DetailPesananPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

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
                      Get.to(
                            () => HomePage(initialIndex: 3),
                      );
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
                    text: "Daftar Transaksi",
                    size: Dimensions.font20,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getMenungguPembayaranPage());
              },
              child: Container(
                width: Dimensions.screenWidth,
                margin: EdgeInsets.only(
                    bottom: Dimensions.height10 / 2,
                    top: Dimensions.height10,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                padding: EdgeInsets.all(Dimensions.height10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.redColor),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius20 / 2),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 20,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/indonesian-rupiah.png"))),
                    ),
                    SmallText(
                      text: "Menunggu Pembayaran",
                      size: Dimensions.font20,
                    ),
                    AppIcon(
                      icon: Icons.chevron_right,
                      size: Dimensions.iconSize24,
                      iconColor: AppColors.redColor,
                      backgroundColor: Colors.white.withOpacity(0.0),
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<PesananController>(builder: (pesananController) {
              print(pesananController.pesananList.length);
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: Dimensions.height45 * 5),
                  itemCount: pesananController.pesananList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: Dimensions.screenWidth,
                      height: Dimensions.height45 * 3.5,
                      margin: EdgeInsets.only(
                          bottom: Dimensions.height10,
                          top: Dimensions.height10 / 2,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: AppIcon(
                                          icon: Icons.shopping_bag_outlined,
                                          iconSize: Dimensions.iconSize24,
                                          iconColor: AppColors.redColor,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.0),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                            text: "Belanja",
                                            size: Dimensions.font16,
                                          ),
                                          SmallText(
                                              text: pesananController
                                                  .pesananList[index].name
                                                  .toString()),
                                          Container(
                                              height: Dimensions.height20,
                                              padding: EdgeInsets.only(right: Dimensions.width10, left: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius30),
                                                color: AppColors.notification_success.withOpacity(0.3),
                                              ),
                                              child: Center(
                                                child: BigText(
                                                    text: pesananController
                                                        .pesananList[index].statusPembelian
                                                        .toString(),
                                                    size: Dimensions.font16/1.5,
                                                    color: AppColors.notification_success,
                                                    fontWeight: FontWeight.bold),
                                              )),
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
                                      GestureDetector(
                                        onTap: () {
                                          var produkIndex =
                                          pesananController
                                              .pesananList[index]
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
                                              text: pesananController
                                                  .pesananList[index]
                                                  .productName,
                                              size: Dimensions.font16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SmallText(
                                                  text: "${ pesananController
                                                      .pesananList[index]
                                                      .jumlahPembelianProduk} x "),
                                              PriceText(
                                                text: CurrencyFormat
                                                    .convertToIdr(
                                                    pesananController
                                                        .pesananList[index]
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
                          SizedBox(height: Dimensions.height10,),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          SmallText(text: "Total Belanja"),
                                          PriceText(
                                            text: CurrencyFormat.convertToIdr(
                                                pesananController
                                                    .pesananList[index]
                                                    .hargaPembelian,
                                                0),
                                            size: Dimensions.font16,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _getDetailPesananList(pesananController
                                        .pesananList[index].kodePembelian
                                        .toString());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height10 / 2,
                                        bottom: Dimensions.height10 / 2,
                                        left: Dimensions.height10,
                                        right: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.redColor),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 2),
                                        color: Colors.white),
                                    child: BigText(
                                      text: "Lihat Detail",
                                      size: Dimensions.iconSize16,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),

            // GetBuilder<PesananController>(builder: (pesananController) {
            //   return Expanded(child: ListView.builder(
            //       itemCount: pesananController.pesananList.length,
            //       itemBuilder: (_, index) {
            //         Container(
            //           width: Dimensions.screenWidth,
            //           height: Dimensions.height45 * 3.5,
            //           margin: EdgeInsets.only(
            //               bottom: Dimensions.height10 / 2,
            //               top: Dimensions.height10 / 2,
            //               left: Dimensions.width20,
            //               right: Dimensions.width20),
            //           padding: EdgeInsets.all(Dimensions.height10),
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                   color: AppColors.buttonBackgroundColor),
            //               borderRadius:
            //               BorderRadius.circular(Dimensions.radius20),
            //               color: Colors.white),
            //           child: Column(
            //             children: [
            //               Container(
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Container(
            //                       child: Row(
            //                         children: [
            //                           Container(
            //                             child: AppIcon(
            //                               icon: Icons.shopping_bag_outlined,
            //                               iconSize: Dimensions.iconSize24,
            //                               iconColor: AppColors.redColor,
            //                               backgroundColor:
            //                               Colors.white.withOpacity(0.0),
            //                             ),
            //                           ),
            //                           Column(
            //                             mainAxisAlignment:
            //                             MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                             children: [
            //                               BigText(
            //                                 text: "Belanja",
            //                                 size: Dimensions.font16,
            //                               ),
            //                               SmallText(text: "3 Okt 2021")
            //                             ],
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                     Container(
            //                       padding:
            //                       EdgeInsets.all(Dimensions.height10 / 2),
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(
            //                               Dimensions.radius20 / 2),
            //                           color: AppColors.notification_success),
            //                       child: BigText(
            //                         text: "Selesai",
            //                         size: Dimensions.iconSize16,
            //                         color: Colors.white,
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               Divider(color: AppColors.buttonBackgroundColor),
            //               Container(
            //                 child: BigText(text: "rkt131231"),
            //               ),
            //               Container(
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Container(
            //                       child: Row(
            //                         children: [
            //                           Column(
            //                             mainAxisAlignment:
            //                             MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                             children: [
            //                               SmallText(text: "Total Belanja"),
            //                               PriceText(
            //                                 text: CurrencyFormat.convertToIdr(
            //                                     20000, 0),
            //                                 size: Dimensions.font16,
            //                               ),
            //                             ],
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                     Container(
            //                       padding: EdgeInsets.only(
            //                           top: Dimensions.height10 / 2,
            //                           bottom: Dimensions.height10 / 2,
            //                           left: Dimensions.height10,
            //                           right: Dimensions.height10),
            //                       decoration: BoxDecoration(
            //                           border:
            //                           Border.all(color: AppColors.redColor),
            //                           borderRadius: BorderRadius.circular(
            //                               Dimensions.radius20 / 2),
            //                           color: Colors.white),
            //                       child: BigText(
            //                         text: "Lihat Detail",
            //                         size: Dimensions.iconSize16,
            //                         color: AppColors.redColor,
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       }));
            // })
          ],
        ),
      ),
    );
  }
}
