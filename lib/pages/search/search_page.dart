import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_produk_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/price_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/tittle_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _list = [];
  @override
  initState(){
    _list = [];
    super.initState();
  }

  Future<void> _search(String keyword) async {
    List<dynamic> results = [];
    if (keyword.isEmpty) {
      results = [];
    }  else {
      results = Get.find<PopularProdukController>().popularProdukList.where((produk) => produk.productName.toLowerCase().contains(keyword.toLowerCase())).toList();
    }

    setState(() {
      _list = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    var SearchController = TextEditingController();

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height30, bottom: Dimensions.height10),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.toNamed(RouteHelper.getInitial());
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconColor: AppColors.redColor,
                        backgroundColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    Container(
                      width: Dimensions.screenWidth / 1.3,
                      margin: EdgeInsets.only(right: Dimensions.height20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          border: Border.all(color: AppColors.signColor)),
                      child: TextField(
                        onChanged: (value) => _search(value),
                        decoration: InputDecoration(
                            hintText: "Cari di Rumah Kreatif",
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.redColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                                borderSide:
                                BorderSide(width: 1.0, color: AppColors.redColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                                borderSide:
                                BorderSide(width: 1.0, color: Colors.white)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 256),
                  itemCount: _list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getProdukDetail(
                            _list[index].productId));
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
                            top: Dimensions.height10),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getProdukDetail(_list[index].productId));
//                        Get.toNamed(RouteHelper.getProdukDetail(index));
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
                                        topLeft:
                                        Radius.circular(Dimensions.radius15),
                                        topRight:
                                        Radius.circular(Dimensions.radius15)),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "assets/images/coffee.jpg"))),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: _list[index].namaKategori
                                          .toString(),
                                      size: Dimensions.font16 / 1.5,
                                    ),
                                    TittleText(
                                      text: _list[index].productName
                                          .toString(),
                                      size: Dimensions.font16,
                                    ),
                                    SmallText(
                                      text: _list[index].namaMerchant
                                          .toString(),
                                    ),
                                    PriceText(
                                      text: CurrencyFormat.convertToIdr(
                                          _list[index].price,
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
            ])));;
  }
}

