import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/controllers/pengiriman_controller.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/cart_models.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/price_text.dart';

class PembelianPage extends StatefulWidget {
  const PembelianPage({Key? key}) : super(key: key);

  @override
  State<PembelianPage> createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPage> {
  List<int> _metodePembelian = List<int>.filled(10, 0);
  @override
  Widget build(BuildContext context) {
    List<int?> _carId = [];
    List<int?> _merchantId = [];

    List<int?> _hargaPembelian = [];

    String pengiriman = '';

    @override
    void initState() {
      super.initState();

      pengiriman = 'Pilih Pengiriman';
      // Initialize _metodePembelian with all values set to 0
      var cartController = Get.find<CartController>();
      var _keranjangList = cartController.keranjangList;
      var groupedKeranjangList = <String, List<CartModel>>{};
      var _checkedCartIds = cartController.checkedCartIds;
      var _matchedItems = _keranjangList
          .where((item) => _checkedCartIds.contains(item.cartId))
          .toList();

      // Group items by merchant name
      for (var item in _matchedItems) {
        _carId.add(item.cartId);
        var merchantName = item.namaMerchant!;
        if (groupedKeranjangList[merchantName] == null) {
          groupedKeranjangList[merchantName] = [item];
          _merchantId.add(item.merchantId);
        } else {
          groupedKeranjangList[merchantName]!.add(item);
        }
      }
      if (groupedKeranjangList.isNotEmpty) {
        _metodePembelian = List<int>.filled(groupedKeranjangList.length, 0);
      } else {
        print('groupedKeranjangList is empty!');
      }
    }

    double calculateTotal() {
      var cartController = Get.find<CartController>();
      var _keranjangList = cartController.keranjangList;
      var _checkedCartIds = cartController.checkedCartIds;
      var _matchedItems = _keranjangList
          .where((item) => _checkedCartIds.contains(item.cartId))
          .toList();

      double total = 0.0;
      for (final item in _matchedItems) {
        if (cartController.getCartCheckedStatus(item.productId)) {
          _hargaPembelian.add(item.price * item.jumlahMasukKeranjang);
          total += item.price * item.jumlahMasukKeranjang;
        }
      }
      return total;
    }

    void pilihPengiriman(String pilih) {
      if (pilih == "Ambil Ditempat Rp0") {
        pengiriman = 'Ambil Ditempat Rp0';
        setState(() {
          pengiriman = 'Ambil Ditempat Rp0';
        });
      }
    }

    Future<void> _beliProduk() async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        if (pengiriman == "Pilih Pengiriman") {
          showCustomSnackBar("Silahkan pilih pengiriman", title: "Pengiriman");
        } else {
          var controller = Get.find<PengirimanController>();
          var userController = Get.find<UserController>();
          await userController.getUser();

          controller
              .beliProduk(userController.users.id, _carId, _merchantId,
                  _metodePembelian, _hargaPembelian, "", "", "", "")
              .then((status) async {
            if (status.isSuccess) {
              print("Berhasil");

            } else {
              showCustomSnackBar(status.message);
            }
            Get.toNamed(RouteHelper.getMenungguPembayaranPage());
          });

        }
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
                        Get.toNamed(RouteHelper.getKeranjangPage());
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
                      text: "Pengiriman",
                      size: Dimensions.font20,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "Alamat Pengiriman",
                          size: Dimensions.font16,
                          fontWeight: FontWeight.bold,
                        ),
                        BigText(
                          text: "Pilih Alamat Lain",
                          size: Dimensions.font16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.notification_success,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Divider(color: AppColors.buttonBackgroundColor),
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: "Kampus",
                                size: Dimensions.font16,
                                fontWeight: FontWeight.bold,
                              ),
                              SmallText(text: "Jiso Kim"),
                              SmallText(text: "Institut Teknologi Del")
                            ],
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                    Divider(color: AppColors.buttonBackgroundColor),
                    Container(
                      height: 500,
                      child:
                          GetBuilder<CartController>(builder: (cartController) {
                        var _keranjangList = cartController.keranjangList;
                        var groupedKeranjangList = <String, List<CartModel>>{};
                        var groupedsubTotalList = <String, List<CartModel>>{};
                        var _checkedCartIds = cartController.checkedCartIds;
                        var _matchedItems = _keranjangList
                            .where(
                                (item) => _checkedCartIds.contains(item.cartId))
                            .toList();

                        // Group items by merchant name
                        for (var item in _matchedItems) {
                          _carId.add(item.cartId);
                          var merchantName = item.namaMerchant!;
                          if (groupedKeranjangList[merchantName] == null) {
                            groupedKeranjangList[merchantName] = [item];
                            _merchantId.add(item.merchantId);
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

                              double calculatesubTotal(String merchantName) {
                                var cartController = Get.find<CartController>();
                                var _keranjangList =
                                    cartController.keranjangList;
                                var _checkedCartIds =
                                    cartController.checkedCartIds;
                                var _matchedItems = _keranjangList
                                    .where((item) =>
                                        _checkedCartIds.contains(item.cartId) &&
                                        item.namaMerchant == merchantName)
                                    .toList();

                                double total = 0.0;
                                for (final item in _matchedItems) {
                                  total +=
                                      item.price * item.jumlahMasukKeranjang;
                                }
                                return total;
                              }

                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                        text: "Pesanan " +
                                            merchantItems.length.toString()),
                                    Divider(
                                        color: AppColors.buttonBackgroundColor),
                                    Row(
                                      children: [
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
                                          var item = merchantItems[index];
                                          return Row(
                                            children: [
                                              Container(
                                                width: Dimensions.screenWidth /
                                                    1.35,
                                                height:
                                                    Dimensions.height45 * 2.5,
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        Dimensions.height10 / 2,
                                                    top: Dimensions.height10 /
                                                        2),
                                                padding: EdgeInsets.only(
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .buttonBackgroundColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            var produkIndex =
                                                                item.productId!;
                                                            if (produkIndex >=
                                                                0) {
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
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .width10),
                                                        ExcludeFocus(
                                                          child: Container(
                                                            height: Dimensions
                                                                    .height20 *
                                                                5,
                                                            width: Dimensions
                                                                    .width45 *
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
                                                                Row(
                                                                  children: [
                                                                    SmallText(
                                                                        text:
                                                                            "${item.jumlahMasukKeranjang} barang"),
                                                                  ],
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
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        }),
                                    Divider(
                                        color: AppColors.buttonBackgroundColor),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height10,
                                          bottom: Dimensions.height10,
                                          left: Dimensions.width20,
                                          right: Dimensions.width20),
                                      margin: EdgeInsets.only(
                                          top: Dimensions.height10,
                                          bottom: Dimensions.height20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.redColor),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20 / 2),
                                          color: Colors.white),
                                      child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                            topRight:
                                                                Radius.circular(
                                                                    Dimensions
                                                                        .radius20))),
                                                    height: Dimensions
                                                            .screenHeight /
                                                        4,
                                                    margin: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height30,
                                                        left:
                                                            Dimensions.width20,
                                                        right:
                                                            Dimensions.width20),
                                                    child: Column(
                                                      children: [
                                                        Row(children: [
                                                          AppIcon(
                                                            icon: Icons
                                                                .highlight_remove_sharp,
                                                            size: Dimensions
                                                                .iconSize24,
                                                            iconColor: AppColors
                                                                .redColor,
                                                            backgroundColor:
                                                                Colors.white
                                                                    .withOpacity(
                                                                        0.0),
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions
                                                                .width20,
                                                          ),
                                                          BigText(
                                                            text:
                                                                "Pilih Pengiriman",
                                                            size: Dimensions
                                                                .font26,
                                                          ),
                                                        ]),
                                                        Divider(
                                                            color: AppColors
                                                                .buttonBackgroundColor),
                                                        GestureDetector(
                                                            onTap: () => {
                                                                  setState(() {
                                                                    print("_metodePembelian length: ${_metodePembelian.length}");
                                                                    print("merchantIndex: $merchantIndex");
                                                                    _metodePembelian[
                                                                        merchantIndex] = 1;
                                                                    pengiriman = "Ambil Ditempat Rp0";
                                                                  }),
                                                                  print(
                                                                      _metodePembelian),
                                                                  Navigator.pop(
                                                                      context)
                                                                },
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                  top: Dimensions
                                                                      .height10,
                                                                  bottom: Dimensions
                                                                      .height10,
                                                                  left: Dimensions
                                                                      .width20,
                                                                  right: Dimensions
                                                                      .width20),
                                                              margin: EdgeInsets.only(
                                                                  top: Dimensions
                                                                      .height10,
                                                                  bottom: Dimensions
                                                                      .height20),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .redColor),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions.radius20 /
                                                                              2),
                                                                  color: Colors
                                                                      .white),
                                                              child: Row(
                                                                  children: [
                                                                    BigText(
                                                                      text:
                                                                          "Ambil Ditempat Rp0",
                                                                      size: Dimensions
                                                                          .font16,
                                                                    ),
                                                                  ]),
                                                            )),
                                                        GestureDetector(
                                                          onTap: () => {
                                                            setState(() {
                                                              _metodePembelian[
                                                                  merchantIndex] = 2;
                                                            }),
                                                            print(
                                                                _metodePembelian),
                                                            Navigator.pop(
                                                                context)
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.only(
                                                                top: Dimensions
                                                                    .height10,
                                                                bottom: Dimensions
                                                                    .height10,
                                                                left: Dimensions
                                                                    .width20,
                                                                right: Dimensions
                                                                    .width20),
                                                            margin: EdgeInsets.only(
                                                                top: Dimensions
                                                                    .height10,
                                                                bottom: Dimensions
                                                                    .height20),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .redColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            Dimensions.radius20 /
                                                                                2),
                                                                color: Colors
                                                                    .white),
                                                            child:
                                                                Row(children: [
                                                              BigText(
                                                                text:
                                                                    "Pesanan Dikirim",
                                                                size: Dimensions
                                                                    .font16,
                                                              ),
                                                            ]),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Row(children: [
                                            AppIcon(
                                              icon: Icons
                                                  .directions_bus_filled_outlined,
                                              iconColor: AppColors.redColor,
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.0),
                                            ),
                                            BigText(
                                              text: pengiriman,
                                              size: Dimensions.height15,
                                            ),
                                          ])),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: "Subtotal",
                                          size: Dimensions.font16,
                                        ),
                                        PriceText(
                                          text: CurrencyFormat.convertToIdr(
                                              calculatesubTotal(merchantName),
                                              0),
                                          size: Dimensions.font16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
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
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.redColor),
                        child: GestureDetector(
                            onTap: () {
                              _beliProduk();
                            },
                            child: Row(children: [
                              BigText(
                                text: "Pilih Pembayaran",
                                color: Colors.white,
                                size: Dimensions.height15,
                              ),
                            ])),
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
