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
import 'package:rumah_kreatif_toba/widgets/small_text.dart';

import '../../utils/dimensions.dart';
import '../../widgets/currency_format.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.pageView,
          margin: EdgeInsets.only(top: 10, bottom: 20),
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.redColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(
          height: Dimensions.height45,
        ),

        //Populer produk
        Container(
          margin: EdgeInsets.only(left: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigText(text: "Produk Terlaris",),
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
        // new DotsIndicator(
        //   dotsCount: 10,
        //   position: _currPageValuePopulerProduct,
        //   decorator: DotsDecorator(
        //     activeColor: AppColors.redColor,
        //     size: const Size.square(9.0),
        //     activeSize: const Size(18.0, 9.0),
        //     activeShape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(5.0)),
        //   ),
        // ),
        SizedBox(
          height: Dimensions.height30,
        ),

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
        // new DotsIndicator(
        //   dotsCount: 10,
        //   position: _currPageValuePopulerProduct,
        //   decorator: DotsDecorator(
        //     activeColor: AppColors.redColor,
        //     size: const Size.square(9.0),
        //     activeSize: const Size(18.0, 9.0),
        //     activeShape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(5.0)),
        //   ),
        // ),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigText(text: "Produk Terlaris"),
            ],
          ),
        ),
        GetBuilder<PopularProdukController>(builder: (popularProduk) {
          return popularProduk.isLoaded
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 256),
                  // shrinkWrap: true,
                  itemCount: popularProduk.popularProdukList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getProdukDetail(
                            popularProduk.popularProdukList[index].productId));
                      },
                      child: Container(
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
                            bottom: Dimensions.height10),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getProdukDetail(
                                popularProduk
                                    .popularProdukList[index].productId));
//                        Get.toNamed(RouteHelper.getProdukDetail(index));
                          },
                          child: Column(
                            children: [
                              //image section
                              Container(
                                width: 180,
                                height: 120,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/coffee.jpg"))),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: popularProduk
                                          .popularProdukList[index].productName.toString(),
                                      size: Dimensions.font20,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    BigText(
                                      text: CurrencyFormat.convertToIdr(
                                          popularProduk
                                              .popularProdukList[index].price,
                                          2),
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getProdukDetail(popularProduk
                              .popularProdukList[index].productId));
                        },
                        child: Container(
                          width: 180,
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
                              bottom: Dimensions.height10),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getProdukDetail(
                                  popularProduk
                                      .popularProdukList[index].productId));
//                        Get.toNamed(RouteHelper.getProdukDetail(index));
                            },
                            child: Column(
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
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: popularProduk
                                            .popularProdukList[index]
                                            .productName.toString(),
                                        size: Dimensions.font20,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      BigText(
                                        text: CurrencyFormat.convertToIdr(
                                            popularProduk
                                                .popularProdukList[index].price,
                                            2),
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
