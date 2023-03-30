import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/cart_controller.dart';
import 'package:rumah_kreatif_toba/controllers/popular_produk_controller.dart';
import 'package:rumah_kreatif_toba/models/cart_models.dart';
import 'package:rumah_kreatif_toba/pages/home/main_home_page.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_icon.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:rumah_kreatif_toba/widgets/price_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/currency_format.dart';

class KeranjangPageCopy extends StatefulWidget {
  const KeranjangPageCopy({Key? key}) : super(key: key);

  @override
  State<KeranjangPageCopy> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPageCopy> {
  @override
  void initState() {
    super.initState();
    var controller = Get.find<CartController>();
    controller.getKeranjangList();

    print('hello world');
  }

  StreamController<void> _refreshController =
      StreamController<void>.broadcast();
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    bool _shouldRefreshList = false;
    var cartcontroller = Get.find<CartController>();

    void _update() {
      setState(() {});
    }

    Future<void> _hapusKeranjang(int cart_id) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<CartController>();
        controller.hapusKeranjang(cart_id).then((status) async {
          if (status.isSuccess) {
            showCustomSnackBar("Produk berhasil ditambahkan ke keranjang",
                title: "Berhasil");
            await controller.getKeranjangList();
            _update();
          } else {
            showCustomSnackBar(status.message);
          }
        });
        controller.getKeranjangList();
      }
    }

    Future<void> _kurangKeranjang(int cart_id) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<CartController>();
        controller.kurangKeranjang(cart_id).then((status) async {
          if (status.isSuccess) {
            await controller.getKeranjangList();
            initState();
          } else {
            showCustomSnackBar(status.message);
          }
        });
        controller.getKeranjangList();
      }
    }

    Future<void> _jumlahKeranjang(int cart_id) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        final controller = Get.find<CartController>();
        controller.jumlahKeranjang(cart_id).then((status) async {
          if (status.isSuccess) {
            await controller.getKeranjangList();
            initState();
          } else {
            showCustomSnackBar(status.message);
          }
        });
        controller.getKeranjangList();
      }
    }

    double calculateTotal() {
      double total = 0.0;
      final cartController = Get.find<CartController>();
      for (final item in cartController.keranjangList) {
        total += item.price * item.jumlahMasukKeranjang;
      }
      return total;
    }

    int jumlahMasukKeranjang(index) {
      return cartcontroller.keranjangList[index].jumlahMasukKeranjang;
    }

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
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
                      text: "Keranjang",
                      size: Dimensions.font20,
                    ),
                  ],
                )),
            // Positioned(
            //     top: Dimensions.height20 * 3,
            //     left: Dimensions.width20,
            //     right: Dimensions.width20,
            //     bottom: 0,
            //     child: Container(
            //       margin: EdgeInsets.only(top: Dimensions.height15),
            //       child: RefreshIndicator(
            //           onRefresh: () async {
            //             var controller = Get.find<CartController>();
            //             await controller.getKeranjangList();
            //           },
            //           child: GroupedListView<CartModel, String>(
            //             elements:
            //             cartcontroller.keranjangList.cast<CartModel>(),
            //             groupBy: (CartModel element) =>
            //             element.namaMerchant!,
            //             groupSeparatorBuilder: (groupByValue) => Padding(
            //               padding: EdgeInsets.all(8),
            //               child: Row(
            //                 children: [
            //                   Container(
            //                     margin: EdgeInsets.only(
            //                         bottom: Dimensions.height10 / 2,
            //                         top: Dimensions.height10 / 2),
            //                     child: BigText(
            //                       text: groupByValue,
            //                       size: Dimensions.font16,
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             itemBuilder: (context, CartModel element) {
            //               return Container(
            //                 width: double.maxFinite,
            //                 height: 150,
            //                 margin: EdgeInsets.only(
            //                     bottom: Dimensions.height10 / 2,
            //                     top: Dimensions.height10 / 2),
            //                 padding: EdgeInsets.only(
            //                     left: Dimensions.width20,
            //                     right: Dimensions.width20),
            //                 decoration: BoxDecoration(
            //                     border: Border.all(
            //                         color: AppColors.buttonBackgroundColor),
            //                     borderRadius: BorderRadius.circular(
            //                         Dimensions.radius20),
            //                     color: Colors.white),
            //                 child: Column(
            //                   children: [
            //                     Row(
            //                       children: [
            //                         GestureDetector(
            //                           onTap: () {
            //                             var produkIndex =
            //                             element.productId!;
            //                             if (produkIndex >= 0) {
            //                               Get.toNamed(
            //                                   RouteHelper.getProdukDetail(
            //                                       produkIndex));
            //                             }
            //                           },
            //                           child: Container(
            //                             width: Dimensions.height20 * 5,
            //                             height: Dimensions.height20 * 5,
            //                             margin: EdgeInsets.only(
            //                                 top: Dimensions.height10),
            //                             decoration: BoxDecoration(
            //                                 image: DecorationImage(
            //                                     fit: BoxFit.cover,
            //                                     image: AssetImage(
            //                                         "assets/images/coffee.jpg")),
            //                                 borderRadius:
            //                                 BorderRadius.circular(
            //                                     Dimensions.radius20),
            //                                 color: Colors.white),
            //                           ),
            //                         ),
            //                         SizedBox(width: Dimensions.width10),
            //                         ExcludeFocus(
            //                           child: Container(
            //                             height: Dimensions.height20 * 5,
            //                             width: Dimensions.width45 * 4,
            //                             child: Column(
            //                               crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                               mainAxisAlignment:
            //                               MainAxisAlignment.spaceEvenly,
            //                               children: [
            //                                 BigText(
            //                                   text: element.productName!,
            //                                   size: Dimensions.font26 / 1.5,
            //                                 ),
            //                                 PriceText(
            //                                   text: CurrencyFormat
            //                                       .convertToIdr(
            //                                       element.price, 0),
            //                                   size: Dimensions.font16,
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.end,
            //                       children: [
            //                         GestureDetector(
            //                           onTap: () {
            //                             //produk.setQuantity(false);
            //                             //cartController.addItem(_keranjangList[index].produk!, -1);
            //                             _hapusKeranjang(element.cartId!);
            //                             _update();
            //                           },
            //                           child: AppIcon(
            //                               iconSize: Dimensions.iconSize24,
            //                               iconColor: AppColors.redColor,
            //                               backgroundColor: Colors.white,
            //                               icon: Icons.delete),
            //                         ),
            //                         Container(
            //                           width: Dimensions.width45 * 3,
            //                           padding: EdgeInsets.only(
            //                               left: Dimensions.width10,
            //                               right: Dimensions.width10),
            //                           decoration: BoxDecoration(
            //                               border: Border.all(
            //                                   color: AppColors
            //                                       .buttonBackgroundColor),
            //                               borderRadius:
            //                               BorderRadius.circular(
            //                                   Dimensions.radius20),
            //                               color: Colors.white),
            //                           child: Row(
            //                             mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               GestureDetector(
            //                                 onTap: () {
            //                                   //produk.setQuantity(false);
            //                                   //cartController.addItem(_keranjangList[index].produk!, -1);
            //                                   _kurangKeranjang(
            //                                       element.cartId!);
            //                                 },
            //                                 child: AppIcon(
            //                                     iconSize:
            //                                     Dimensions.iconSize24,
            //                                     iconColor:
            //                                     AppColors.redColor,
            //                                     backgroundColor:
            //                                     Colors.white,
            //                                     icon: Icons.remove),
            //                               ),
            //                               BigText(
            //                                 text: element
            //                                     .jumlahMasukKeranjang
            //                                     .toString(),
            //                                 size: Dimensions.font26 / 1.5,
            //                               ), //produk.inCartItems.toString()),
            //                               GestureDetector(
            //                                 onTap: () {
            //                                   //cartController.addItem(_keranjangList[index].produk!, 1);
            //                                   _jumlahKeranjang(
            //                                       element.cartId!);
            //                                 },
            //                                 child: AppIcon(
            //                                     iconSize:
            //                                     Dimensions.iconSize24,
            //                                     iconColor:
            //                                     AppColors.redColor,
            //                                     backgroundColor:
            //                                     Colors.white,
            //                                     icon: Icons.add),
            //                               )
            //                             ],
            //                           ),
            //                         )
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //               );
            //             },
            //             useStickyGroupSeparators: false, // optional
            //             floatingHeader: true, // optional
            //             order: GroupedListOrder.ASC, // optional
            //           )),
            //     )),
            Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child:
                        GetBuilder<CartController>(builder: (cartController) {
                      var _keranjangList = cartController.getItems;
                      return ListView.builder(
                          itemCount: cartController.getItems.length,
                          itemBuilder: (_, index) {
                            String currentMerchantName = cartController
                                .merchantKeranjangList[index].merchantName!;
                            List merchantItems = cartController
                                .merchantKeranjangList
                                .where((item) =>
                                    item.merchantName == currentMerchantName)
                                .toList();

                            return ExpansionTile(
                              title: Text(currentMerchantName),
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: merchantItems.length,
                                    itemBuilder: (_, index) {
                                      CartModel item = merchantItems[index];
                                      return Container(
                                        width: double.maxFinite,
                                        height: 150,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10 / 2,
                                            top: Dimensions.height10 / 2),
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width20,
                                            right: Dimensions.width20),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.buttonBackgroundColor),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    var produkIndex =
                                                    item.productId!;
                                                    if (produkIndex >= 0) {
                                                      Get.toNamed(
                                                          RouteHelper.getProdukDetail(
                                                              produkIndex));
                                                    }
                                                  },
                                                  child: Container(
                                                    width: Dimensions.height20 * 5,
                                                    height: Dimensions.height20 * 5,
                                                    margin: EdgeInsets.only(
                                                        top: Dimensions.height10),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                "assets/images/coffee.jpg")),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions.radius20),
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(width: Dimensions.width10),
                                                ExcludeFocus(
                                                  child: Container(
                                                    height: Dimensions.height20 * 5,
                                                    width: Dimensions.width45 * 4,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        BigText(
                                                          text: item.productName!,
                                                          size: Dimensions.font26 / 1.5,
                                                        ),
                                                        PriceText(
                                                          text: CurrencyFormat
                                                              .convertToIdr(
                                                              item.price, 0),
                                                          size: Dimensions.font16,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    //produk.setQuantity(false);
                                                    //cartController.addItem(_keranjangList[index].produk!, -1);
                                                    _hapusKeranjang(item.cartId!);
                                                    _update();
                                                  },
                                                  child: AppIcon(
                                                      iconSize: Dimensions.iconSize24,
                                                      iconColor: AppColors.redColor,
                                                      backgroundColor: Colors.white,
                                                      icon: Icons.delete),
                                                ),
                                                Container(
                                                  width: Dimensions.width45 * 3,
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width10,
                                                      right: Dimensions.width10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .buttonBackgroundColor),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                      color: Colors.white),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          //produk.setQuantity(false);
                                                          //cartController.addItem(_keranjangList[index].produk!, -1);
                                                          _kurangKeranjang(
                                                              item.cartId!);
                                                        },
                                                        child: AppIcon(
                                                            iconSize:
                                                            Dimensions.iconSize24,
                                                            iconColor:
                                                            AppColors.redColor,
                                                            backgroundColor:
                                                            Colors.white,
                                                            icon: Icons.remove),
                                                      ),
                                                      BigText(
                                                        text: item
                                                            .jumlahMasukKeranjang
                                                            .toString(),
                                                        size: Dimensions.font26 / 1.5,
                                                      ), //produk.inCartItems.toString()),
                                                      GestureDetector(
                                                        onTap: () {
                                                          //cartController.addItem(_keranjangList[index].produk!, 1);
                                                          _jumlahKeranjang(
                                                              item.cartId!);
                                                        },
                                                        child: AppIcon(
                                                            iconSize:
                                                            Dimensions.iconSize24,
                                                            iconColor:
                                                            AppColors.redColor,
                                                            backgroundColor:
                                                            Colors.white,
                                                            icon: Icons.add),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            );
                          });
                    }),
                  ),
                )),
            // Positioned(
            //     top: Dimensions.height20 * 5,
            //     left: Dimensions.width20,
            //     right: Dimensions.width20,
            //     bottom: 0,
            //     child: Container(
            //       margin: EdgeInsets.only(top: Dimensions.height15),
            //       child: MediaQuery.removePadding(
            //         context: context,
            //         removeTop: true,
            //         child:
            //             GetBuilder<CartController>(builder: (cartController) {
            //           var _keranjangList = cartController.getItems;
            //           return ListView.builder(
            //               itemCount: cartController.getItems.length,
            //               itemBuilder: (_, index) {
            //                 String currentMerchantName = cartController
            //                     .merchantKeranjangList[index].merchantName!;
            //                 List merchantItems = cartController
            //                     .keranjangList
            //                     .where((item) =>
            //                         item.merchantName == currentMerchantName)
            //                     .toList();
            //                 print(merchantItems);
            //
            //                 return ExpansionTile(
            //                   title: Text(currentMerchantName),
            //                   children: [
            //                     ListView.builder(
            //                         shrinkWrap: true,
            //                         physics: ClampingScrollPhysics(),
            //                         itemCount: merchantItems.length,
            //                         itemBuilder: (_, index) {
            //                           CartModel item = merchantItems[index];
            //                           print(merchantItems);
            //                           return Container(
            //                             width: double.maxFinite,
            //                             height: 150,
            //                             margin: EdgeInsets.only(
            //                                 bottom: Dimensions.height10 / 2,
            //                                 top: Dimensions.height10 / 2),
            //                             padding: EdgeInsets.only(
            //                                 left: Dimensions.width20,
            //                                 right: Dimensions.width20),
            //                             decoration: BoxDecoration(
            //                                 border: Border.all(
            //                                     color: AppColors.buttonBackgroundColor),
            //                                 borderRadius: BorderRadius.circular(
            //                                     Dimensions.radius20),
            //                                 color: Colors.white),
            //                             child: Column(
            //                               children: [
            //                                 Row(
            //                                   children: [
            //                                     GestureDetector(
            //                                       onTap: () {
            //                                         var produkIndex =
            //                                         item.productId!;
            //                                         if (produkIndex >= 0) {
            //                                           Get.toNamed(
            //                                               RouteHelper.getProdukDetail(
            //                                                   produkIndex));
            //                                         }
            //                                       },
            //                                       child: Container(
            //                                         width: Dimensions.height20 * 5,
            //                                         height: Dimensions.height20 * 5,
            //                                         margin: EdgeInsets.only(
            //                                             top: Dimensions.height10),
            //                                         decoration: BoxDecoration(
            //                                             image: DecorationImage(
            //                                                 fit: BoxFit.cover,
            //                                                 image: AssetImage(
            //                                                     "assets/images/coffee.jpg")),
            //                                             borderRadius:
            //                                             BorderRadius.circular(
            //                                                 Dimensions.radius20),
            //                                             color: Colors.white),
            //                                       ),
            //                                     ),
            //                                     SizedBox(width: Dimensions.width10),
            //                                     ExcludeFocus(
            //                                       child: Container(
            //                                         height: Dimensions.height20 * 5,
            //                                         width: Dimensions.width45 * 4,
            //                                         child: Column(
            //                                           crossAxisAlignment:
            //                                           CrossAxisAlignment.start,
            //                                           mainAxisAlignment:
            //                                           MainAxisAlignment.spaceEvenly,
            //                                           children: [
            //                                             BigText(
            //                                               text: item.productName!,
            //                                               size: Dimensions.font26 / 1.5,
            //                                             ),
            //                                             PriceText(
            //                                               text: CurrencyFormat
            //                                                   .convertToIdr(
            //                                                   item.price, 0),
            //                                               size: Dimensions.font16,
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ],
            //                                 ),
            //                                 Row(
            //                                   mainAxisAlignment: MainAxisAlignment.end,
            //                                   children: [
            //                                     GestureDetector(
            //                                       onTap: () {
            //                                         //produk.setQuantity(false);
            //                                         //cartController.addItem(_keranjangList[index].produk!, -1);
            //                                         _hapusKeranjang(item.cartId!);
            //                                         _update();
            //                                       },
            //                                       child: AppIcon(
            //                                           iconSize: Dimensions.iconSize24,
            //                                           iconColor: AppColors.redColor,
            //                                           backgroundColor: Colors.white,
            //                                           icon: Icons.delete),
            //                                     ),
            //                                     Container(
            //                                       width: Dimensions.width45 * 3,
            //                                       padding: EdgeInsets.only(
            //                                           left: Dimensions.width10,
            //                                           right: Dimensions.width10),
            //                                       decoration: BoxDecoration(
            //                                           border: Border.all(
            //                                               color: AppColors
            //                                                   .buttonBackgroundColor),
            //                                           borderRadius:
            //                                           BorderRadius.circular(
            //                                               Dimensions.radius20),
            //                                           color: Colors.white),
            //                                       child: Row(
            //                                         mainAxisAlignment:
            //                                         MainAxisAlignment.spaceBetween,
            //                                         children: [
            //                                           GestureDetector(
            //                                             onTap: () {
            //                                               //produk.setQuantity(false);
            //                                               //cartController.addItem(_keranjangList[index].produk!, -1);
            //                                               _kurangKeranjang(
            //                                                   item.cartId!);
            //                                             },
            //                                             child: AppIcon(
            //                                                 iconSize:
            //                                                 Dimensions.iconSize24,
            //                                                 iconColor:
            //                                                 AppColors.redColor,
            //                                                 backgroundColor:
            //                                                 Colors.white,
            //                                                 icon: Icons.remove),
            //                                           ),
            //                                           BigText(
            //                                             text: item
            //                                                 .jumlahMasukKeranjang
            //                                                 .toString(),
            //                                             size: Dimensions.font26 / 1.5,
            //                                           ), //produk.inCartItems.toString()),
            //                                           GestureDetector(
            //                                             onTap: () {
            //                                               //cartController.addItem(_keranjangList[index].produk!, 1);
            //                                               _jumlahKeranjang(
            //                                                   item.cartId!);
            //                                             },
            //                                             child: AppIcon(
            //                                                 iconSize:
            //                                                 Dimensions.iconSize24,
            //                                                 iconColor:
            //                                                 AppColors.redColor,
            //                                                 backgroundColor:
            //                                                 Colors.white,
            //                                                 icon: Icons.add),
            //                                           )
            //                                         ],
            //                                       ),
            //                                     )
            //                                   ],
            //                                 )
            //                               ],
            //                             ),
            //                           );
            //                         }),
            //                   ],
            //                 );
            //               });
            //         }),
            //       ),
            //     ))
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimensions.height45 * 2,
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
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.buttonBackgroundColor),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            PriceText(
                              text: CurrencyFormat.convertToIdr(
                                  calculateTotal(), 0),
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: GestureDetector(
                            onTap: () {},
                            child: Row(children: [
                              BigText(
                                text: "Checkout",
                                color: Colors.white,
                                size: Dimensions.height15,
                              ),
                            ])),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.redColor),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
