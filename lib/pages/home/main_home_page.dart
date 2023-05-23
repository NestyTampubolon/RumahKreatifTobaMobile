import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/controllers/auth_controller.dart';
import 'package:rumah_kreatif_toba/controllers/cart_controller.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page_body.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../controllers/popular_produk_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../search/search_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  @override
  void initState() {
    super.initState();
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUser();
      Get.find<CartController>().getKeranjangList();
    }
  }


  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUser();
      Get.find<CartController>().getKeranjangList();
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height30, bottom: Dimensions.height10),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10,
                            right: Dimensions.width10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage("assets/images/logo_rkt.png"))),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10,
                            right: Dimensions.width10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/Bangga_Buatan_Indonesia_Logo.png"))),
                      ),
                    ],
                  ),
                  Center(
                      child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(SearchPage(kategori: 'All',));
                        },
                        child: Container(
                          width: Dimensions.height45,
                          height: Dimensions.height45,
                          child: Icon(
                            Icons.search,
                            color: AppColors.redColor,
                            size: Dimensions.iconSize24,
                          ),
                        ),
                      ),
                      GetBuilder<CartController>(
                          builder: (controller) {
                          return GestureDetector(
                            onTap: () {
                              if(Get.find<AuthController>().userLoggedIn()){
                                Get.toNamed(RouteHelper.getKeranjangPage());
                              }
                              else{
                                Get.toNamed(RouteHelper.getMasukPage());
                              }
                            },
                            child: Stack(
                              children: [
                                AppIcon(icon: Icons.shopping_cart_outlined, size: Dimensions.height45, iconColor: AppColors.redColor, backgroundColor: Colors.white.withOpacity(0.0),),
                                controller.keranjangList.length >= 1
                                    ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: AppColors.notification_success,
                                    ))
                                    : Container(),
                                controller.keranjangList.length >= 1
                                    ? Positioned(
                                  right: 6,
                                  top: 3,
                                  child: BigText(
                                    text: controller.keranjangList.length.toString(),
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          );

                      })

                    ],
                  ))
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: HomePageBody(),
          )),
        ],
      ),
    );
  }
}
