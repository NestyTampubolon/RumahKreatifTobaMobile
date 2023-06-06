import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/controllers/categories_controller.dart';
import 'package:rumah_kreatif_toba/pages/toko/produk/tambahproduk_page.dart';
import 'package:rumah_kreatif_toba/pages/toko/produk/ubahproduk_page.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/widgets/price_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import 'package:rumah_kreatif_toba/widgets/tittle_text.dart';
import 'package:get/get.dart';
import '../../../base/show_custom_message.dart';
import '../../../base/snackbar_message.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/popular_produk_controller.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/currency_format.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProdukController>().getProdukList();
    Get.find<CategoriesController>().getKategoriList();
    Future<void> _kategorilist() async {
      var controller = Get.find<CategoriesController>();
      controller.getKategoriList().then((status) async {
        Get.to(TambahProdukPage());
      });
    }

    Future<void> _hapusProduk(int product_id) async {
      var cartController = Get.find<PopularProdukController>();
      cartController.hapusProduk(product_id).then((status) {
        if (status.isSuccess) {
        } else {
          AwesomeSnackbarButton("Gagal",status.message,ContentType.failure);
        }
      });
    }

    Future<void> _detailProdukList(int product_id) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PopularProdukController>();
        controller.detailProduk(product_id).then((status) async {
          if (status.isSuccess) {
            Get.to(UbahProdukPage());
          } else {
            AwesomeSnackbarButton("Gagal",status.message,ContentType.failure);
          }
        });
      }
    }

    return RefreshIndicator(
        child: Scrollbar(
            showTrackOnHover: true, thickness: 7, radius: Radius.circular(20),
      child: ListView(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height30, bottom: Dimensions.height10),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: BigText(
                      text: "Daftar Produk",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _kategorilist();
                    },
                    child: Container(
                        child: Icon(
                          Icons.add,
                          color: AppColors.redColor,
                        )),
                  )
                ],
              ),
            ),
          ),
          GetBuilder<PopularProdukController>(builder: (controller) {
            return Obx(() => controller.isLoaded ?  ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.daftarProdukList.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  var gambarproduk = controller.imageProdukList.where(
                          (produk) =>
                      produk.productId ==
                          controller
                              .daftarProdukList[index].productId);
                  return Container(
                    width: Dimensions.screenWidth / 1.2,
                    padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10,
                    ),
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Dimensions.height20 * 4,
                              height: Dimensions.height20 * 4,
                              margin: EdgeInsets.only(
                                  top: Dimensions.height10,
                                  right: Dimensions.width10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        '${AppConstants.BASE_URL_IMAGE}u_file/product_image/${gambarproduk.single.productImageName}',
                                      )),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Dimensions.width45 * 4.7,
                                  child: BigText(
                                    text: controller
                                        .daftarProdukList[index].productName
                                        .toString(),
                                    size: Dimensions.font20,
                                  ),
                                ),
                                PriceText(
                                  text: CurrencyFormat.convertToIdr(
                                      controller
                                          .daftarProdukList[index].price,
                                      0),
                                  color: AppColors.redColor,
                                  size: Dimensions.font16,
                                ),
                                SmallText(
                                    text:
                                    "Stok : ${controller.daftarProdukList[index].stok.toString()}")
                              ],
                            ),
                            PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () {
                                        _detailProdukList(controller
                                            .daftarProdukList[index]
                                            .productId);
                                      },
                                      child: Text( 'Ubah'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () {
                                        _hapusProduk(controller
                                            .daftarProdukList[index]
                                            .productId);
                                      },
                                      child: Text('Hapus'),
                                    ),
                                  ),
                                ];
                              },
                              offset: Offset(0,
                                  30), // set the offset to show the menu in front of the icon
                              child: GestureDetector(
                                child: Container(
                                  child: Icon(Icons.more_vert_outlined),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }) :
            Container(
              height:
              50, // set the height of the container to your desired height
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.redColor,
                ),
              ),
            ));
          }),
          SizedBox(
            height: Dimensions.height20,
          )
        ],
      ),
    ),
        onRefresh: () => Get.find<PopularProdukController>().getProdukList());
  }
}
