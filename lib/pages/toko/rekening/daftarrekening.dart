import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/controllers/bank_controller.dart';
import 'package:rumah_kreatif_toba/main.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/tittle_text.dart';
import '../databank.dart';
import '../hometoko/hometoko_page.dart';
import 'package:get/get.dart';
class DaftarRekening extends StatefulWidget {
  const DaftarRekening({Key? key}) : super(key: key);

  @override
  State<DaftarRekening> createState() => _DaftarRekeningState();
}

class _DaftarRekeningState extends State<DaftarRekening> {
  @override
  Widget build(BuildContext context) {
    Get.find<BankController>().getRekeningList();
    Future<void> _hapusRekening(int rekening_id) async {
      var controller = Get.find<BankController>();
      controller.hapusRekening(rekening_id).then((status) async {

      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Dimensions.height45, left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(HomeTokoPage(initialIndex: 3)); // Pass the initial index to the HomeTokoPage constructor
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
                          text: "Rekening",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(DataBankPage());
                    },
                    child:  Container(
                        child: Icon(
                          Icons.add,
                          color: AppColors.redColor,
                        )),
                  )
                ],
              ),
            ),
            GetBuilder<BankController>(builder: (controller) {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: Dimensions.height45*3),
                  itemCount: controller.daftarRekeningList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            )
                          ]),
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          top: Dimensions.height10),
                      padding: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                           Container(
                             child: TittleText(
                               text: "Rekening",
                               size: Dimensions.font20 / 1.5,
                             ),
                           ),
                             GestureDetector(
                               onTap: () {
                                 _hapusRekening(controller.daftarRekeningList[index].rekeningId);
                               },
                               child: AppIcon(
                                   iconSize: Dimensions
                                       .iconSize16,
                                   iconColor: AppColors
                                       .redColor,
                                   backgroundColor:
                                   Colors.white,
                                   icon: Icons.delete),
                             ),
                         ],),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          BigText(
                            text: controller.daftarRekeningList[index].atasNama.toString(),
                            size: Dimensions.font16 / 1.5,
                          ),
                          BigText(
                            text: controller.daftarRekeningList[index].namaBank.toString(),
                            size: Dimensions.font16 / 1.5,
                          ),
                          BigText(
                            text: controller.daftarRekeningList[index].nomorRekening.toString(),
                            size: Dimensions.font16 / 1.5,
                          ),
                        ],
                      ),
                    );
                  }
              );
            })
          ],
        ),
      ),
    );
  }
}
