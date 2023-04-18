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

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  bool? allChecked = false;
  bool? isChecked = false;
  Map<String, bool> map = {};

  @override
  void initState() {
    super.initState();
    var controller = Get.find<CartController>();
    controller.getKeranjangList();
    allChecked = false;
    map = Map.fromIterable(
      Get.find<CartController>()
          .merchantKeranjangList
          .where((item) => item.namaMerchant != null),
      key: (item) => item.namaMerchant,
      value: (item) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _shouldRefreshList = false;
    var cartcontroller = Get.find<CartController>();

    Future<void> _hapusKeranjang(int cart_id) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<CartController>();
        controller.hapusKeranjang(cart_id).then((status) async {
          if (status.isSuccess) {
            showCustomSnackBar("Produk berhasil ditambahkan ke keranjang",
                title: "Berhasil");
            await controller.getKeranjangList();
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
        if (cartController.getCartCheckedStatus(item.productId)) {
          total += item.price * item.jumlahMasukKeranjang;
        }
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
                    // Get.toNamed(RouteHelper.getInitial());
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
                  text: "Keranjang",
                  size: Dimensions.font20,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
                margin: EdgeInsets.only(top: Dimensions.height10 / 2),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    var _keranjangList = cartController.keranjangList;
                    var groupedKeranjangList = <String, List<CartModel>>{};

                    // Group items by merchant name
                    for (var item in _keranjangList) {
                      var merchantName = item.namaMerchant!;
                      if (groupedKeranjangList[merchantName] == null) {
                        groupedKeranjangList[merchantName] = [item];
                      } else {
                        groupedKeranjangList[merchantName]!.add(item);
                      }
                    }

                    return ListView.builder(
                        itemCount: groupedKeranjangList.length,
                        itemBuilder: (_, merchantIndex) {
                          var merchantName = groupedKeranjangList.keys
                              .elementAt(merchantIndex);
                          var merchantItems =
                              groupedKeranjangList[merchantName]!;

                          return Container(
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        activeColor: AppColors.redColor,
                                        value: cartController
                                                .getMerchantCheckedStatus(
                                                    merchantName) &&
                                            merchantItems.every((item) =>
                                                cartController
                                                    .getCartCheckedStatus(
                                                        item.productId)),
                                        onChanged: (bool? value) {
                                          // Set the checked status for the merchant
                                          cartController
                                              .setMerchantCheckedStatus(
                                                  merchantName, value);

                                          // Update the checked status for all items in the merchant's list
                                          for (var item in merchantItems) {
                                            cartController.setCartCheckedStatus(
                                                item.productId, value);
                                          }
                                          setState(() {});
                                        }),
                                    BigText(
                                      text: merchantName,
                                      size: Dimensions.font20,
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: merchantItems.length,
                                    itemBuilder: (_, index) {
                                      CartModel item = merchantItems[index];
                                      return Row(
                                        children: [
                                          Checkbox(
                                              activeColor: AppColors.redColor,
                                              value: cartController
                                                  .getCartCheckedStatus(
                                                      item.productId),
                                              onChanged: (bool? value) {
                                                cartController
                                                    .setCartCheckedStatus(
                                                        item.productId, value);
                                                setState(() {
                                                  // Update the total price
                                                  calculateTotal();
                                                  // If the checkbox is checked, add the cartId to the list

                                                  if (value == true &&
                                                      !cartController
                                                          .checkedCartIds
                                                          .contains(
                                                              item.productId)) {
                                                    cartController
                                                        .checkedCartIds
                                                        .add(item.cartId);
                                                  }
                                                  // If the checkbox is unchecked, remove the productId from the list
                                                  else if (value == false) {
                                                    cartController
                                                        .checkedCartIds
                                                        .remove(item.cartId);
                                                  }
                                                });
                                              }),
                                          Container(
                                            width:
                                                Dimensions.screenWidth / 1.35,
                                            height: 150,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10 / 2,
                                                top: Dimensions.height10 / 2),
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
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        var produkIndex =
                                                            item.productId!;
                                                        if (produkIndex >= 0) {
                                                          Get.toNamed(RouteHelper
                                                              .getProdukDetail(
                                                                  produkIndex));
                                                        }
                                                      },
                                                      child: Container(
                                                        width: Dimensions
                                                                .height20 *
                                                            4,
                                                        height: Dimensions
                                                                .height20 *
                                                            4,
                                                        margin: EdgeInsets.only(
                                                            top: Dimensions
                                                                .height10),
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: AssetImage(
                                                                    "assets/images/coffee.jpg")),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.width10),
                                                    ExcludeFocus(
                                                      child: Container(
                                                        height: Dimensions
                                                                .height20 *
                                                            5,
                                                        width:
                                                            Dimensions.width45 *
                                                                3,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            BigText(
                                                              text: item
                                                                  .productName!,
                                                              size: Dimensions
                                                                      .font26 /
                                                                  1.5,
                                                            ),
                                                            PriceText(
                                                              text: CurrencyFormat
                                                                  .convertToIdr(
                                                                      item.price,
                                                                      0),
                                                              size: Dimensions
                                                                  .font16,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _hapusKeranjang(
                                                            item.cartId!);
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
                                                    Container(
                                                      width:
                                                          Dimensions.width45 *
                                                              3,
                                                      padding: EdgeInsets.only(
                                                          left: Dimensions
                                                              .width10,
                                                          right: Dimensions
                                                              .width10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .buttonBackgroundColor),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Colors.white),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              //produk.setQuantity(false);
                                                              //cartController.addItem(_keranjangList[index].produk!, -1);
                                                              _kurangKeranjang(
                                                                  item.cartId!);
                                                            },
                                                            child: AppIcon(
                                                                iconSize: Dimensions
                                                                    .iconSize24,
                                                                iconColor:
                                                                    AppColors
                                                                        .redColor,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                icon: Icons
                                                                    .remove),
                                                          ),
                                                          BigText(
                                                            text: item
                                                                .jumlahMasukKeranjang
                                                                .toString(),
                                                            size: Dimensions
                                                                    .font26 /
                                                                1.5,
                                                          ), //produk.inCartItems.toString()),
                                                          GestureDetector(
                                                            onTap: () {
                                                              //cartController.addItem(_keranjangList[index].produk!, 1);
                                                              _jumlahKeranjang(
                                                                  item.cartId!);
                                                            },
                                                            child: AppIcon(
                                                                iconSize: Dimensions
                                                                    .iconSize24,
                                                                iconColor:
                                                                    AppColors
                                                                        .redColor,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                icon:
                                                                    Icons.add),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          );
                        });
                  }),
                )),
          )
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
                          onTap: () {
                            Get.toNamed(RouteHelper.getPembelianPage());
                          },
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
      ),
    );
  }

  void onMerchantClicked(String merchantName, bool value) {
    var controller = Get.find<CartController>();
    var merchantItems = controller.merchantKeranjangList.firstWhere(
      (element) => element.namaMerchant == merchantName,
      orElse: () => null,
    );
    if (merchantItems != null) {
      for (var item in merchantItems.items) {
        item.isChecked = value;
      }
    }
  }

  void onItemClicked(String merchantName, CartModel item, bool value) {
    var controller = Get.find<CartController>();
    var merchantItems = controller.merchantKeranjangList.firstWhere(
      (element) => element.namaMerchant == merchantName,
      orElse: () => null,
    );
    if (merchantItems != null) {
      var currentItem = merchantItems.items.firstWhere(
        (element) => element.id == item.id,
        orElse: () => null,
      );
      if (currentItem != null) {
        currentItem.isChecked = value ?? false;
      }
    }
  }

  onAllClicked(ckbItem) {
    final newValue = ckbItem;
    setState(() {
      ckbItem = newValue;
      // checkBoxList.forEach((element){
      //   element.value = newValue;
      // });
      allChecked = ckbItem ?? false;
      print(allChecked);
    });
  }

  // onItemClicked(CheckBoxModal ckbItem){
  //   final newValue = !ckbItem.value;
  //   setState(() {
  //     ckbItem.value = newValue;
  //
  //     if(!newValue){
  //       allChecked.value = false;
  //     }else{
  //       final allListChecked = checkBoxList.every((element) => element.value);
  //       allChecked.value = allListChecked;
  //     }
  //   });
  // }
}

class CheckBoxModal {
  String title;
  bool value;

  CheckBoxModal({required this.title, this.value = false});
}
