import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/pages/home/pakaian_diminati_page.dart';
import 'package:rumah_kreatif_toba/pages/home/produk_terbaru_page.dart';
import 'package:rumah_kreatif_toba/pages/home/produk_unggulan_page.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:get/get.dart';
import '../controllers/popular_produk_controller.dart';
import '../pages/kategori/kategori_produk_detail.dart';
import '../routes/route_helper.dart';
import '../utils/colors.dart';
import 'big_text.dart';

class CardUnggulan extends StatelessWidget {
  final String kategori;


  CardUnggulan({
    Key? key,
    required this.kategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProdukController>(builder: (_produkController) {
      return Container(
        width: 200,
        height: 200,
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
          ],
        ),
        child: GestureDetector(
          onTap: () {
              if(kategori == 'Makanan dan Minuman'){
                Get.to(ProdukUnggulanPage());
              }else if(kategori == 'Pakaian Diminati'){
                Get.to(PakaianDiminatiPage());
              }else if(kategori == 'Produk Terbaru'){
                Get.to(ProdukTerbaruPage());
              }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //image section
              Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.only(
                    left: Dimensions.width10 / 2,
                    right: Dimensions.width10 / 2,
                    top: Dimensions.height10 / 2,
                    bottom: Dimensions.height10 / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                          AssetImage("assets/images/unggulan/${kategori}.png")),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width10 / 4,
                    right: Dimensions.width10 / 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(kategori,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Dimensions.height20 / 2))
                  ],
                ),
              )
              //text container
            ],
          ),
        ),
      );
    });
  }
}