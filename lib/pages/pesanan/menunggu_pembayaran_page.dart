import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/pages/pembayaran/pembayaran_page.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/pesanan_controller.dart';
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
      Get.find<UserController>().getUser();
      Get.find<PesananController>().getPesananMenungguBayaranList();
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
            Get.to(PembayaranPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    Future<void> _hapusPesanan(String kode_pembelian) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PesananController>();
        controller.hapusPesanan(kode_pembelian).then((status) async {
          if (status.isSuccess) {
            await controller.getPesananMenungguBayaranList();
          } else {
            showCustomSnackBar(status.message);
          }
        });
        controller.getPesananMenungguBayaranList();
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
                      Get.toNamed(RouteHelper.getPesananPage());
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back,
                      iconColor: AppColors.redColor,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20,
                  ),
                  BigText(
                    text: "Menunggu Pembayaran",
                    size: Dimensions.font20,
                  ),
                ],
              ),
            ),
            GetBuilder<PesananController>(builder: (pesananController) {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, mainAxisExtent: Dimensions.height45*4),
                  itemCount: pesananController.pesananMenungguPembayaranList.length,
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
                                          SmallText(text: pesananController.pesananMenungguPembayaranList[index].createdAt.toString())
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  EdgeInsets.all(Dimensions.height10 / 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20 / 2)),
                                  child: GestureDetector(
                                    onTap: () {
                                      _hapusPesanan(pesananController.pesananMenungguPembayaranList[index].kodePembelian.toString());
                                    },
                                    child: AppIcon(
                                        iconSize: Dimensions
                                            .iconSize24,
                                        iconColor: AppColors
                                            .redColor,
                                        backgroundColor:
                                        Colors.white,
                                        icon: Icons.delete),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(color: AppColors.buttonBackgroundColor),
                          Container(
                            child: BigText(text: pesananController.pesananMenungguPembayaranList[index].kodePembelian.toString()),
                          ),
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
                                                pesananController.pesananMenungguPembayaranList[index].hargaPembelian
                                                , 0),
                                            size: Dimensions.font16,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _getDetailPesananList(pesananController.pesananMenungguPembayaranList[index].kodePembelian.toString());
                                  },
                                  child:Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height10 / 2,
                                        bottom: Dimensions.height10 / 2,
                                        left: Dimensions.height10,
                                        right: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: AppColors.redColor),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 2),
                                        color: Colors.white),
                                    child: BigText(
                                      text: "Bayar",
                                      size: Dimensions.iconSize16,
                                      color: AppColors.redColor,
                                    ),
                                  ) ,
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              );
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
