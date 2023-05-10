import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/controllers/toko_controller.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:rumah_kreatif_toba/widgets/tittle_text.dart';

import 'package:get/get.dart';
import '../../../utils/dimensions.dart';

class HomeToko extends StatelessWidget {
  const HomeToko({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<TokoController>().homeToko();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height30, bottom: Dimensions.height10),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(
                          left: Dimensions.width10, right: Dimensions.width10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/logo_rkt.png"))),
                    ),
                    Container(
                      width: Dimensions.width45 * 4,
                      height: 30,
                      margin: EdgeInsets.only(
                          left: Dimensions.width10, right: Dimensions.width10),
                      child: BigText(
                        text: "Toko Kamu",
                        size: Dimensions.font20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: Dimensions.height10,
              shrinkWrap: true,
              childAspectRatio: 2 / 1,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
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
                        right: Dimensions.width20,
                        bottom: Dimensions.height10,
                        top: Dimensions.height10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: TittleText(
                            text: "Pesanan Sedang Berlangsung",
                            size: Dimensions.font20 / 1.5,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          child: BigText(
                            text: "a",
                            size: Dimensions.font16 / 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
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
                        right: Dimensions.width20,
                        bottom: Dimensions.height10,
                        top: Dimensions.height10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: TittleText(
                            text: "Pesanan Berhasil [Belum Konfirmasi Pembayaran]",
                            size: Dimensions.font20 / 1.5,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          child: BigText(
                            text: "0",
                            size: Dimensions.font16 / 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
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
                        right: Dimensions.width20,
                        bottom: Dimensions.height10,
                        top: Dimensions.height10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: TittleText(
                            text: "Pesanan Berhasil [Telah Konfirmasi Pembayaran]",
                            size: Dimensions.font20 / 1.5,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          child: BigText(
                            text: "0",
                            size: Dimensions.font16 / 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
