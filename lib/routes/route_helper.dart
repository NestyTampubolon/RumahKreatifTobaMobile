import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/home/main_home_page.dart';

import '../controllers/popular_produk_controller.dart';
import '../pages/produk/produk_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String produkDetail = "/produkjson";

  static String getInitial() => '$initial';
  static String getProdukDetail(int produkId) =>
      '$produkDetail/$produkId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainHomePage()),
    GetPage(
      name: produkDetail + '/:produkId', // Add named parameter ":produkId"
      page: () {
        var productId = Get.parameters['produkId'];
        return ProdukDetail(productId: int.parse(productId!));
      },
      transition: Transition.fadeIn,
    ),

  ];
}
