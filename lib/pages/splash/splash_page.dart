import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/pesanan_controller.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';

import '../../controllers/alamat_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/bank_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/popular_produk_controller.dart';
import '../../controllers/wishlist_controller.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void init() async {
    Future.delayed(Duration(seconds: 3), () {
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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProdukController>(
      builder: (_) {
        return GetBuilder<CartController>(builder: (_) {
          return GetBuilder<WishlistController>(builder: (_) {
            return InitialSplashScreen();
          });
        });
      },
    );
  }
}

class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({super.key});

  @override
  State<InitialSplashScreen> createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen> {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    if (Platform.isIOS) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
    await Get.find<PopularProdukController>().getPopularProdukList();
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      await Get.find<CartController>().getKeranjangList();
      await Get.find<UserController>().getUser().then((value) async {
        await Get.find<AlamatController>().getAlamat();
        await Get.find<AlamatController>().getAlamatUser();
      });
      await Get.find<WishlistController>().getWishlistList();
      await Get.find<BankController>().getBankList();
      await Get.find<AlamatController>().getAlamatToko();
      await Get.find<PesananController>().getPesanan();
    }
    Timer(Duration(seconds: 2), () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/logo_rkt.png",
              width: Dimensions.splashImg,
            ),
          ),
        ],
      ),
    );
  }
}
