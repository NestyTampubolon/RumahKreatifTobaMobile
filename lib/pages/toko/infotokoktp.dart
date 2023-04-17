import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/pages/toko/daftarberhasil.dart';
import 'package:rumah_kreatif_toba/pages/toko/namatoko.dart';
import 'package:rumah_kreatif_toba/pages/toko/toko.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_text_field.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../home/home_page.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TokoKTP extends StatefulWidget {
  const TokoKTP({Key? key}) : super(key: key);

  @override
  State<TokoKTP> createState() => _TokoKTPState();
}

class _TokoKTPState extends State<TokoKTP> {
  XFile? image1;
  XFile? image2;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.border),
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => NamaToko());
                          },
                          child: AppIcon(icon: Icons.arrow_back),
                        ),
                        Container(
                          width: 250,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: BigText(
                            text: "Masukkan Info Toko",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  child: BigText(
                    text: "Foto KTP *",
                    fontWeight: FontWeight.bold,
                    size: Dimensions.font20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(children: [
                    image1 != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(image1!.path),
                                fit: BoxFit.cover,
                                width: 160,
                                height: 100,
                              ),
                            ),
                          )
                        : Text(
                            "Tidak ada gambar",
                            style: TextStyle(fontSize: 10),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.border,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        KTP();
                      },
                      child: Text('Upload Foto KTP'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "Pastikan gambar yang anda masukkan dapat dilihat dengan jelas",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Container(
                  child: BigText(
                    text: "Foto Selfie Bersama KTP *",
                    fontWeight: FontWeight.bold,
                    size: Dimensions.font20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(children: [
                    image2 != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(image2!.path),
                                fit: BoxFit.cover,
                                width: 160,
                                height: 100,
                              ),
                            ),
                          )
                        : Text(
                            "Tidak ada gambar",
                            style: TextStyle(fontSize: 10),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.border,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        WithKTP();
                      },
                      child: Text('Upload Foto Selfie dengan KTP'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "Pastikan gambar yang anda masukkan dapat dilihat dengan jelas",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => {Get.to(() => DaftarBerhasil())},
              child: Container(
                  width: 306,
                  height: 45,
                  // alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border, width: 3),
                      color: AppColors.border),
                  child: Center(
                    child: BigText(
                      text: "Lanjut",
                      fontWeight: FontWeight.bold,
                      size: Dimensions.font20,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future getImage1(ImageSource media) async {
    var imgktp = await picker.pickImage(source: media);
    setState(() {
      image1 = imgktp;
    });
  }

  Future getImage2(ImageSource media) async {
    var imgwktp = await picker.pickImage(source: media);
    setState(() {
      image2 = imgwktp;
    });
  }

  void KTP() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Pilih media yang akan dipilih'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage1(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('Dari Galeri'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage1(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('Dari Kamera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void WithKTP() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Pilih media yang akan dipilih'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage2(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('Dari Galeri'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage2(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('Dari Kamera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
