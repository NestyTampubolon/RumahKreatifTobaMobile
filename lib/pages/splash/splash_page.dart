import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

import '../../controllers/popular_produk_controller.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProdukController>().getPopularProdukList();
  }

  @override
  void initState(){
    super.initState();
    _loadResource();

    Timer(
      Duration(seconds: 2),
        () => Get.offNamed(RouteHelper.getInitial())
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//          ScaleTransition(scale: animation, child:Center(child: Image.asset("assets/images/logo_rkt.png", width: 250,),) ,)
          Center(child: Image.asset("assets/images/logo_rkt.png", width: Dimensions.splashImg,),) ,

        ],
      ),
    );
  }
}
