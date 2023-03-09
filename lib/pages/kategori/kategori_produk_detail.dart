import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';

import '../../controllers/popular_produk_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

import '../../widgets/currency_format.dart';

class KategoriProdukDetail extends StatefulWidget {

  @override
  State<KategoriProdukDetail> createState() => _KategoriProdukDetailState();
}

class _KategoriProdukDetailState extends State<KategoriProdukDetail> {
  var kategori = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print("$kategori");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10, right: Dimensions.width10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/logo_rkt.png"))),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10, right: Dimensions.width10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/Bangga_Buatan_Indonesia_Logo.png"))),
                        ),
                      ],
                    ),
                    Center(
                        child:  Container(
                          width: Dimensions.height45,
                          height: Dimensions.height45,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: Dimensions.iconSize24,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              color: AppColors.redColor),
                        )
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/kategori_detail/Makanan.png"))),
            ),
            SizedBox(height: Dimensions.height20,),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BigText(text: "$kategori",size: Dimensions.height30),

                ],
              ),
            ),
            GetBuilder<PopularProdukController>(builder: (produkKategori) {
              return produkKategori.isLoaded ?
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: produkKategori.popularProdukList.length,
                    itemBuilder: (context, index){
                      if(produkKategori.popularProdukList[index]
                          .namaKategori.toString() == "$kategori"){
                        return Container(
                          margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                          child: Row(
                            children: [
                              Container(
                                width : Dimensions.width20 * 6 ,
                                height: Dimensions.height30 * 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/kategori_detail/Makanan.png"
                                        )
                                    )
                                ),
                              ),

                              Container(
                                height: 100,
                                width: Dimensions.width20*13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(Dimensions.radius20),
                                        bottomRight: Radius.circular(Dimensions.radius20)
                                    ),
                                    color: Colors.white
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: Dimensions.width10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(text: produkKategori
                                          .popularProdukList[index]
                                          .productName.toString(),),
                                      SmallText(text: produkKategori
                                          .popularProdukList[index]
                                          .namaMerchant.toString()),
                                      BigText(text: CurrencyFormat.convertToIdr(
                                          produkKategori
                                              .popularProdukList[index].price,
                                          0)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }else{
                        return Container();
                      }

                    }),
              ) : CircularProgressIndicator(
                color: AppColors.redColor,
              );
            }),

          ],
        ),
      ),
    );
  }
}
