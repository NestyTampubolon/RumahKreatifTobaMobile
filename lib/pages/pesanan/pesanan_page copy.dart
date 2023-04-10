import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

// class PesananPage extends StatefulWidget {
//   const PesananPage({Key? key}) : super(key: key);
//
//   @override
//   State<PesananPage> createState() => _PesananPageState();
// }
//
// class _PesananPageState extends State<PesananPage> {
//   @override
//   Widget build(BuildContext context) {
//     bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
//     if (_userLoggedIn) {
//       Get.find<UserController>().getUser();
//       Get.find<PesananController>().getPesanan();
//     }
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(
//                   top: Dimensions.height30,
//                   left: Dimensions.width20,
//                   right: Dimensions.width20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: AppIcon(
//                       icon: Icons.arrow_back,
//                       iconColor: Colors.white,
//                       backgroundColor: AppColors.redColor,
//                       iconSize: Dimensions.iconSize24,
//                     ),
//                   ),
//                   SizedBox(
//                     width: Dimensions.width20,
//                   ),
//                   BigText(
//                     text: "Daftar Transaksi",
//                     size: Dimensions.font20,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: Dimensions.screenWidth,
//               margin: EdgeInsets.only(
//                   bottom: Dimensions.height10 / 2,
//                   top: Dimensions.height10 / 2,
//                   left: Dimensions.width20,
//                   right: Dimensions.width20),
//               padding: EdgeInsets.all(Dimensions.height10),
//               decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.redColor),
//                   borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
//                   color: Colors.white),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 30,
//                     width: 50,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: AssetImage("assets/images/Mandiri.png"))),
//                   ),
//                   SmallText(
//                     text: "Menunggu Pembayaran",
//                     size: Dimensions.font20,
//                   ),
//                   AppIcon(
//                     icon: Icons.chevron_right,
//                     size: Dimensions.iconSize24,
//                     iconColor: AppColors.redColor,
//                     backgroundColor: Colors.white.withOpacity(0.0),
//                   ),
//                 ],
//               ),
//             ),
//             GetBuilder<PopularProdukController>(builder: (produkKategori) {
//               var kategori = "Makanan";
//               return produkKategori.isLoaded
//                   ? GridView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, mainAxisExtent: 256),
//                   itemCount: produkKategori.kategoriProdukList.length,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     if (produkKategori.kategoriProdukList[index].namaKategori.toString() == "$kategori") {
//                       return GestureDetector(
//                         onTap: () {
//                           Get.toNamed(RouteHelper.getProdukDetail(produkKategori.kategoriProdukList[index].productId));
//                         },
//                         child: Container(
//                           width: 150,
//                           height: 300,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 )
//                               ]),
//                           margin: EdgeInsets.only(
//                               left: Dimensions.width20,
//                               right: Dimensions.width20,
//                               bottom: Dimensions.height20,
//                               top: Dimensions.height10
//                           ),
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.toNamed(RouteHelper.getProdukDetail(
//                                   produkKategori.kategoriProdukList[index].productId));
// //                        Get.toNamed(RouteHelper.getProdukDetail(index));
//                             },
//                             child: Column(
//                               mainAxisAlignment:
//                               MainAxisAlignment.start,
//                               crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                               children: [
//                                 //image section
//                                 Container(
//                                   height: 120,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(
//                                               Dimensions.radius15),
//                                           topRight: Radius.circular(
//                                               Dimensions.radius15)),
//                                       image: DecorationImage(
//                                           fit: BoxFit.fill,
//                                           image: AssetImage(
//                                               "assets/images/coffee.jpg"))),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.all(10.0),
//                                   child: Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       BigText(
//                                         text: produkKategori.kategoriProdukList[index]
//                                             .namaKategori.toString(),
//                                         size: Dimensions.font16/1.5,
//                                       ),
//
//                                       TittleText(
//                                         text: produkKategori.kategoriProdukList[index]
//                                             .productName.toString(),
//                                         size: Dimensions.font16,
//                                       ),
//
//                                       SmallText(
//                                         text: produkKategori.kategoriProdukList[index]
//                                             .namaMerchant.toString(),
//                                       ),
//                                       PriceText(
//                                         text: CurrencyFormat.convertToIdr(
//                                             produkKategori.kategoriProdukList[index].price,
//                                             0),
//                                         color: AppColors.redColor,
//                                         size: Dimensions.font16,
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                                 //text container
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return SizedBox.shrink();
//                     }
//                   }
//               )
//                   : CircularProgressIndicator(
//                 color: AppColors.redColor,
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:rumah_kreatif_toba/widgets/price_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';

import '../../controllers/popular_produk_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/tittle_text.dart';

class PesananPageCopy extends StatefulWidget {
  @override
  State<PesananPageCopy> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPageCopy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            GetBuilder<PopularProdukController>(builder: (produkKategori) {
              return produkKategori.isLoaded
                  ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, mainAxisExtent: 256),
                  itemCount: produkKategori.kategoriProdukList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (produkKategori.kategoriProdukList[index].namaKategori.toString() == "Makanan") {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getProdukDetail(produkKategori.kategoriProdukList[index].productId));
                        },
                        child: Container(
                          width: 150,
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.height20,
                              top: Dimensions.height10
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getProdukDetail(
                                  produkKategori.kategoriProdukList[index].productId));
//                        Get.toNamed(RouteHelper.getProdukDetail(index));
                            },
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                //image section
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              Dimensions.radius15),
                                          topRight: Radius.circular(
                                              Dimensions.radius15)),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/images/coffee.jpg"))),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: produkKategori.kategoriProdukList[index]
                                            .namaKategori.toString(),
                                        size: Dimensions.font16/1.5,
                                      ),

                                      TittleText(
                                        text: produkKategori.kategoriProdukList[index]
                                            .productName.toString(),
                                        size: Dimensions.font16,
                                      ),

                                      SmallText(
                                        text: produkKategori.kategoriProdukList[index]
                                            .namaMerchant.toString(),
                                      ),
                                      PriceText(
                                        text: CurrencyFormat.convertToIdr(
                                            produkKategori.kategoriProdukList[index].price,
                                            0),
                                        color: AppColors.redColor,
                                        size: Dimensions.font16,
                                      ),
                                    ],
                                  ),
                                )
                                //text container
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
              )
                  : CircularProgressIndicator(
                color: AppColors.redColor,
              );
            })


            // GetBuilder<PopularProdukController>(builder: (produkKategori) {
            //   return produkKategori.isLoaded
            //       ? Container(
            //           child: ListView.builder(
            //               physics: NeverScrollableScrollPhysics(),
            //               shrinkWrap: true,
            //               itemCount: produkKategori.popularProdukList.length,
            //               itemBuilder: (context, index) {
            //                 if (produkKategori
            //                         .popularProdukList[index].namaKategori
            //                         .toString() ==
            //                     "$kategori") {
            //                   return Container(
            //                     margin: EdgeInsets.only(
            //                         left: Dimensions.width20,
            //                         right: Dimensions.width20,
            //                         bottom: Dimensions.height10),
            //                     child: Row(
            //                       children: [
            //                         Container(
            //                           width: Dimensions.width20 * 6,
            //                           height: Dimensions.height30 * 4,
            //                           decoration: BoxDecoration(
            //                               borderRadius: BorderRadius.circular(
            //                                   Dimensions.radius20),
            //                               color: Colors.white,
            //                               image: DecorationImage(
            //                                   fit: BoxFit.cover,
            //                                   image: AssetImage(
            //                                       "assets/images/kategori_detail/$kategori.png"))),
            //                         ),
            //                         GestureDetector(
            //                           onTap: () {
            //                             Get.toNamed(RouteHelper.getProdukDetail(
            //                                 produkKategori
            //                                     .popularProdukList[index]
            //                                     .productId));
            //                           },
            //                           child: Container(
            //                             height: 100,
            //                             width: Dimensions.width45*5,
            //                             decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.only(
            //                                     topRight: Radius.circular(
            //                                         Dimensions.radius20),
            //                                     bottomRight: Radius.circular(
            //                                         Dimensions.radius20)),
            //                                 color: Colors.white),
            //                             child: Padding(
            //                               padding: EdgeInsets.only(
            //                                   left: Dimensions.width10),
            //                               child: Column(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.center,
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment.start,
            //                                 children: [
            //                                   BigText(
            //                                     text: produkKategori
            //                                         .popularProdukList[index]
            //                                         .productName
            //                                         .toString(), size: Dimensions.font16,
            //                                   ),
            //                                   SmallText(
            //                                       text: produkKategori
            //                                           .popularProdukList[index]
            //                                           .namaMerchant
            //                                           .toString()),
            //                                   PriceText(
            //                                       text: CurrencyFormat
            //                                           .convertToIdr(
            //                                               produkKategori
            //                                                   .popularProdukList[
            //                                                       index]
            //                                                   .price,
            //                                               0), size: Dimensions.font16,),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   );
            //                 } else {
            //                   return Container();
            //                 }
            //               }),
            //         )
            //       : CircularProgressIndicator(
            //           color: AppColors.redColor,
            //         );
            // }),
          ],
        ),
      ),
    );
  }
}

