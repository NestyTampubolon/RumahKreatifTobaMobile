import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/widgets/price_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import 'package:rumah_kreatif_toba/widgets/tittle_text.dart';

import '../controllers/popular_produk_controller.dart';
import '../utils/app_constants.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'currency_format.dart';

class CardProduk extends StatelessWidget {
  final int product_id;
  final String productImageName;
  final String productName;
  final String merchantAddress;
  final String? countPurchases;
  final int price;

  const CardProduk(
      {Key? key,
      required this.product_id,
      required this.productImageName,
      required this.productName,
      required this.price,
      required this.merchantAddress,
      this.countPurchases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _getProdukList(int product_id) async {
      var controller = Get.find<PopularProdukController>();
      controller.detailProduk(product_id).then((status) async {});
    }

    return Container(
      width: Dimensions.width45 * 3.5,
      height: Dimensions.height45 * 9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
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
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius15),
                      topRight: Radius.circular(Dimensions.radius15)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${AppConstants.BASE_URL_IMAGE}u_file/product_image/${productImageName}',
                      ))),
              // child: BigText(
              //   text: productImageName,
              // ) ,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TittleText(
                    text: productName,
                    size: Dimensions.font16,
                  ),
                  PriceText(
                    text: CurrencyFormat.convertToIdr(price, 0),
                    color: AppColors.redColor,
                    size: Dimensions.font16,
                  ),
                  SmallText(
                    text: merchantAddress,
                  ),
                  Container(
                    child: countPurchases != null
                        ? SmallText(
                            text: 'Terjual $countPurchases',
                            color: AppColors.redColor,
                          )
                        : SizedBox(),
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
