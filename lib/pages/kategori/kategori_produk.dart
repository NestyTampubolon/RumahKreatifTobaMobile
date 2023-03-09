import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../routes/route_helper.dart';

class KategoriProduk extends StatelessWidget {
  const KategoriProduk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: Dimensions.screenHeight,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/wallpaper_kategori.png"))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height30),
                    alignment: Alignment.center,
                    child: BigText(
                      text: "Kategori",
                      size: Dimensions.height20 * 2,
                    ),
                  ),
                  //MAKANAN
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(KategoriProdukDetail(), arguments: "Makanan");
                        },
                        child: Container(
                          height: Dimensions.height30 * 4,
                          width: Dimensions.width45 * 7,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: Dimensions.width45 * 2,
                              top: Dimensions.height30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: BigText(text: "Makanan"),
                        ),
                      ),
                      Container(
                        height: Dimensions.height45 * 2,
                        width: Dimensions.width20 * 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Dimensions.width45, top: Dimensions.height45),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/makanan.png")),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),

                  //MINUMAN
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(KategoriProdukDetail(), arguments: "Minuman");
                        },
                        child: Container(
                          height: Dimensions.height30 * 4,
                          width: Dimensions.width45 * 7,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: Dimensions.width45 * 2,
                              top: Dimensions.height30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: BigText(text: "Minuman"),
                        ),
                      ),
                      Container(
                        height: Dimensions.height45 * 2,
                        width: Dimensions.width20 * 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Dimensions.width45, top: Dimensions.height45),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/minuman.png")),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),

                  //ULOS
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(KategoriProdukDetail(), arguments: "Ulos");
                        },
                        child: Container(
                          height: Dimensions.height30 * 4,
                          width: Dimensions.width45 * 7,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: Dimensions.width45 * 2,
                              top: Dimensions.height30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: BigText(text: "Ulos"),
                        ),
                      ),
                      Container(
                        height: Dimensions.height45 * 2,
                        width: Dimensions.width20 * 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Dimensions.width45, top: Dimensions.height45),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/ulos.png")),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),

                  //SOUVENIR
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(KategoriProdukDetail(), arguments: "Souvenir");
                        },
                        child: Container(
                          height: Dimensions.height30 * 4,
                          width: Dimensions.width45 * 7,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: Dimensions.width45 * 2,
                              top: Dimensions.height30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: BigText(text: "Souvenir"),
                        ),
                      ),
                      Container(
                        height: Dimensions.height45 * 2,
                        width: Dimensions.width20 * 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Dimensions.width45, top: Dimensions.height45),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/souvenir.png")),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),

                  //PAKAIAN
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(KategoriProdukDetail(), arguments: "Pakaian");
                        },
                        child: Container(
                          height: Dimensions.height30 * 4,
                          width: Dimensions.width45 * 7,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: Dimensions.width45 * 2,
                              top: Dimensions.height30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: BigText(text: "Pakaian"),
                        ),
                      ),
                      Container(
                        height: Dimensions.height45 * 2,
                        width: Dimensions.width20 * 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Dimensions.width45, top: Dimensions.height45),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/pakaian.png")),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),

                  //PERLENGKAPAN RUMAH
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(KategoriProdukDetail(),
                              arguments: "Perlengkapan Rumah");
                        },
                        child: Container(
                          height: Dimensions.height30 * 4,
                          width: Dimensions.width45 * 7,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: Dimensions.width45 * 2,
                              top: Dimensions.height30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: BigText(text: "Perlengkapan Rumah"),
                        ),
                      ),
                      Container(
                        height: Dimensions.height45 * 2,
                        width: Dimensions.width20 * 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Dimensions.width45, top: Dimensions.height45),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/perlengkapan_rumah.png")),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),

                  //NON HALAL
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(KategoriProdukDetail(),
                              arguments: "Non Halal");
                        },
                        child: Container(
                          height: Dimensions.height30 * 4,
                          width: Dimensions.width45 * 7,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: Dimensions.width45 * 2,
                              top: Dimensions.height30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: BigText(text: "Non Halal"),
                        ),
                      ),
                      Container(
                        height: Dimensions.height45 * 2,
                        width: Dimensions.width20 * 4,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Dimensions.width45, top: Dimensions.height45),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/non_halal.png")),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
