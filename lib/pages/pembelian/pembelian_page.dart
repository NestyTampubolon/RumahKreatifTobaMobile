import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/controllers/alamat_controller.dart';
import 'package:rumah_kreatif_toba/controllers/pengiriman_controller.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/popular_produk_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/alamat_model.dart';
import '../../models/cart_models.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
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
  @override
  Widget build(BuildContext context) {
    List<int?> _carId = [];
    int _metodePembelian = 1;
    int _hargaPembelian = 0;
    int _merchantId = 0;

    double calculateTotal() {
      var cartController = Get.find<CartController>();
      var _keranjangList = cartController.keranjangList;
      var _checkedCartIds = cartController.checkedCartIds;
      var _matchedItems = _keranjangList
          .where((item) => _checkedCartIds.contains(item.productId))
          .toList();

      double total = 0.0;
      for (final item in _matchedItems) {
        total += item.price * item.jumlahMasukKeranjang;
      }

      return total;
    }

    Future<void> _beliProduk() async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PengirimanController>();
        var userController = Get.find<UserController>().usersList[0];

        controller
            .beliProduk(userController.id, _carId, _merchantId,
                _metodePembelian, _hargaPembelian, "", "", "", "")
            .then((status) async {
          if (status.isSuccess) {
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    Future<void> _getProdukList(int product_id) async {
      var controller = Get.find<PopularProdukController>();
      controller.detailProduk(product_id).then((status) async {});
    }

    Get.find<AlamatController>().getAlamatUser();

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
                      iconColor: AppColors.redColor,
                      backgroundColor: Colors.white,
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
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Container(
                                    width: Dimensions.screenWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 4),
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[200]!,
                                              blurRadius: 5,
                                              spreadRadius: 1)
                                        ]),
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height30,
                                        left: Dimensions.width20,
                                        right: Dimensions.width20),
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: AppIcon(
                                              icon: CupertinoIcons.xmark,
                                              size: Dimensions.iconSize24,
                                              iconColor: AppColors.redColor,
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.0),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width20,
                                          ),
                                          BigText(
                                            text: "Pilih Alamat",
                                            size: Dimensions.font26,
                                          ),
                                        ]),
                                        Divider(
                                            color: AppColors
                                                .buttonBackgroundColor),
                                        GetBuilder<AlamatController>(
                                            builder: (AlamatController) {
                                          return ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: AlamatController
                                                .daftarAlamatList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Alamat alamat = AlamatController
                                                  .daftarAlamatList[index];
                                              return Container(
                                                height: 100,
                                                padding: EdgeInsets.only(
                                                    left: Dimensions.width20,
                                                    right: Dimensions.width20,
                                                    top: Dimensions.height20),
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          //tombol
                                                        });
                                                        print(alamat
                                                            .user_address_id);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        Dimensions.radius20 /
                                                                            4),
                                                            color: Theme.of(context).cardColor,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      200]!,
                                                                  blurRadius: 5,
                                                                  spreadRadius:
                                                                      1)
                                                            ]),
                                                        child: ListTile(
                                                            dense: true,
                                                            title: Text(
                                                              "Alamat ${index + 1}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            subtitle: Text(
                                                                "${alamat.user_street_address?.toString() ?? ""}, ${alamat.city_name?.toString() ?? ""}, ${alamat.province_name?.toString() ?? ""} ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font16,
                                                                )),
                                                            trailing: Icon(
                                                                CupertinoIcons
                                                                    .circle)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Row(
                          children: [
                            BigText(
                              text: "Pilih Alamat Lain",
                              size: Dimensions.font16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.notification_success,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  GetBuilder<AlamatController>(
                    builder: (AlamatController) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: AlamatController.daftarAlamatUserList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Alamat alamat =
                              AlamatController.daftarAlamatUserList[index];
                          return Container(
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${alamat.user_street_address?.toString() ?? ""}, ${alamat.city_name?.toString() ?? ""}",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      "${alamat.province_name?.toString() ?? ""}",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  GetBuilder<CartController>(builder: (cartController) {
                    var _keranjangList = cartController.keranjangList;
                    var groupedKeranjangList = <String, List<CartModel>>{};
                    var _checkedCartIds = cartController.checkedCartIds;
                    var _matchedItems = _keranjangList
                        .where(
                            (item) => _checkedCartIds.contains(item.productId))
                        .toList();

                    if (_matchedItems.isEmpty) {}

                    // Group items by merchant name
                    for (var item in _matchedItems) {
                      _carId.add(item.cartId);
                      var merchantName = item.namaMerchant!;
                      if (groupedKeranjangList[merchantName] == null) {
                        groupedKeranjangList[merchantName] = [item];
                        _merchantId = item.merchantId;
                      } else {
                        groupedKeranjangList[merchantName]!.add(item);
                      }
                    }

                    int calculatesubTotal(String merchantName) {
                      var cartController = Get.find<CartController>();
                      var _keranjangList = cartController.keranjangList;
                      var _checkedCartIds = cartController.checkedCartIds;
                      var _matchedItems = _keranjangList
                          .where((item) =>
                              _checkedCartIds.contains(item.productId) &&
                              item.namaMerchant == merchantName)
                          .toList();

                      double total = 0.0;
                      for (final item in _matchedItems) {
                        total += item.price * item.jumlahMasukKeranjang;
                      }

                      return total.toInt();
                    }

                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: groupedKeranjangList.length,
                        shrinkWrap: true,
                        itemBuilder: (_, merchantIndex) {
                          var merchantName = groupedKeranjangList.keys
                              .elementAt(merchantIndex);
                          var merchantItems =
                              groupedKeranjangList[merchantName]!;

                          _hargaPembelian = calculatesubTotal(merchantName);

                          return Container(
                            margin: EdgeInsets.only(
                                bottom: Dimensions.height10,
                                top: Dimensions.height10 / 2,
                                left: Dimensions.width10 / 2,
                                right: Dimensions.width10 / 2),
                            padding: EdgeInsets.all(Dimensions.height10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.buttonBackgroundColor),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                    text: "Pesanan " +
                                        merchantItems.length.toString()),
                                Divider(color: AppColors.buttonBackgroundColor),
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
                                    var gambarproduk =
                                        Get.find<PopularProdukController>()
                                            .imageProdukList
                                            .where((produk) =>
                                                produk.productId ==
                                                item.productId);
                                    return Row(
                                      children: [
                                        Container(
                                          width: Dimensions.screenWidth / 1.35,
                                          height: Dimensions.height45 * 2.5,
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
                                                        _getProdukList(
                                                            item.productId!);
                                                      }
                                                    },
                                                    child: Container(
                                                      width:
                                                          Dimensions.height20 *
                                                              4,
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      margin: EdgeInsets.only(
                                                          top: Dimensions
                                                              .height10),
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              '${AppConstants.BASE_URL_IMAGE}u_file/product_image/${gambarproduk.single.productImageName}',
                                                            ),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10),
                                                  ExcludeFocus(
                                                    child: Container(
                                                      height:
                                                          Dimensions.height20 *
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
                                                          Row(
                                                            children: [
                                                              SmallText(
                                                                  text:
                                                                      "${item.jumlahMasukKeranjang} barang"),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SmallText(
                                                                  text:
                                                                      "${item.heavy} gr")
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
                                  },
                                ),
                                Divider(color: AppColors.buttonBackgroundColor),
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
                                      border:
                                          Border.all(color: AppColors.redColor),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20 / 2),
                                      color: Colors.white),
                                  child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return SingleChildScrollView(
                                                child: Container(
                                                  width: Dimensions.screenWidth,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          Dimensions.radius20),
                                                      topRight: Radius.circular(
                                                          Dimensions.radius20),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: Dimensions.height30,
                                                      left: Dimensions.width20,
                                                      right:
                                                          Dimensions.width20),
                                                  child: Column(
                                                    children: [
                                                      Row(children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: AppIcon(
                                                            icon: CupertinoIcons
                                                                .xmark,
                                                            size: Dimensions
                                                                .iconSize24,
                                                            iconColor: AppColors
                                                                .redColor,
                                                            backgroundColor:
                                                                Colors.white
                                                                    .withOpacity(
                                                                        0.0),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                              .width20,
                                                        ),
                                                        BigText(
                                                          text:
                                                              "Pilih Pengiriman",
                                                          size:
                                                              Dimensions.font26,
                                                        ),
                                                      ]),
                                                      Divider(
                                                          color: AppColors
                                                              .buttonBackgroundColor),
                                                      Container(
                                                        height: 200,
                                                        padding: EdgeInsets.only(
                                                            left: Dimensions
                                                                .width20,
                                                            right: Dimensions
                                                                .width20,
                                                            top: Dimensions
                                                                .height20),
                                                        child: Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  Get.find<
                                                                          PengirimanController>()
                                                                      .setTypePengiriman(
                                                                          merchantIndex,
                                                                          "Ambil Ditempat");
                                                                  Get.find<
                                                                          PengirimanController>()
                                                                      .setPaymentIndex(
                                                                          1);
                                                                  _metodePembelian =
                                                                      1;
                                                                });
                                                                print(
                                                                    _metodePembelian);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(Dimensions.radius20 / 4),
                                                                    color: Theme.of(context).cardColor,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey[
                                                                              200]!,
                                                                          blurRadius:
                                                                              5,
                                                                          spreadRadius:
                                                                              1)
                                                                    ]),
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                    Icons.money,
                                                                    size: 40,
                                                                    color: Get.find<PengirimanController>().paymentIndex ==
                                                                            1
                                                                        ? AppColors
                                                                            .redColor
                                                                        : Theme.of(context)
                                                                            .disabledColor,
                                                                  ),
                                                                  title: Text(
                                                                    "Ambil Ditempat Rp0",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Dimensions.font20),
                                                                  ),
                                                                  trailing: Get.find<PengirimanController>()
                                                                              .paymentIndex ==
                                                                          1
                                                                      ? Icon(
                                                                          Icons
                                                                              .check_circle,
                                                                          color:
                                                                              Theme.of(context).primaryColor)
                                                                      : null,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .height10),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  Get.find<
                                                                          PengirimanController>()
                                                                      .setTypePengiriman(
                                                                          merchantIndex,
                                                                          "Pesanan Dikirim + Ongkir : 2k ");

                                                                  Get.find<
                                                                          PengirimanController>()
                                                                      .setPaymentIndex(
                                                                          2);
                                                                  _metodePembelian =
                                                                      2;
                                                                });
                                                                print(
                                                                    _metodePembelian);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(Dimensions.radius20 / 4),
                                                                    color: Theme.of(context).cardColor,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey[
                                                                              200]!,
                                                                          blurRadius:
                                                                              5,
                                                                          spreadRadius:
                                                                              1)
                                                                    ]),
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                    Icons.money,
                                                                    size: 40,
                                                                    color: Get.find<PengirimanController>().paymentIndex ==
                                                                            2
                                                                        ? AppColors
                                                                            .redColor
                                                                        : Theme.of(context)
                                                                            .disabledColor,
                                                                  ),
                                                                  title: Text(
                                                                    "Pesanan Dikirim",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Dimensions.font20),
                                                                  ),
                                                                  trailing: Get.find<PengirimanController>()
                                                                              .paymentIndex ==
                                                                          2
                                                                      ? Icon(
                                                                          Icons
                                                                              .check_circle,
                                                                          color:
                                                                              Theme.of(context).primaryColor)
                                                                      : null,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Row(children: [
                                        AppIcon(
                                          icon: Icons.note,
                                          iconColor: AppColors.redColor,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.0),
                                        ),
                                        BigText(
                                          text: Get.find<PengirimanController>()
                                              .checkedtypePengiriman[
                                                  merchantIndex]
                                              .toString(),
                                          size: Dimensions.height15,
                                        ),
                                      ])),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
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
                              text: "Beli Sekarang",
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
      ),
    );
  }
}
Widget _pilihpengiriman() {
  return DropdownSearch<Map<String, dynamic>>(
    mode: Mode.MENU,
    showClearButton: true,
    label: "Tipe Kurir",
    hint : "Pilih tipe pengiriman...",
    showSearchBox: true,
    items: [
      {
      "code" : "jne",
      "name" : "PT Tiki Jalur Nugraha Ekakurir (JNE)"
      },
      {
        "code" : "pos",
        "name" : "Perusahaan Opsional Surat (POS Indonesia)"
      },
      {
        "code" : "tiki",
        "name" : "Titipan Kilat (TIKI)"
      }
    ],
    dropdownSearchDecoration: InputDecoration(labelText: "Pengiriman"),
    onChanged:(value) => print(value),
    itemAsString: (item) => "${item?['name']}",
    popupItemBuilder: (context, item, isSelected) =>
        Container(
          padding: EdgeInsets.all(20),
          child: Text("${item['name']}",
            style: TextStyle(
            fontSize: 18,
            ),
          ),
    ),
  );
}

