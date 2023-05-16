import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_produk_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/card_produk.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/price_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/tittle_text.dart';

class SearchPage extends StatefulWidget {
  final String kategori;
  const SearchPage({Key? key, required this.kategori}) : super(key: key);

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
      if(widget.kategori == "All"){
        results = Get.find<PopularProdukController>().popularProdukList.where((produk) => produk.productName.toLowerCase().contains(keyword.toLowerCase())).toList();
      }else{
        results = Get.find<PopularProdukController>().popularProdukList.where((produk) => produk.productName.toLowerCase().contains(keyword.toLowerCase())).where((produk) => produk.namaKategori.toString() == widget.kategori).toList();
      }

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
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconColor: AppColors.redColor,
                        backgroundColor: Colors.white.withOpacity(0.0),
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
                            hintText: widget.kategori == "All" ? "Cari di Rumah Kreatif" : "Cari di ${widget.kategori}" ,
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
                      crossAxisCount: 2, mainAxisExtent: Dimensions.height45*6.5),
                  itemCount: _list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var gambarproduk = Get.find<PopularProdukController>()
                        .imageProdukList
                        .where((produk) => produk.productId == _list[index].productId);
                    return CardProduk(product_id : _list[index].productId,productImageName : gambarproduk.single.productImageName, productName : _list[index].productName, merchantAddress : _list[index].subdistrictName, price: _list[index].price, countPurchases : _list[index].countProductPurchases );
                  })
            ])));;
  }
}

