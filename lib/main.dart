import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/alamat_controller.dart';
import 'package:rumah_kreatif_toba/controllers/cart_controller.dart';
import 'package:rumah_kreatif_toba/controllers/pesanan_controller.dart';
import 'package:rumah_kreatif_toba/controllers/popular_produk_controller.dart';
import 'package:rumah_kreatif_toba/controllers/wishlist_controller.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';

import 'controllers/bank_controller.dart';
import 'controllers/user_controller.dart';
import 'helper/dependencies.dart' as dep;

// Untuk naikan version cukup via file pubspec.yaml saja

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
      await Get.find<AlamatController>().getAlamatToko();
    });

    return GetBuilder<PopularProdukController>(
      builder: (_) {
        return GetBuilder<CartController>(builder: (_) {
          return GetBuilder<WishlistController>(builder: (_) {
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
