import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rumah_kreatif_toba/data/api/api_client.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/pesanan_controller.dart';
import '../../routes/route_helper.dart';

import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/price_text.dart';
import '../../widgets/small_text.dart';
import '../pesanan/pesanan_page.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({Key? key}) : super(key: key);

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {


  // final ImagePicker picker = ImagePicker();
  //
  // //we can upload image from camera or from gallery based on parameter
  // Future<void> getImage(ImageSource media) async {
  //   final XFile? pickedFile = await picker.pickImage(source: media);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       image = pickedFile;
  //     });
  //   }
  // }

  // //show popup dialog
  // void myAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           title: Text('Pilih media'),
  //           content: Container(
  //             height: MediaQuery.of(context).size.height / 6,
  //             child: Column(
  //               children: [
  //                 ElevatedButton(
  //                   //if user click this button, user can upload image from gallery
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     getImage(ImageSource.gallery);
  //                   },
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.image),
  //                       Text('  Galeri'),
  //                     ],
  //                   ),
  //                 ),
  //                 ElevatedButton(
  //                   //if user click this button. user can upload image from camera
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     getImage(ImageSource.camera);
  //                   },
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.camera),
  //                       Text('  Kamera'),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    var detailPesanan = Get.find<PesananController>().detailPesanan;

    List<int> _purchaseId = [];

    Future<void> uploadProofOfPayment() async {

        var controller = Get.find<PesananController>();
        controller.postBuktiPembayaran(detailPesanan[0].purchaseId).then((status) async {
          Get.to(PesananPage());
        });
    }

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width20,
                    ),
                    BigText(
                      text: "Pembayaran",
                      size: Dimensions.font20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              GetBuilder<PesananController>(builder: (pesananController) {
                var _pesananList = pesananController.detailPesananList;

                for (var item in _pesananList) {
                  if (!_purchaseId.contains(item.purchaseId)) {
                    _purchaseId.add(item.purchaseId);
                  }
                }
                return Container();
              }),
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ]),
                margin: EdgeInsets.only(top: Dimensions.height20),
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: Dimensions.height30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: detailPesanan[0].kodePembelian.toString(),
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        ),
                        // SmallText(text: detailPesanan[0].createdAt.toString())
                      ],
                    ),
                    Divider(color: AppColors.buttonBackgroundColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          child: Row(
                            children: [
                              BigText(
                                text: "Detail Pembayaran",
                                size: Dimensions.font16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          child: Row(
                            children: [
                              BigText(
                                text: "Total Harga",
                                size: Dimensions.font16,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          child: Row(
                            children: [
                              PriceText(
                                text: CurrencyFormat.convertToIdr(
                                    detailPesanan[0].hargaPembelian, 0),
                                size: Dimensions.font16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: "Total Ongkos Kirim",
                            size: Dimensions.font16,
                          ),
                          PriceText(
                            text: CurrencyFormat.convertToIdr(
                                detailPesanan[0].ongkir, 0),
                            size: Dimensions.font16,
                          ),
                        ],
                      ),
                    ),
                    Divider(color: AppColors.buttonBackgroundColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "Total Belanja",
                          size: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        ),
                        PriceText(
                          text: CurrencyFormat.convertToIdr(
                              detailPesanan[0].hargaPembelian + detailPesanan[0].ongkir, 0),
                          size: Dimensions.font16,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ]),
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  padding: EdgeInsets.only(
                      top: Dimensions.height30,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height30),
                  child: Column(
                    children: [
                      SmallText(
                        text:
                            "SILAHKAN LAKUKAN PEMBAYARAN PESANAN ANDA KE NOMOR REKENING DIBAWAH INI.A/N Riyanthi A Sianturi",
                        size: Dimensions.font16,
                      ),
                      Container(
                        width: Dimensions.screenWidth / 1.35,
                        margin: EdgeInsets.only(
                            bottom: Dimensions.height10 / 2,
                            top: Dimensions.height10),
                        padding: EdgeInsets.all(Dimensions.height10),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.redColor),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20 / 2),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/Mandiri.png"))),
                            ),
                            SmallText(
                              text: "1070018822454",
                              size: Dimensions.font20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                FlutterClipboard.copy("1070018822454")
                                    .then((value) => print('copied'));
                                Get.snackbar('Salin', 'Berhasil disalin');
                                // copied successfully
                              },
                              child: AppIcon(
                                icon: Icons.copy,
                                size: Dimensions.height45,
                                iconColor: AppColors.redColor,
                                backgroundColor: Colors.white.withOpacity(0.0),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
        GetBuilder<PesananController>(builder: (pesananController) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(Dimensions.height20),
                padding: EdgeInsets.all(Dimensions.height20),
                width: Dimensions.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                    color: AppColors.redColor),
                child: GestureDetector(
                    onTap: () {
                      pesananController.pickImage();
                    },
                    child: Row(children: [
                      BigText(
                        text: "Pilih Gambar",
                        color: Colors.white,
                        size: Dimensions.height15,
                      ),
                    ])),
              ),
              pesananController.pickedFile != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    //to show image, you type like this.
                    File(pesananController.pickedFile!.path),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
              )
                  : Text(
                "Tidak ada gambar",
                style: TextStyle(fontSize: 20),
              )
            ],
          );
        }),


            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<PesananController>(
          builder: (pesananController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimensions.height45 * 2,
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      bottom: Dimensions.height10,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20/4),
                            color: AppColors.redColor),
                        child: GestureDetector(
                            onTap: () {
                              uploadProofOfPayment();
                            },
                            child: Row(children: [
                              BigText(
                                text: "Beli",
                                color: Colors.white,
                                size: Dimensions.height15,
                              ),
                            ])),
                      ),
                      // Container(
                      //   alignment : Alignment.center,
                      //   width: double.infinity,
                      //   height: 180,
                      //   color: Colors.grey[300],
                      //   child: pesananController.imagePath != null
                      //   ? Image.network(AppConstants.BASE_URL+AppConstants.BUKTI_PEMBAYARAN.imagePat)
                      //   ,
                      // )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
