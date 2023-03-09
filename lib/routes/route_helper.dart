import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/pages/home/main_home_page.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/pages/keranjang/keranjang_page.dart';

import '../controllers/popular_produk_controller.dart';
import '../pages/produk/produk_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String produkDetail = "/produkjson";
  static const String keranjangPage = "/keranjang";
  static const String kategoriProdukDetail = "/kategoriProdukDetail";

  static String getInitial() => '$initial';
  static String getProdukDetail(int produkId) =>
      '$produkDetail/$produkId';
  static String getKeranjangPage() => '$keranjangPage';
  static String getKategoriProdukDetail() => '$kategoriProdukDetail';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
      name: produkDetail + '/:produkId', // Add named parameter ":produkId"
      page: () {
        var productId = Get.parameters['produkId'];
        return ProdukDetail(productId: int.parse(productId!));
      },
      transition: Transition.fadeIn,
    ),
    
    GetPage(name: keranjangPage, page: (){
      return KeranjangPage();
    },
      transition: Transition.fadeIn
    ),

    GetPage(name: kategoriProdukDetail, page: () => KategoriProdukDetail()),

  ];
}
