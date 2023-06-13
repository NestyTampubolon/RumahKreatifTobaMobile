import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
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
  }

  @override
  void initState() {
    super.initState();
    _loadResource();

    Timer(Duration(seconds: 2), () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//          ScaleTransition(scale: animation, child:Center(child: Image.asset("assets/images/logo_rkt.png", width: 250,),) ,)
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
