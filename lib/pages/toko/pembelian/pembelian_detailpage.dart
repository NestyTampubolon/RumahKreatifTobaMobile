import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/pembelian_controller.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/pesanan_controller.dart';
import '../../../controllers/popular_produk_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/currency_format.dart';
import '../../../widgets/price_text.dart';
import '../../../widgets/small_text.dart';


class PembelianDetailPage extends StatefulWidget {
  const PembelianDetailPage({Key? key}) : super(key: key);

  @override
  State<PembelianDetailPage> createState() => _PembelianDetailPageState();
}

class _PembelianDetailPageState extends State<PembelianDetailPage> {
  @override
  void initState() {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUser();
    }
  }
  bool _cekStatus = Get.find<PembelianController>().detailPembelianList[0].statusPembelian == "Perlu Dikemas";

  @override
  Widget build(BuildContext context) {
    var detailPembelian = Get.find<PembelianController>().detailPembelianList;
    Future<void> _updateStatusPembelian(int purchase_id) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PembelianController>();
        controller.updateStatusPembelian(purchase_id).then((status) async {
        });
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
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20,
                  ),
                  BigText(
                    text: "Detail Pembelian",
                    size: Dimensions.font20,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
              margin: EdgeInsets.only(
                  top: Dimensions.height20
              ),

              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        BigText(
                          text: detailPembelian[0].statusPembelian.toString(),
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  Container(
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        BigText(
                          text: detailPembelian[0].kodePembelian != null ? detailPembelian[0].kodePembelian.toString() : 'N/A',
                          size: Dimensions.font16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //List View Detail Produk
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
              margin: EdgeInsets.only(
                  top: Dimensions.height20
              ),

              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        BigText(
                          text: "Detail Pembelian",
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  GetBuilder<PembelianController>(builder: (controller) {
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: Dimensions.height45 * 3.8),
                        itemCount: controller.detailPembelianList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var gambarproduk = Get.find<PopularProdukController>().imageProdukList.where(
                                  (produk) =>
                              produk.productId ==
                                  controller.detailPembelianList[index].productId);
                          return Container(
                            width: Dimensions.screenWidth,
                            height: Dimensions.height45 * 3.5,
                            margin: EdgeInsets.only(
                              bottom: Dimensions.height10,),
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(

                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                var produkIndex =
                                                controller
                                                    .detailPembelianList[index]
                                                    .productId!;
                                                if (produkIndex >= 0) {
                                                  Get.toNamed(RouteHelper
                                                      .getProdukDetail(
                                                      produkIndex));
                                                }
                                              },
                                              child: Container(
                                                width:
                                                Dimensions.height20 *
                                                    3,
                                                height:
                                                Dimensions.height20 *
                                                    3,
                                                margin: EdgeInsets.only(
                                                    top: Dimensions
                                                        .height10),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          '${AppConstants.BASE_URL_IMAGE}u_file/product_image/${gambarproduk.single.productImageName}',
                                                        )
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radius20),
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.width20,),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width : Dimensions.screenWidth/1.6,
                                                  child: BigText(
                                                    text: controller
                                                        .detailPembelianList[index]
                                                        .productName,
                                                    size: Dimensions.font16,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SmallText(
                                                        text: "${ controller
                                                            .detailPembelianList[index]
                                                            .jumlahPembelianProduk} x "),
                                                    PriceText(
                                                      text: CurrencyFormat
                                                          .convertToIdr(
                                                          controller
                                                              .detailPembelianList[index]
                                                              .price,
                                                          0),
                                                      size: Dimensions.font16,
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
                                Divider(color: AppColors.buttonBackgroundColor),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SmallText(
                                              text: "Total Harga"),
                                          PriceText(
                                            text:  controller
                                                .detailPembelianList[index]
                                                .hargaPembelianProduk != null ? CurrencyFormat
                                                .convertToIdr(
                                                controller
                                                    .detailPembelianList[index]
                                                    .hargaPembelianProduk,
                                                0) : 'N/A',
                                            size: Dimensions.font16,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
              margin: EdgeInsets.only(
                  top: Dimensions.height20
              ),

              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        BigText(
                          text: "Rincian Pembayaran",
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            BigText(
                              text: "Total Harga",
                              size: Dimensions.font16,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            PriceText(
                              text: detailPembelian[0].hargaPembelian != null ? CurrencyFormat
                                  .convertToIdr(
                                   detailPembelian[0].hargaPembelian ,
                                  0): 'N/A',
                              size: Dimensions.font16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "Total Ongkos Kirim",
                          size: Dimensions.font16,
                        ),
                        PriceText(
                          text: CurrencyFormat
                              .convertToIdr(
                              detailPembelian[0].ongkir,
                              0),
                          size: Dimensions.font16,
                        ),
                      ],
                    ),
                  ),
                  Divider(color: AppColors.buttonBackgroundColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "Total Belanja",
                        size: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                      ),
                      PriceText(
                        text: detailPembelian[0].hargaPembelian != null ?
                        CurrencyFormat
                            .convertToIdr(
                             detailPembelian[0].hargaPembelian ,
                            0) : 'N/A',
                        size: Dimensions.font16,
                      ),
                    ],
                  )
                ],
              ),
            ),
            _cekStatus ?
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
              margin: EdgeInsets.only(
                  top: Dimensions.height20
              ),

              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height30),
              child: Column(
                children: [
                  Container(
                    width: Dimensions.screenWidth,
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    child: SmallText(
                      text: "Jika pesanan telah disiapkan. SILAHKAN KONFIRMASI PESANAN.",
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      GestureDetector(
                        onTap: (){
                          _updateStatusPembelian(detailPembelian[0].purchaseId);
                        },
                        child: Container(
                          width: Dimensions.width45*3,
                          height: Dimensions.height30,
                          // alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.redColor),
                          child: Center(
                            child: BigText(
                              text: "Konfirmasi",
                              size: Dimensions.font16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}
