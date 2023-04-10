import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/auth/masuk.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/pages/home/main_home_page.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/pages/keranjang/keranjang_page.dart';
import 'package:rumah_kreatif_toba/pages/pembayaran/pembayaran_page.dart';
import 'package:rumah_kreatif_toba/pages/pembelian/pembelian_page.dart';
import 'package:rumah_kreatif_toba/pages/pesanan/detail_pesanan_page.dart';
import 'package:rumah_kreatif_toba/pages/pesanan/menunggu_pembayaran_page.dart';
import 'package:rumah_kreatif_toba/pages/splash/splash_page.dart';

import '../controllers/popular_produk_controller.dart';
import '../pages/pesanan/pesanan_page.dart';
import '../pages/produk/produk_detail.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String produkDetail = "/produkjson";
  static const String keranjangPage = "/keranjang";
  static const String kategoriProdukDetail = "/kategoriProdukDetail";
  static const String masuk = "/login";
  static const String pembelian = "/pembelian";
  static const String pembayaran = "/pembayaran";
  static const String pesanan = "/pesanan";
  static const String menungguPembayaran = "/menunggu_pembayaran";
  static const String detailPesanan = "/detail_pesanan";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getProdukDetail(int produkId) =>
      '$produkDetail/$produkId';
  static String getKeranjangPage() => '$keranjangPage';
  static String getKategoriProdukDetail() => '$kategoriProdukDetail';
  static String getMasukPage() => '$masuk';
  static String getPembelianPage() => '$pembelian';
  static String getPembayaranPage() => '$pembayaran';
  static String getPesananPage() => '$pesanan';
  static String getMenungguPembayaranPage() => '$menungguPembayaran';
  static String getDetailPesananPage() => '$detailPesanan';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: masuk, page: (){return Masuk();}, transition: Transition.fade),
    GetPage(name: pembelian, page: () => PembelianPage()),
    GetPage(name: pembayaran, page: () => PembayaranPage()),
    GetPage(name: pesanan, page: () => PesananPage()),
    GetPage(name: menungguPembayaran, page: () => MenungguPembayaranPage()),
    GetPage(name: detailPesanan, page: () => DetailPesananPage()),
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
