import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/pembayaran/pembayaran_page.dart';

import '../../base/snackbar_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/pesanan_controller.dart';
import '../../controllers/popular_produk_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/price_text.dart';
import '../../widgets/small_text.dart';
import '../home/home_page.dart';
import 'detail_pesanan_page.dart';

class MenungguPembayaranPage extends StatefulWidget {
  const MenungguPembayaranPage({Key? key}) : super(key: key);

  @override
  State<MenungguPembayaranPage> createState() => _MenungguPembayaranPageState();
}

class _MenungguPembayaranPageState extends State<MenungguPembayaranPage> {
  @override
  void initState() {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<PesananController>().pesananMenungguPembayaranList.toList();
      Get.find<UserController>().getUser();
      Get.find<PesananController>().getPesananMenungguBayaranList();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.find<PesananController>().getPesananMenungguBayaranList();
    Future<void> _getDetailPesananList(int purchaseId) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PesananController>();
        controller.getDetailPesananList(purchaseId).then((status) async {
          if (status.isSuccess) {
            Get.to(PembayaranPage());
          } else {
            AwesomeSnackbarButton("Gagal", status.message, ContentType.failure);
          }
        });
      }
    }

    Future<void> _getDetailPesanan(int purchase_id) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PesananController>();
        controller.getDetailPesananList(purchase_id).then((status) async {
          if (status.isSuccess) {
            Get.to(DetailPesananPage());
          } else {
            AwesomeSnackbarButton("Gagal", status.message, ContentType.failure);
          }
        });
      }
    }

    Future<void> _hapusPesanan(String kode_pembelian) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PesananController>();
        controller.hapusPesanan(kode_pembelian).then((status) async {
          await controller.getPesananMenungguBayaranList();
        });
        controller.getPesananMenungguBayaranList();
      }
    }

    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();

    return Scaffold(
        body: RefreshIndicator(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height30),
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(HomePage(initialIndex: 3));
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
                        Container(
                          child: BigText(
                            text: "Menunggu Pembayaran",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<PesananController>(builder: (pesananController) {
                    return RefreshIndicator(
                        onRefresh: () =>
                            pesananController.getPesananMenungguBayaranList(),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: Dimensions.height45 * 5.5),
                            itemCount: pesananController
                                .pesananMenungguPembayaranList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var gambarproduk =
                                  Get.find<PopularProdukController>()
                                      .imageProdukList
                                      .where(
                                        (produk) =>
                                            produk.productId ==
                                            pesananController
                                                .pesananMenungguPembayaranList[
                                                    index]
                                                .productId,
                                      );
                              return Obx(() => Container(
                                    width: Dimensions.screenWidth,
                                    height: Dimensions.height45 * 3.5,
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10,
                                        top: Dimensions.height10 / 2,
                                        left: Dimensions.width20,
                                        right: Dimensions.width20),
                                    padding:
                                        EdgeInsets.all(Dimensions.height10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors
                                                .buttonBackgroundColor),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 2),
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
                                                    Container(
                                                      child: AppIcon(
                                                        icon: Icons
                                                            .shopping_bag_outlined,
                                                        iconSize: Dimensions
                                                            .iconSize24,
                                                        iconColor:
                                                            AppColors.redColor,
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0.0),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        BigText(
                                                          text: "Belanja",
                                                          size:
                                                              Dimensions.font16,
                                                        ),
                                                        SmallText(
                                                            text: pesananController
                                                                    .pesananMenungguPembayaranList[
                                                                        index]
                                                                    .name
                                                                    .toString() ??
                                                                ""),
                                                        Container(
                                                            height: Dimensions
                                                                .height20,
                                                            padding: EdgeInsets.only(
                                                                right: Dimensions
                                                                    .width10,
                                                                left: Dimensions
                                                                    .width10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .radius30),
                                                              color: AppColors
                                                                  .notification_success
                                                                  .withOpacity(
                                                                      0.3),
                                                            ),
                                                            child: Center(
                                                              child: BigText(
                                                                  text: pesananController
                                                                          .pesananMenungguPembayaranList[
                                                                              index]
                                                                          .statusPembelian
                                                                          .toString() ??
                                                                      "",
                                                                  size: Dimensions
                                                                          .font16 /
                                                                      1.5,
                                                                  color: AppColors
                                                                      .notification_success,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(
                                                    Dimensions.height10 / 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius20 /
                                                                2)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _hapusPesanan(pesananController
                                                            .pesananMenungguPembayaranList[
                                                                index]
                                                            .kodePembelian
                                                            .toString() ??
                                                        "");
                                                  },
                                                  child: AppIcon(
                                                      iconSize:
                                                          Dimensions.iconSize24,
                                                      iconColor:
                                                          AppColors.redColor,
                                                      backgroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                            color: AppColors
                                                .buttonBackgroundColor),
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
                                                                    .pesananMenungguPembayaranList[
                                                                        index]
                                                                    .productId ??
                                                                0;
                                                        if (produkIndex >= 0) {
                                                          Get.find<
                                                                  PopularProdukController>()
                                                              .detailProduk(
                                                                  produkIndex);
                                                        }
                                                      },
                                                      child: Container(
                                                        width: Dimensions
                                                                .height20 *
                                                            3,
                                                        height: Dimensions
                                                                .height20 *
                                                            3,
                                                        margin: EdgeInsets.only(
                                                            top: Dimensions
                                                                .height10),
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: gambarproduk.single.productImageName !=
                                                                              null &&
                                                                          gambarproduk
                                                                              .single
                                                                              .productImageName
                                                                              .isNotEmpty
                                                                      ? NetworkImage(
                                                                          '${AppConstants.BASE_URL_IMAGE}u_file/product_image/${gambarproduk.single.productImageName}',
                                                                        )
                                                                      : AssetImage(
                                                                          "assets/images/logo_rkt.png",
                                                                        ) as ImageProvider<
                                                                          Object>,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        Dimensions
                                                                            .radius20),
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.width20,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: Dimensions
                                                                  .screenWidth /
                                                              1.6,
                                                          child: BigText(
                                                            text: pesananController
                                                                    .pesananMenungguPembayaranList[
                                                                        index]
                                                                    .productName ??
                                                                "",
                                                            size: Dimensions
                                                                .font16,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            SmallText(
                                                                text:
                                                                    "${pesananController.pesananMenungguPembayaranList[index].jumlahPembelianProduk ?? 0} x "),
                                                            PriceText(
                                                              text: CurrencyFormat.convertToIdr(
                                                                  pesananController
                                                                          .pesananMenungguPembayaranList[
                                                                              index]
                                                                          .price ??
                                                                      0,
                                                                  0),
                                                              size: Dimensions
                                                                  .font16,
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
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SmallText(
                                                            text:
                                                                "Total Belanja"),
                                                        PriceText(
                                                          text: CurrencyFormat.convertToIdr(
                                                              pesananController
                                                                      .pesananMenungguPembayaranList[
                                                                          index]
                                                                      .hargaPembelian +
                                                                  pesananController
                                                                      .pesananMenungguPembayaranList[
                                                                          index]
                                                                      .ongkir,
                                                              0),
                                                          size:
                                                              Dimensions.font16,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              pesananController
                                                          .pesananMenungguPembayaranList[
                                                              index]
                                                          .statusPembelian ==
                                                      "Belum Bayar"
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        _getDetailPesananList(
                                                            pesananController
                                                                .pesananMenungguPembayaranList[
                                                                    index]
                                                                .purchaseId);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            top: Dimensions
                                                                    .height10 /
                                                                2,
                                                            bottom: Dimensions
                                                                    .height10 /
                                                                2,
                                                            left: Dimensions
                                                                .height10,
                                                            right: Dimensions
                                                                .height10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .redColor),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                            .radius20 /
                                                                        2),
                                                            color:
                                                                Colors.white),
                                                        child: BigText(
                                                          text: "Bayar",
                                                          size: Dimensions
                                                              .iconSize16,
                                                          color: AppColors
                                                              .redColor,
                                                        ),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        _getDetailPesanan(
                                                            pesananController
                                                                .pesananMenungguPembayaranList[
                                                                    index]
                                                                .purchaseId);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            top: Dimensions
                                                                    .height10 /
                                                                2,
                                                            bottom: Dimensions
                                                                    .height10 /
                                                                2,
                                                            left: Dimensions
                                                                .height10,
                                                            right: Dimensions
                                                                .height10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .redColor),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                            .radius20 /
                                                                        2),
                                                            color:
                                                                Colors.white),
                                                        child: BigText(
                                                          text: "Lihat Detail",
                                                          size: Dimensions
                                                              .iconSize16,
                                                          color: AppColors
                                                              .redColor,
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }));
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
            onRefresh: () =>
                Get.find<PesananController>().getPesananMenungguBayaranList()));
  }
}
