import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/alamat_controller.dart';
import 'package:rumah_kreatif_toba/controllers/cart_controller.dart';
import 'package:rumah_kreatif_toba/controllers/pesanan_controller.dart';
import 'package:rumah_kreatif_toba/controllers/popular_produk_controller.dart';
import 'package:rumah_kreatif_toba/controllers/wishlist_controller.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page_body.dart';
import 'package:rumah_kreatif_toba/pages/home/main_home_page.dart';
import 'package:rumah_kreatif_toba/pages/keranjang/keranjang_page.dart';
import 'package:rumah_kreatif_toba/pages/pembelian/pembelian_page.dart';
import 'package:rumah_kreatif_toba/pages/produk/produk_detail.dart';
import 'package:rumah_kreatif_toba/pages/wishlist/wishlist_page.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'controllers/auth_controller.dart';
import 'controllers/bank_controller.dart';
import 'controllers/user_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProdukController>().getPopularProdukList();
    Get.find<CartController>().getKeranjangList();
    Get.find<WishlistController>().getWishlistList();
    Get.find<BankController>().getBankList();

    Get.find<UserController>().getUser().then((value) async {
      await Get.find<AlamatController>().getAlamat();
      await Get.find<AlamatController>().getAlamatUser();
      await Get.find<PesananController>().getPesanan();
      await Get.find<PesananController>().getPesananMenungguBayaranList();
      await Get.find<CartController>().getKeranjangList();
      await Get.find<WishlistController>().getWishlistList();
      await Get.find<BankController>().getBankList();
      await  Get.find<AlamatController>().getAlamatToko();
    });

    return GetBuilder<PopularProdukController>(
      builder: (_) {
        return GetBuilder<CartController>(builder: (_) {
          return GetBuilder<WishlistController>(builder: (_){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Rumah Kreatif Toba',
              // home: PembelianPage(),
              initialRoute: RouteHelper.getSplashPage(),
              getPages: RouteHelper.routes,
            );
          });
        });
      },
    );
  }
}
