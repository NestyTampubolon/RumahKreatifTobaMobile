import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/controllers/categories_controller.dart';
import 'package:rumah_kreatif_toba/pages/toko/produk/tambahproduk_page.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/widgets/price_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import 'package:rumah_kreatif_toba/widgets/tittle_text.dart';
import 'package:get/get.dart';
import '../../../controllers/popular_produk_controller.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/currency_format.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProdukController>().getProdukList();

    Future<void> _kategorilist() async {
      var controller = Get.find<CategoriesController>();
      controller
          .getKategoriList()
          .then((status) async {
        Get.to(TambahProdukPage());
      });

    }

    return Scaffold(
      body: Column(
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
                   onTap: (){
                     _kategorilist();
                   },
                   child:  Container(
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
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.daftarProdukList.length,
                shrinkWrap: true,
                itemBuilder: (_, index)  {
                  return Container(
                    width: Dimensions.screenWidth/1.2,
                    padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
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
                          children: [
                            Container(
                              width: Dimensions.height20 * 4,
                              height: Dimensions.height20 * 4,
                              margin: EdgeInsets.only(
                                  top: Dimensions.height10, right: Dimensions.width10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/images/coffee.jpg")),
                                  borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                                  color: Colors.white),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: BigText(
                                    text: controller
                                        .daftarProdukList[index]
                                        .productName
                                        .toString(),
                                    size: Dimensions.font20,
                                  ),
                                ),
                                PriceText(
                                  text: CurrencyFormat.convertToIdr(controller
                                      .daftarProdukList[index]
                                      .price, 0),
                                  color: AppColors.redColor,
                                  size: Dimensions.font16,
                                ),
                                SmallText(text: "Stok : ${controller
                                    .daftarProdukList[index]
                                    .stok
                                    .toString()}")
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Dimensions.height20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: Dimensions.width45*2.5,
                                  height: Dimensions.height30,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                    color: Colors.white.withOpacity(0.0),
                                    border: Border.all(color: AppColors.redColor),
                                  ),
                                  child: Center(
                                    child: TittleText(text: "Ubah Harga", size: Dimensions.font16/1.5,),
                                  )
                              ),
                              Container(
                                  width: Dimensions.width45*2.5,
                                  height: Dimensions.height30,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                    color: Colors.white.withOpacity(0.0),
                                    border: Border.all(color: AppColors.redColor),
                                  ),
                                  child: Center(
                                    child: TittleText(text: "Ubah Stok", size: Dimensions.font16/1.5,),
                                  )
                              ),
                              Container(
                                child: Icon(
                                    Icons.more_vert_outlined
                                ),
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
    );
  }
}
