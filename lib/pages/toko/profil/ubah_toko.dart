import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/toko/namatoko.dart';
import '../../../controllers/toko_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_date_field.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/input_text_field.dart';

class UbahTokoPage extends StatefulWidget {
  const UbahTokoPage({Key? key}) : super(key: key);

  @override
  State<UbahTokoPage> createState() => _UbahTokoPageState();
}

class _UbahTokoPageState extends State<UbahTokoPage> {
  @override
  Widget build(BuildContext context) {
    var profilToko = Get.find<TokoController>().profilTokoList;
    final NamaTokoController = TextEditingController(text: profilToko[0].nama_merchant);
    final DeskripsiTokoController = TextEditingController(text:profilToko[0].deskripsi_toko);
    var KontakTokoController = TextEditingController(text : profilToko[0].kontak_toko);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back,
                            iconColor: AppColors.redColor,
                            backgroundColor: Colors.white,
                            iconSize: Dimensions.iconSize24,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        ),
                        Container(
                          child: BigText(
                            text: "Ubah Profil Toko",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  // Nama Toko
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: BigText(
                      text: "Nama Toko",
                      size: Dimensions.font16,
                    ),
                  ),
                  InputTextField(
                    textController: NamaTokoController,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  // Deskripsi Toko
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: BigText(
                      text: "Deskripsi Toko",
                      size: Dimensions.font16,
                    ),
                  ),
                  InputTextField(
                    textController: DeskripsiTokoController,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  // Kontak Toko
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: BigText(
                      text: "Kontak Toko",
                      size: Dimensions.font16,
                    ),
                  ),
                  InputTextField(
                    textController: KontakTokoController,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),

                  // Nomor Handphone
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: BigText(
                      text: "Foto Toko",
                      size: Dimensions.font16,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.height10),
                      height: Dimensions.height45*3,
                      width: Dimensions.width45*3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius15)),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                '${AppConstants.BASE_URL_IMAGE}u_file/foto_merchant/${profilToko[0].foto_merchant}',
                              )  )),
                    ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height20),
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height20,
                            bottom: Dimensions.height20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: BigText(text:"Ubah Foto", color: AppColors.redColor,size: Dimensions.font26/2,)
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height45,
                  ),
                  GestureDetector(
                    onTap: (){
                    },
                    child: Center(
                      child: Container(
                        width: Dimensions.width45*3,
                        height: Dimensions.width45,
                        // alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.redColor),
                        child: Center(
                          child: BigText(
                            text: "Ubah",
                            fontWeight: FontWeight.bold,
                            size: Dimensions.font20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )


                ]),
          ],
        ),
      ),
    );
  }
}
