import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/base/custom_loader.dart';
import 'package:rumah_kreatif_toba/controllers/auth_controller.dart';
import 'package:rumah_kreatif_toba/controllers/toko_controller.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/pages/account/account_widget.dart';
import 'package:rumah_kreatif_toba/pages/account/profil/profil_page.dart';
import 'package:rumah_kreatif_toba/pages/auth/masuk.dart';
import 'package:rumah_kreatif_toba/pages/pesanan/pesanan_page.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_icon.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../models/users_models.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widgets/small_text.dart';
import '../auth/register.dart';
import '../home/home_page.dart';
import 'main_account_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUser();
    }
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppColors.redColor,
        //   title: BigText(
        //     text: "Profil",
        //     size: 24,
        //     color: Colors.white,
        //   ),
        // ),
        body: _userLoggedIn
            ? GetBuilder<UserController>(
                builder: (userController) {
                  return userController.isLoading
                      ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: Dimensions.height30,
                                    bottom: Dimensions.height10),
                                padding: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: BigText(
                                        text: "Profil",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: Dimensions.width45*1.5,
                                  height: Dimensions.height45*1.5,
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width20, right: Dimensions.width20),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage("assets/images/ikon/profile.png"))),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                          text: userController.usersList[0].username
                                              .toString()),
                                      SmallText(
                                          text: userController.usersList[0].email
                                              .toString()),
                                      SmallText(
                                          text: userController.usersList[0].noHp
                                              .toString())
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),

                            //Profil
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>()
                                    .userLoggedIn()) {
                                  Get.to(ProfilPage());
                                }
                              },
                              child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor:
                                    Colors.white.withOpacity(0.0),
                                    iconColor: AppColors.redColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Profil",
                                  )),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),

                            //Keranjangku
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>()
                                    .userLoggedIn()) {
                                  Get.find<TokoController>()
                                      .cekVerifikasi();
                                }
                              },
                              child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.store,
                                    backgroundColor:
                                    Colors.white.withOpacity(0.0),
                                    iconColor: AppColors.redColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Toko",
                                  )),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),

                            //Keranjangku
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>()
                                    .userLoggedIn()) {
                                  Get.toNamed(
                                      RouteHelper.getKeranjangPage());
                                }
                              },
                              child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.shopping_cart_outlined,
                                    backgroundColor:
                                    Colors.white.withOpacity(0.0),
                                    iconColor: AppColors.redColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Keranjangku",
                                  )),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),

                            //Pesananku
                            GestureDetector(
                              onTap: () {
                                Get.to(PesananPage());
                              },
                              child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.receipt_long_outlined,
                                    backgroundColor:
                                    Colors.white.withOpacity(0.0),
                                    iconColor: AppColors.redColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Pesananku",
                                  )),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //Alamat
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>()
                                    .userLoggedIn()) {
                                  Get.toNamed(
                                    RouteHelper.getDaftarAlamatPage(),
                                  );
                                }
                              },
                              child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.location_on_outlined,
                                    backgroundColor:
                                    Colors.white.withOpacity(0.0),
                                    iconColor: AppColors.redColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Alamat",
                                  )),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),

                            //Keluar
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>()
                                    .userLoggedIn()) {
                                  Get.find<AuthController>()
                                      .clearSharedData();
                                  Get.offNamed(RouteHelper.getInitial());
                                } else {
                                  Get.to(
                                          () => HomePage(initialIndex: 0));
                                  print("Anda sudah keluar");
                                }
                              },
                              child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout_sharp,
                                    backgroundColor:
                                    Colors.white.withOpacity(0.0),
                                    iconColor: AppColors.redColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Keluar",
                                  )),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                          ],
                        ),
                      )) : CustomLoader();
                },
              )
            : MainAccountPage());
  }
}
