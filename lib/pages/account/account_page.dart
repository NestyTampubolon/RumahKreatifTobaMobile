import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/controllers/auth_controller.dart';
import 'package:rumah_kreatif_toba/pages/account/account_widget.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_icon.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../widgets/small_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.redColor,
        title: BigText(
          text: "Profil", size: 24,color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child:Column(
          children: [
            AppIcon(icon: Icons.person, backgroundColor: AppColors.redColor,
              iconColor: Colors.white, iconSize: 65, size: Dimensions.height15*8,
            ),
            SizedBox(height: Dimensions.height20,),
            Container(
              child: Column(
                children: [
                  BigText(text: "Nesty Gloria Tampubolon"),
                  SmallText(text: "nestytampubolon61@gmail.com"),
                  SmallText(text: "082276636822")
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20,),
            //Profil
            AccountWidget(
                appIcon: AppIcon(icon: Icons.person,
            backgroundColor: AppColors.redColor,
            iconColor: Colors.white,
            iconSize: Dimensions.height10*5/2,
            size: Dimensions.height10*5,),
                 bigText: BigText(text: "Profil",)),
            SizedBox(height: Dimensions.height20,),

            //Keranjangku
            GestureDetector(
              onTap: (){
                if(Get.find<AuthController>().userLoggedIn()){
                  Get.toNamed(RouteHelper.getKeranjangPage());
                }
              },
              child:AccountWidget(
                  appIcon: AppIcon(icon: Icons.house_siding_outlined,
                    backgroundColor: AppColors.redColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10*5/2,
                    size: Dimensions.height10*5,),
                  bigText: BigText(text: "Buka Toko",)) ,
            ),
            SizedBox(height: Dimensions.height20,),

            //Keranjangku
            GestureDetector(
              onTap: (){
                if(Get.find<AuthController>().userLoggedIn()){
                  Get.toNamed(RouteHelper.getKeranjangPage());
                }
              },
              child:AccountWidget(
                  appIcon: AppIcon(icon: Icons.shopping_cart_outlined,
                    backgroundColor: AppColors.redColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10*5/2,
                    size: Dimensions.height10*5,),
                  bigText: BigText(text: "Keranjangku",)) ,
            ),
            SizedBox(height: Dimensions.height20,),

            //Pesananku
            GestureDetector(
              onTap: (){
                if(Get.find<AuthController>().userLoggedIn()){
                  Get.find<AuthController>().clearSharedData();
                  Get.offNamed(RouteHelper.getInitial());
                }
              },
              child:AccountWidget(
                  appIcon: AppIcon(icon: Icons.shopping_bag_outlined,
                    backgroundColor: AppColors.redColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10*5/2,
                    size: Dimensions.height10*5,),
                  bigText: BigText(text: "Pesananku",)) ,
            ),
            SizedBox(height: Dimensions.height20,),

            //Keluar
            GestureDetector(
              onTap: (){
                if(Get.find<AuthController>().userLoggedIn()){
                  Get.find<AuthController>().clearSharedData();
                  Get.offNamed(RouteHelper.getInitial());
                }else{
                  print("Anda sudah keluar");
                }
              },
              child:AccountWidget(
                  appIcon: AppIcon(icon: Icons.logout_sharp,
                    backgroundColor: AppColors.redColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10*5/2,
                    size: Dimensions.height10*5,),
                  bigText: BigText(text: "Keluar",)) ,
            )

          ],
        ),
      )



    );
  }
}
