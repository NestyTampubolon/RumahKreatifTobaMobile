import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/widgets/price_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import 'package:rumah_kreatif_toba/widgets/tittle_text.dart';
import '../controllers/popular_produk_controller.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'currency_format.dart';

class CardProduk extends StatelessWidget {
  final int product_id;
  final String productImageName;
  final String productName;
  final String namaMerchant;
  final int price;

  const CardProduk({Key? key,required this.product_id, required this.productImageName, required this.productName, required this.namaMerchant, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<void> _getProdukList(int product_id) async {
      var controller = Get.find<PopularProdukController>();
      controller.detailProduk(product_id).then((status) async {
      });
    }
    return Container(
      width: Dimensions.width45*4,
      height: Dimensions.width45*9,
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
      margin: EdgeInsets.only(
          left: Dimensions.width10 / 2,
          right: Dimensions.width10,
          bottom: Dimensions.height20,
          top: Dimensions.height10),
      child: GestureDetector(
        onTap: () {
          _getProdukList(product_id);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
              child: BigText(
                text: productImageName,
              ) ,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  TittleText(
                    text: productName,
                    size: Dimensions.font16,
                  ),
                  SmallText(
                    text: namaMerchant,
                  ),
                  PriceText(
                    text: CurrencyFormat.convertToIdr(
                        price,
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
    );
  }
}
