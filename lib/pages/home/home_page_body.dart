import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/popular_produk_controller.dart';
import 'package:rumah_kreatif_toba/models/produk_models.dart';
import 'package:rumah_kreatif_toba/pages/produk/produk_populer_detail.dart';
import 'package:rumah_kreatif_toba/pages/produk/produk_detail.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:rumah_kreatif_toba/widgets/price_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import 'package:rumah_kreatif_toba/widgets/tittle_text.dart';

import '../../utils/dimensions.dart';
import '../../widgets/currency_format.dart';
import '../kategori/kategori_produk_detail.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  PageController pageController = PageController(viewportFraction: 0.90);
  PageController pageControllerPopulerProduct = PageController(viewportFraction: 0.90);

  var _currPageValue = 0.0;
  var _currPageValuePopulerProduct = 0.0;
  double _scaleFactor = 0.8;
  double _height = 200;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    pageControllerPopulerProduct.addListener(() {
      setState(() {
        _currPageValuePopulerProduct = pageControllerPopulerProduct.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    pageControllerPopulerProduct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var kategori;
    Future<void> _getProduk(PopularProdukController produkController)async {
      produkController.getKategoriProdukList(kategori);
    }
    return Column(
      children: [
        // Container(
        //   height: Dimensions.pageView,
        //   margin: EdgeInsets.only(top: 10, bottom: 20),
        //   child: PageView.builder(
        //       controller: pageController,
        //       itemCount: 5,
        //       itemBuilder: (context, position) {
        //         return _buildPageItem(position);
        //       }),
        // ),
        // new DotsIndicator(
        //   dotsCount: 5,
        //   position: _currPageValue,
        //   decorator: DotsDecorator(
        //     activeColor: AppColors.redColor,
        //     size: const Size.square(9.0),
        //     activeSize: const Size(18.0, 9.0),
        //     activeShape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(5.0)),
        //   ),
        // ),

        GetBuilder<PopularProdukController>(builder: (_produkController) {
          return Container(
            height: 300,
            margin: EdgeInsets.only(
                left: Dimensions.width20,
                top: Dimensions.height20,
                right: Dimensions.width20),
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color:
                      AppColors.border, //                   <--- border color
                      width: 0.5,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(KategoriProdukDetail(), arguments: "Makanan");
                      kategori = "Makanan";
                      _getProduk(_produkController);
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
                                image: AssetImage(
                                    "assets/images/kategori/Makanan.png")),
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
                              Text("Makanan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Dimensions.height20 / 2))
                            ],
                          ),
                        )
                        //text container
                      ],
                    ),
                  ),
                ),

                //Minuman
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color:
                      AppColors.border, //                   <--- border color
                      width: 0.5,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(KategoriProdukDetail(), arguments: "Minuman");
                      kategori = "Minuman";
                      _getProduk(_produkController);
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
                                image: AssetImage(
                                    "assets/images/kategori/Minuman.png")),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10 / 4,
                              right: Dimensions.width10 / 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: "Minuman",
                                size: Dimensions.font20 / 2,
                              ),
                            ],
                          ),
                        )
                        //text container
                      ],
                    ),
                  ),
                ),

                //PAKAIAN
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color:
                      AppColors.border, //                   <--- border color
                      width: 0.5,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(KategoriProdukDetail(), arguments: "Pakaian");
                      kategori = "Pakaian";
                      _getProduk(_produkController);
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
                                image: AssetImage(
                                    "assets/images/kategori/Pakaian.png")),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10 / 4,
                              right: Dimensions.width10 / 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: "Pakaian",
                                size: Dimensions.font20 / 2,
                              ),
                            ],
                          ),
                        )
                        //text container
                      ],
                    ),
                  ),
                ),

                //ULOS
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color:
                      AppColors.border, //                   <--- border color
                      width: 0.5,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(KategoriProdukDetail(), arguments: "Ulos");
                      kategori = "Ulos";
                      _getProduk(_produkController);
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
                                image: AssetImage(
                                    "assets/images/kategori/Ulos.png")),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10 / 4,
                              right: Dimensions.width10 / 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: "Ulos",
                                size: Dimensions.font20 / 2,
                              ),
                            ],
                          ),
                        )
                        //text container
                      ],
                    ),
                  ),
                ),

                //SOUVENIR
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color:
                      AppColors.border, //                   <--- border color
                      width: 0.5,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(KategoriProdukDetail(), arguments: "Souvenir");
                      kategori = "Souvenir";
                      _getProduk(_produkController);
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
                                image: AssetImage(
                                    "assets/images/kategori/Souvenir.png")),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10 / 4,
                              right: Dimensions.width10 / 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: "Souvenir",
                                size: Dimensions.font20 / 2,
                              ),
                            ],
                          ),
                        )
                        //text container
                      ],
                    ),
                  ),
                ),

                //LIHAT SEMUA
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color:
                      AppColors.border, //                   <--- border color
                      width: 0.5,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(KategoriProdukDetail(),
                          arguments: "Perlengkapan Rumah");
                      kategori = "Perlengkapan Rumah";
                      _getProduk(_produkController);
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
                                image: AssetImage(
                                    "assets/images/kategori/Lihat Semua.png")),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Lihat Semua",
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(fontSize: Dimensions.height20 / 2))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );}),
        //Produk Terbaru
        Container(
          margin: EdgeInsets.only(left: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigText(text: "Produk Terbaru",),
            ],
          ),
        ),
        Container(
          height: 250,
          margin: EdgeInsets.only(top: 10, bottom: 20),
          child: PageView.builder(
              controller: pageControllerPopulerProduct,
              itemCount: 10,
              itemBuilder: (context, position) {
                return _buildPageItemPopulerProduct(position);
              }),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
//         Container(
//           margin: EdgeInsets.only(left: Dimensions.width20),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               BigText(text: "Produk Terlaris"),
//             ],
//           ),
//         ),
//         GetBuilder<PopularProdukController>(builder: (popularProduk) {
//           return popularProduk.isLoaded
//               ? GridView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, mainAxisExtent: 256),
//
//                   itemCount: popularProduk.popularProdukList.length,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Get.toNamed(RouteHelper.getProdukDetail(
//                             popularProduk.popularProdukList[index].productId));
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 3,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 3),
//                               )
//                             ]),
//                         margin: EdgeInsets.only(
//                             left: Dimensions.width20,
//                             right: Dimensions.width20,
//                             bottom: Dimensions.height10),
//                         child: GestureDetector(
//                           onTap: () {
//                             Get.toNamed(RouteHelper.getProdukDetail(
//                                 popularProduk
//                                     .popularProdukList[index].productId));
// //                        Get.toNamed(RouteHelper.getProdukDetail(index));
//                           },
//                           child: Column(
//                             children: [
//                               //image section
//                               Container(
//                                 width: 180,
//                                 height: 120,
//                                 decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: AssetImage(
//                                             "assets/images/coffee.jpg"))),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(
//                                     left: Dimensions.width10,
//                                     right: Dimensions.width10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     BigText(
//                                       text: popularProduk
//                                           .popularProdukList[index].productName.toString(),
//                                       size: Dimensions.font20,
//                                     ),
//                                     SizedBox(
//                                       height: Dimensions.height10,
//                                     ),
//                                     BigText(
//                                       text: CurrencyFormat.convertToIdr(
//                                           popularProduk
//                                               .popularProdukList[index].price,
//                                           0),
//                                       color: AppColors.redColor,
//                                       size: Dimensions.font16,
//                                     ),
//                                   ],
//                                 ),
//                               )
//                               //text container
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   })
//               : CircularProgressIndicator(
//                   color: AppColors.redColor,
//                 );
//         })
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/coffee.jpg"))),
          )
        ],
      ),
    );
  }

  Widget _buildPageItemPopulerProduct(int index) {
    Matrix4 matrix = new Matrix4.identity();

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GetBuilder<PopularProdukController>(builder: (popularProduk) {
            return popularProduk.isLoaded
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 11,
                    itemBuilder: (context, index) {
                      if (index == 10) {
                        // Return an empty container for the last index to create a blank card
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getProdukDetail(popularProduk
                                .popularProdukList[index].productId));
                          },
                          child: Container(
                            width: 150,
                            height: 300,
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
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                                bottom: Dimensions.height20,
                                top: Dimensions.height10
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.getProdukDetail(
                                    popularProduk
                                        .popularProdukList[index].productId));
//                        Get.toNamed(RouteHelper.getProdukDetail(index));
                              },
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                "assets/images/coffee.jpg"))),
                                  ),
                                  //text container
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getProdukDetail(popularProduk
                              .popularProdukList[index].productId));
                        },
                        child: Container(
                          width: 150,
                          height: 300,
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
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.height20,
                            top: Dimensions.height10
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getProdukDetail(
                                  popularProduk
                                      .popularProdukList[index].productId));
//                        Get.toNamed(RouteHelper.getProdukDetail(index));
                            },
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/images/coffee.jpg"))),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: popularProduk
                                            .popularProdukList[index]
                                            .namaKategori.toString(),
                                        size: Dimensions.font16/1.5,
                                      ),

                                      TittleText(
                                        text: popularProduk
                                            .popularProdukList[index]
                                            .productName.toString(),
                                        size: Dimensions.font16,
                                      ),

                                      SmallText(
                                        text: popularProduk
                                            .popularProdukList[index]
                                            .namaMerchant.toString(),
                                      ),
                                      PriceText(
                                        text: CurrencyFormat.convertToIdr(
                                            popularProduk
                                                .popularProdukList[index].price,
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
                        ),
                      );
                    })
                : CircularProgressIndicator(
                    color: AppColors.redColor,
                  );
          })
        ],
      ),
    );
  }
}
