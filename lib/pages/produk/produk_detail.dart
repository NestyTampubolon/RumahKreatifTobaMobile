import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rumah_kreatif_toba/controllers/cart_controller.dart';
import 'package:rumah_kreatif_toba/controllers/popular_produk_controller.dart';
import 'package:rumah_kreatif_toba/pages/keranjang/keranjang_page.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_icon.dart';
import 'package:rumah_kreatif_toba/widgets/expandable_text_widget.dart';
import 'package:rumah_kreatif_toba/widgets/price_text.dart';
import 'package:rumah_kreatif_toba/widgets/tittle_text.dart';

import '../../models/produk_models.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';

class ProdukDetail extends StatelessWidget {
  final int productId;
  const ProdukDetail({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var produkList = Get.find<PopularProdukController>().popularProdukList;
    var daftarproduk = produkList
        .firstWhere((produk) => produk.productId == productId.toInt());

    Get.find<PopularProdukController>()
        .initProduk(daftarproduk, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 60,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.arrow_back),
                  ),
                  GetBuilder<PopularProdukController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.inCartItems >= 1)
                          Get.toNamed(RouteHelper.getKeranjangPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          Get.find<PopularProdukController>().totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.notification,
                                  ))
                              : Container(),
                          Get.find<PopularProdukController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PopularProdukController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  })
                ],
              ),
              pinned: true,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height20),
                        child: PriceText(
                          text: CurrencyFormat.convertToIdr(
                              daftarproduk.price, 0),
                          color: AppColors.blackColor,
                          size: Dimensions.font20,
                        ),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.radius20),
                                topRight:
                                    Radius.circular(Dimensions.radius20))),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: BigText(
                          text: daftarproduk.productName.toString(),
                          color: AppColors.blackColor,
                          size: Dimensions.font20,
                        ),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              backgroundColor: AppColors.redColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/coffee.jpg",
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: AppColors.buttonBackgroundColor),
                  // SizedBox(height: Dimensions.height45,),
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: BigText(
                      text: "Deskripsi",
                      size: Dimensions.font16,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          text: daftarproduk.productDescription.toString()),
                    ),
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius15)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/coffee.jpg"))),
                          ),
                          SizedBox(width: Dimensions.width10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              BigText(
                                text: daftarproduk.namaMerchant.toString(),
                                fontWeight: FontWeight.bold,
                              ),
                              BigText(
                                text: "Toba Samosir",
                                size: Dimensions.font16 / 1.5,
                              ),
                              BigText(
                                text: "Balige",
                                size: Dimensions.font16 / 1.5,
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProdukController>(
          builder: (produk) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimensions.bottomHeightBar,
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      bottom: Dimensions.height10,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2,
                            left: Dimensions.width10,
                            right: Dimensions.width10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.buttonBackgroundColor),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                produk.setQuantity(false);
                              },
                              child: AppIcon(
                                  iconSize: Dimensions.iconSize16,
                                  iconColor: AppColors.redColor,
                                  backgroundColor: Colors.white,
                                  icon: Icons.remove),
                            ),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            BigText(text: produk.inCartItems.toString()),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                produk.setQuantity(true);
                              },
                              child: AppIcon(
                                  iconSize: Dimensions.iconSize16,
                                  iconColor: AppColors.redColor,
                                  backgroundColor: Colors.white,
                                  icon: Icons.add),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2,
                            left: Dimensions.width10,
                            right: Dimensions.width20),
                        child: GestureDetector(
                            onTap: () {
                              produk.addItem(daftarproduk);
                            },
                            child: Row(children: [
                              AppIcon(
                                  iconSize: Dimensions.iconSize16,
                                  iconColor: Colors.white,
                                  backgroundColor: AppColors.redColor,
                                  icon: Icons.add),
                              BigText(
                                text: "Keranjang",
                                color: Colors.white,
                                size: Dimensions.height15,
                              ),
                            ])),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.redColor),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
