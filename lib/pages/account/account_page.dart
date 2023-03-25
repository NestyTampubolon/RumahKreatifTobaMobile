import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/base/custom_loader.dart';
import 'package:rumah_kreatif_toba/controllers/auth_controller.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/pages/account/account_widget.dart';
import 'package:rumah_kreatif_toba/pages/auth/masuk.dart';
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

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    print("konfirmasi");
    print(_userLoggedIn);
    if (_userLoggedIn) {
      Get.find<UserController>().getUser();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.redColor,
          title: BigText(
            text: "Profil",
            size: 24,
            color: Colors.white,
          ),
        ),
        body: _userLoggedIn
            ? GetBuilder<UserController>(
                builder: (userController) {
                  print(userController.users.username);
                  print(userController.isLoading);
                  return userController.isLoading
                      ? CustomLoader()
                      : Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: Dimensions.height20),
                          child: Column(
                            children: [
                              AppIcon(
                                icon: Icons.person,
                                backgroundColor: AppColors.redColor,
                                iconColor: Colors.white,
                                iconSize: 65,
                                size: Dimensions.height15 * 8,
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    BigText(
                                        text: userController.users.username
                                            .toString()),
                                    SmallText(
                                        text: userController.users.email
                                            .toString()),
                                    SmallText(
                                        text: userController.users.noHp
                                            .toString())
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //Profil
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: AppColors.redColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Profil",
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              //Keranjangku
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    // Get.toNamed(RouteHelper.getKeranjangPage());
                                    print(userController.users.name.toString());
                                  }
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.house_siding_outlined,
                                      backgroundColor: AppColors.redColor,
                                      iconColor: Colors.white,
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
                                    Get.toNamed(RouteHelper.getKeranjangPage());
                                  }
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.shopping_cart_outlined,
                                      backgroundColor: AppColors.redColor,
                                      iconColor: Colors.white,
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
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.offNamed(RouteHelper.getInitial());
                                  }
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.shopping_bag_outlined,
                                      backgroundColor: AppColors.redColor,
                                      iconColor: Colors.white,
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

                              //Keluar
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.offNamed(RouteHelper.getInitial());
                                  } else {
                                    print("Anda sudah keluar");
                                  }
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout_sharp,
                                      backgroundColor: AppColors.redColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: "Keluar",
                                    )),
                              )
                            ],
                          ),
                        );
                },
              )
            : Container(
                child: Center(
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 5,
                    margin: EdgeInsets.only(
                        left: Dimensions.width45, right: Dimensions.width45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Masuk(), transition: Transition.fadeIn);
                          },
                          child: Container(
                              width: Dimensions.screenWidth / 3,
                              height: Dimensions.screenHeight / 16,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius30),
                                  color: AppColors.redColor),
                              child: Center(
                                child: BigText(
                                    text: "Masuk",
                                    size: Dimensions.font20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),

                        SizedBox(
                          width: Dimensions.width20,
                        ),
                        //daftar
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Register(), transition: Transition.fadeIn);
                          },
                          child: Container(
                              width: Dimensions.screenWidth / 3,
                              height: Dimensions.screenHeight / 16,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: Colors.white,
                                border: Border.all(color: AppColors.redColor),
                              ),
                              child: Center(
                                child: BigText(
                                    text: "Daftar",
                                    size: Dimensions.font20,
                                    color: AppColors.redColor,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
