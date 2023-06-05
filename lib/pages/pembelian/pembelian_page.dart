import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rumah_kreatif_toba/helper/dependencies.dart';
import '../../base/show_custom_message.dart';
import '../../base/snackbar_message.dart';
import '../../controllers/alamat_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/pengiriman_controller.dart';
import '../../controllers/popular_produk_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/alamat_model.dart';
import '../../models/cart_models.dart';
import '../../models/courier_models.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/pengiriman_option_button.dart';
import '../../widgets/price_text.dart';
import '../../widgets/small_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
class PembelianPageState extends StatefulWidget {
  const PembelianPageState({Key? key}) : super(key: key);

  @override
  State<PembelianPageState> createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPageState> {
  AlamatController controller = Get.find<AlamatController>();
  var subAsalId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("INIT BELI");
    controller.getAlamatUser();
  }

  @override
  Widget build(BuildContext context) {
    List<int?> _carId = [];
    int _metodePembelian = 1;
    int _hargaPembelian = 0;
    int _merchantId = 0;
    int selectedValue = 0;

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
        var courier = Get.find<AlamatController>().kurir.value;
        var service = Get.find<AlamatController>().service.value;
        var alamat = Get.find<AlamatController>().alamatID.value;
        var ongkir = Get.find<AlamatController>().HargaPengiriman.value;

        if(controller.paymentIndex.value == 1){
          controller
              .beliProduk(userController.id, _carId, _merchantId,
              1, _hargaPembelian, "", 0, "", "", 0)
              .then((status) async {
            if (status.isSuccess) {
            } else {
              showCustomSnackBar(status.message);
            }
          });
        }else if(controller.paymentIndex.value == 2){
          if(alamat == 0 ){
            AwesomeSnackbarButton("Gagal","Alamat masih kosong",ContentType.failure);
          }else if(courier == 0){
            AwesomeSnackbarButton("Gagal","Courir masih kosong",ContentType.failure);
          }else if(service == null){
            AwesomeSnackbarButton("Gagal","Service masih kosong",ContentType.failure);
          }else if(ongkir == null){
            AwesomeSnackbarButton("Gagal","Ongkos kirim masih kosong",ContentType.failure);
          }else{
            controller
                .beliProduk(userController.id, _carId, _merchantId,
                2, _hargaPembelian, "", alamat, courier, service, ongkir )
                .then((status) async {
              if (status.isSuccess) {
              } else {
                showCustomSnackBar(status.message);
              }
            });
          }
        }else{
          AwesomeSnackbarButton("Gagal","Pilih pengiriman masih kosong",ContentType.failure);
        }

      }
    }

    Future<void> _getProdukList(int product_id) async {
      var controller = Get.find<PopularProdukController>();
      controller.detailProduk(product_id).then((status) async {});
    }

    bool isContainerVisible = false;
    void ongkosKirim(address_id, destination_id, berat, kurir) async {
      controller.showButton();
      Uri url = Uri.parse("https://pro.rajaongkir.com/api/cost");
      try {
        print(controller.daftarAlamatList[0].city_id);
        final response = await http.post(
          url,
          body: {
            "origin": "${controller.cityTujuanId}",
            "originType": "city",
            "destination": "${controller.daftarAlamatList[0].city_id}",
            "destinationType": "subdistrict",
            "weight": "${controller.berat}",
            "courier": "${controller.kurir}",
          },
          headers: {
            "key": "41df939eff72c9b050a81d89b4be72ba",
            "content-type": "application/x-www-form-urlencoded"
          },
        );

        var data = jsonDecode(response.body) as Map<String, dynamic>;
        var results = data["rajaongkir"]["results"] as List<dynamic>;
        var listAllCourier = Courier.fromJsonList(results);
        var courier = listAllCourier[0];
        Get.defaultDialog(
          title: courier.name!,
          content: Column(
            children: courier.costs!
                .map((e) => GestureDetector(
                      child: ListTile(
                        title: Text("${e.service}"),
                        subtitle: PriceText(
                          text:
                              CurrencyFormat.convertToIdr(e.cost![0].value, 0),
                          size: Dimensions.font16,
                        ),
                        trailing: Text(courier.code == "pos"
                            ? "${e.cost![0].etd}"
                            : "${e.cost![0].etd} HARI"),
                      ),
                      onTap: () {
                        controller.setHargaPengiriman(e.cost![0].value);
                        controller.setServicePengiriman(e.service);
                        print(controller.service.value);
                        print(Get.find<AlamatController>().alamatID.value);
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ),
        );
      } catch (err) {
        Get.defaultDialog(
          title: "Eror",
        );
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
                        Get.offNamed(RouteHelper.getKeranjangPage());
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
                      fontWeight: FontWeight.bold,
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
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.0),
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
                                          Obx(
                                            () => Container(
                                              height: 300,
                                              child: ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller.daftarAlamatList.length,
                                                itemBuilder:
                                                    (BuildContext context, int index) {
                                                  Alamat alamat = controller.daftarAlamatList[index];
                                                  return Container(
                                                    height: 120,
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: Dimensions.width20,
                                                      vertical: Dimensions.height20,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets.zero,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(Dimensions.radius20 / 4),
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                            .grey[
                                                                        200]!,
                                                                    blurRadius:
                                                                        5,
                                                                    spreadRadius:
                                                                        1,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: GetBuilder<
                                                                      AlamatController>(
                                                                  builder:
                                                                      (alamatController) {
                                                                return ListTile(
                                                                  title: Text(
                                                                    "Alamat ${index + 1}",
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      Dimensions.font20,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  subtitle: Text(
                                                                    "${alamat.user_street_address?.toString() ?? ""}, ${alamat.city_name?.toString() ?? ""}, ${alamat.province_name?.toString() ?? ""}",
                                                                  ),
                                                                  trailing: Radio(
                                                                    value: "${alamat.user_street_address?.toString() ?? ""}, ${alamat.city_name?.toString() ?? ""}, ${alamat.province_name?.toString() ?? ""}",
                                                                    groupValue: controller.selected.value,
                                                                    onChanged: (String? value) => {
                                                                      controller.setTypeAlamat(value!),
                                                                      controller.setId(alamat.user_address_id),
                                                                      print(controller.alamatID.value)
                                                                    },
                                                                    activeColor: Theme.of(context).primaryColor,
                                                                  ),
                                                                );
                                                              }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
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
                    Obx(
                            () => BigText(
                              text: controller.selected.value.toString(),
                              size: 15,
                            )
                        ),
                    Divider(color: AppColors.buttonBackgroundColor),
                    GetBuilder<CartController>(builder: (cartController) {
                      var _keranjangList = cartController.keranjangList;
                      var groupedKeranjangList = <String, List<CartModel>>{};
                      var _checkedCartIds = cartController.checkedCartIds;
                      var _matchedItems = _keranjangList
                          .where((item) =>
                              _checkedCartIds.contains(item.productId))
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
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white),
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
                                        controller.berat.value =
                                            item.heavy ?? 0;
                                        var gambarproduk =
                                            Get.find<PopularProdukController>()
                                                .imageProdukList
                                                .where((produk) =>
                                                    produk.productId ==
                                                    item.productId);
                                        return Row(
                                          children: [
                                            Container(
                                              width:
                                                  Dimensions.screenWidth / 1.35,
                                              height: Dimensions.height45 * 2.5,
                                              margin: EdgeInsets.only(
                                                  bottom:
                                                      Dimensions.height10 / 2,
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
                                                          if (produkIndex >=
                                                              0) {
                                                            _getProdukList(item
                                                                .productId!);
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
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              NetworkImage(
                                                                            '${AppConstants.BASE_URL_IMAGE}u_file/product_image/${gambarproduk.single.productImageName}',
                                                                          )),
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
                                                              Row(
                                                                children: [
                                                                  SmallText(
                                                                      text:
                                                                          "Berat : ${item.heavy} gr"),
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
                                  Obx(() => Get.find<PengirimanController>().paymentIndex.value == 2 ?  Column(
                                        children: [
                                          Row(
                                            children: [
                                              BigText(text: "Ongkir : ", size: Dimensions.font16,),
                                              PriceText(
                                                text: CurrencyFormat.convertToIdr(
                                                    controller.HargaPengiriman.value,
                                                    0),
                                                color: AppColors.redColor,
                                                size: Dimensions.font16,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              BigText(text: "Pengiriman : ${controller.namakurir.value}", size: Dimensions.font16,)
                                            ],
                                          )
                                        ],
                                      ) : SizedBox()),
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
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return LayoutBuilder(builder:
                                                  (BuildContext context,
                                                      BoxConstraints
                                                          constraints) {
                                                return SingleChildScrollView(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        minHeight: constraints
                                                            .maxHeight),
                                                    child: IntrinsicHeight(
                                                      child: Container(
                                                        height: Dimensions
                                                                .screenHeight /
                                                            2,
                                                        width: Dimensions
                                                            .screenWidth,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                            topRight:
                                                                Radius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                          ),
                                                        ),
                                                        padding: EdgeInsets.only(
                                                            top: Dimensions
                                                                .height30,
                                                            left: Dimensions
                                                                .width20,
                                                            right: Dimensions
                                                                .width20),
                                                        child: Column(
                                                          children: [
                                                            Row(children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: AppIcon(
                                                                  icon:
                                                                      CupertinoIcons
                                                                          .xmark,
                                                                  size: Dimensions
                                                                      .iconSize24,
                                                                  iconColor:
                                                                      AppColors
                                                                          .redColor,
                                                                  backgroundColor: Colors
                                                                      .white
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
                                                                size: Dimensions
                                                                    .font26,
                                                              ),
                                                            ]),
                                                            Divider(
                                                                color: AppColors
                                                                    .buttonBackgroundColor),
                                                            Column(
                                                              children: [
                                                                PengirimanOptionButton(
                                                                    icon: Icons
                                                                        .money,
                                                                    title:
                                                                        'Ambil Ditempat Rp0',
                                                                    index: 1),
                                                                SizedBox(
                                                                    height: Dimensions
                                                                        .height10),
                                                                PengirimanOptionButton(
                                                                    icon: Icons
                                                                        .money,
                                                                    title:
                                                                        'Pesanan Dikirim',
                                                                    index: 2,),
                                                                Obx(
                                                                  () => Get.find<PengirimanController>()
                                                                              .paymentIndex
                                                                              .value ==
                                                                          2
                                                                      ? Visibility(
                                                                          visible:
                                                                              true, // Set visibility to true when index is 2
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              DropdownSearch<Map<String, dynamic>>(
                                                                                mode: Mode.MENU,
                                                                                showClearButton: true,
                                                                                label: "Tipe Kurir",
                                                                                hint: "Pilih tipe pengiriman...",
                                                                                showSearchBox: true,
                                                                                items: [
                                                                                  {
                                                                                    "code": "jne",
                                                                                    "name": "Jalur Nugraha Ekakurir (JNE)"
                                                                                  },
                                                                                  {
                                                                                    "code": "pos",
                                                                                    "name": "Perusahaan Opsional Surat (POS Indonesia)"
                                                                                  },
                                                                                  {
                                                                                    "code": "tiki",
                                                                                    "name": "Titipan Kilat (TIKI)"
                                                                                  }
                                                                                ],
                                                                                dropdownSearchDecoration: InputDecoration(labelText: "Pengiriman"),
                                                                                onChanged: (value) {
                                                                                  if (value != null) {
                                                                                    controller.kurir.value = value['code'];
                                                                                    controller.namakurir.value = value['name'];
                                                                                    controller.showButton();
                                                                                    print(controller.kurir.value);
                                                                                  } else {
                                                                                    controller.hiddenButton.value = true;
                                                                                    controller.kurir.value = "";
                                                                                  }
                                                                                },
                                                                                itemAsString: (item) => "${item?['name']}",
                                                                                popupItemBuilder: (context, item, isSelected) => Container(
                                                                                  padding: EdgeInsets.all(20),
                                                                                  child: Text(
                                                                                    "${item['name']}",
                                                                                    style: TextStyle(
                                                                                      fontSize: 18,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Obx(
                                                                                () => controller.hiddenButton.isTrue
                                                                                    ? SizedBox()
                                                                                    : GestureDetector(
                                                                                        onTap: () {
                                                                                          // print(controller.cityAsalId);
                                                                                          // print(controller.cityTujuanId);
                                                                                          ongkosKirim(controller.cityAsalId, controller.cityTujuanId, controller.berat, controller.kurir);
                                                                                        },
                                                                                        child: Center(
                                                                                          child: Row(
                                                                                            children: [
                                                                                              BigText(
                                                                                                text: "Kirim",
                                                                                                size: Dimensions.font16,
                                                                                                color: AppColors.redColor,
                                                                                              ),
                                                                                              AppIcon(
                                                                                                icon: Icons.send,
                                                                                                iconSize: Dimensions.iconSize24,
                                                                                                iconColor: AppColors.redColor,
                                                                                                backgroundColor: Colors.white.withOpacity(0.0),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        )),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Visibility(
                                                                          visible:
                                                                              false, // Set visibility to false when index is not 2
                                                                          child:
                                                                              Container(),
                                                                        ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                            });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                              children: [
                                            AppIcon(
                                              icon: Icons.note,
                                              iconColor: AppColors.redColor,
                                              backgroundColor:
                                              Colors.white.withOpacity(0.0),
                                            ),
                                            Obx(
                                                  () => BigText(
                                                text:
                                                Get.find<PengirimanController>()
                                                    .checkedtypePengiriman
                                                    .value,
                                                size: Dimensions.height15,
                                              ),
                                            ),
                                          ]),
                                          AppIcon(
                                            icon: Icons.arrow_drop_down_outlined,
                                            iconColor: AppColors.redColor,
                                            backgroundColor:
                                            Colors.white.withOpacity(0.0),
                                          ),
                                        ],
                                      )
                                    ),
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
                                  calculateTotal().toDouble() +
                                      controller.HargaPengiriman.toDouble(),
                                  0),
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
        ));
  }
}
