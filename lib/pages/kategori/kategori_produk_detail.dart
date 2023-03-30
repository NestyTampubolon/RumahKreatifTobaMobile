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
import 'kategori_produk.dart';

class KategoriProdukDetail extends StatefulWidget {
  @override
  State<KategoriProdukDetail> createState() => _KategoriProdukDetailState();
}

class _KategoriProdukDetailState extends State<KategoriProdukDetail> {
  var kategori = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(kategori);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                            Get.to(() => HomePage());
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
                    Center(
                        child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.redColor),
                    ))
                  ],
                ),
              ),
            ),
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                          "assets/images/kategori_detail/$kategori.png"))),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),

            Divider(color: AppColors.buttonBackgroundColor),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width10 / 4,
                      top: Dimensions.height10 / 2,
                      bottom: Dimensions.height10 / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage("assets/images/kategori/$kategori.png")),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BigText(text: "$kategori", size: Dimensions.font20 * 1.5),
                    ],
                  ),
                ),
              ],
            ),

            GetBuilder<PopularProdukController>(builder: (produkKategori) {
              return produkKategori.isLoaded
                  ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 256),
                  itemCount: produkKategori.kategoriProdukList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (produkKategori.kategoriProdukList[index].namaKategori.toString() == "$kategori") {
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
