import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';

// class KategoriProduk extends StatelessWidget {
//   const KategoriProduk({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             height: Dimensions.screenHeight,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage("assets/images/wallpaper_kategori.png"))),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: Dimensions.height30),
//                     alignment: Alignment.center,
//                     child: BigText(
//                       text: "Kategori",
//                       size: Dimensions.height20 * 2,
//                     ),
//                   ),
//                   //MAKANAN
//                   Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(KategoriProdukDetail(), arguments: "Makanan");
//                         },
//                         child: Container(
//                           height: Dimensions.height30 * 4,
//                           width: Dimensions.width45 * 7,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(
//                               left: Dimensions.width45 * 2,
//                               top: Dimensions.height30),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 )
//                               ]),
//                           child: BigText(text: "Makanan"),
//                         ),
//                       ),
//                       Container(
//                         height: Dimensions.height45 * 2,
//                         width: Dimensions.width20 * 4,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(
//                             left: Dimensions.width45, top: Dimensions.height45),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage(
//                                   "assets/images/kategori/makanan.png")),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   //MINUMAN
//                   Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(KategoriProdukDetail(), arguments: "Minuman");
//                         },
//                         child: Container(
//                           height: Dimensions.height30 * 4,
//                           width: Dimensions.width45 * 7,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(
//                               left: Dimensions.width45 * 2,
//                               top: Dimensions.height30),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 )
//                               ]),
//                           child: BigText(text: "Minuman"),
//                         ),
//                       ),
//                       Container(
//                         height: Dimensions.height45 * 2,
//                         width: Dimensions.width20 * 4,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(
//                             left: Dimensions.width45, top: Dimensions.height45),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage(
//                                   "assets/images/kategori/minuman.png")),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   //ULOS
//                   Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(KategoriProdukDetail(), arguments: "Ulos");
//                         },
//                         child: Container(
//                           height: Dimensions.height30 * 4,
//                           width: Dimensions.width45 * 7,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(
//                               left: Dimensions.width45 * 2,
//                               top: Dimensions.height30),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 )
//                               ]),
//                           child: BigText(text: "Ulos"),
//                         ),
//                       ),
//                       Container(
//                         height: Dimensions.height45 * 2,
//                         width: Dimensions.width20 * 4,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(
//                             left: Dimensions.width45, top: Dimensions.height45),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage(
//                                   "assets/images/kategori/ulos.png")),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   //SOUVENIR
//                   Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(KategoriProdukDetail(), arguments: "Souvenir");
//                         },
//                         child: Container(
//                           height: Dimensions.height30 * 4,
//                           width: Dimensions.width45 * 7,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(
//                               left: Dimensions.width45 * 2,
//                               top: Dimensions.height30),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 )
//                               ]),
//                           child: BigText(text: "Souvenir"),
//                         ),
//                       ),
//                       Container(
//                         height: Dimensions.height45 * 2,
//                         width: Dimensions.width20 * 4,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(
//                             left: Dimensions.width45, top: Dimensions.height45),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage(
//                                   "assets/images/kategori/souvenir.png")),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   //PAKAIAN
//                   Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(KategoriProdukDetail(), arguments: "Pakaian");
//                         },
//                         child: Container(
//                           height: Dimensions.height30 * 4,
//                           width: Dimensions.width45 * 7,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(
//                               left: Dimensions.width45 * 2,
//                               top: Dimensions.height30),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 )
//                               ]),
//                           child: BigText(text: "Pakaian"),
//                         ),
//                       ),
//                       Container(
//                         height: Dimensions.height45 * 2,
//                         width: Dimensions.width20 * 4,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(
//                             left: Dimensions.width45, top: Dimensions.height45),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage(
//                                   "assets/images/kategori/pakaian.png")),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   //PERLENGKAPAN RUMAH
//                   Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(KategoriProdukDetail(),
//                               arguments: "Perlengkapan Rumah");
//                         },
//                         child: Container(
//                           height: Dimensions.height30 * 4,
//                           width: Dimensions.width45 * 7,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(
//                               left: Dimensions.width45 * 2,
//                               top: Dimensions.height30),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 )
//                               ]),
//                           child: BigText(text: "Perlengkapan Rumah"),
//                         ),
//                       ),
//                       Container(
//                         height: Dimensions.height45 * 2,
//                         width: Dimensions.width20 * 4,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(
//                             left: Dimensions.width45, top: Dimensions.height45),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage(
//                                   "assets/images/kategori/perlengkapan_rumah.png")),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   //NON HALAL
//                   Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(KategoriProdukDetail(),
//                               arguments: "Non Halal");
//                         },
//                         child: Container(
//                           height: Dimensions.height30 * 4,
//                           width: Dimensions.width45 * 7,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(
//                               left: Dimensions.width45 * 2,
//                               top: Dimensions.height30),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 )
//                               ]),
//                           child: BigText(text: "Non Halal"),
//                         ),
//                       ),
//                       Container(
//                         height: Dimensions.height45 * 2,
//                         width: Dimensions.width20 * 4,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(
//                             left: Dimensions.width45, top: Dimensions.height45),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage(
//                                   "assets/images/kategori/non_halal.png")),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )));
//   }
// }

class KategoriProduk extends StatefulWidget {
  const KategoriProduk({Key? key}) : super(key: key);

  @override
  State<KategoriProduk> createState() => _KategoriProdukState();
}

class _KategoriProdukState extends State<KategoriProduk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blue[100],
        body: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20,
              top: Dimensions.height45,
              right: Dimensions.width20),
          child: BigText(
            text: "Kategori",
            size: Dimensions.font26 * 1.5,
          ),
        ),
        Container(
          height: 300,
          margin: EdgeInsets.only(
              left: Dimensions.width20,
              top: Dimensions.height20,
              right: Dimensions.width20),
          child: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        AppColors.border, //                   <--- border color
                    width: 0.5,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(KategoriProdukDetail(), arguments: "Makanan");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image section
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 2,
                            right: Dimensions.width10 / 2,
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/makanan.png")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 4,
                            right: Dimensions.width10 / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Makanan",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Dimensions.height20 / 2))
                          ],
                        ),
                      )
                      //text container
                    ],
                  ),
                ),
              ),

              //Minuman
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        AppColors.border, //                   <--- border color
                    width: 0.5,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(KategoriProdukDetail(), arguments: "Minuman");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image section
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 2,
                            right: Dimensions.width10 / 2,
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/minuman.png")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 4,
                            right: Dimensions.width10 / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Minuman",
                              size: Dimensions.font20 / 2,
                            ),
                          ],
                        ),
                      )
                      //text container
                    ],
                  ),
                ),
              ),

              //PAKAIAN
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        AppColors.border, //                   <--- border color
                    width: 0.5,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(KategoriProdukDetail(), arguments: "Pakaian");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image section
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 2,
                            right: Dimensions.width10 / 2,
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/pakaian.png")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 4,
                            right: Dimensions.width10 / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Pakaian",
                              size: Dimensions.font20 / 2,
                            ),
                          ],
                        ),
                      )
                      //text container
                    ],
                  ),
                ),
              ),

              //ULOS
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        AppColors.border, //                   <--- border color
                    width: 0.5,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(KategoriProdukDetail(), arguments: "Ulos");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image section
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 2,
                            right: Dimensions.width10 / 2,
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/ulos.png")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 4,
                            right: Dimensions.width10 / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Ulos",
                              size: Dimensions.font20 / 2,
                            ),
                          ],
                        ),
                      )
                      //text container
                    ],
                  ),
                ),
              ),

              //SOUVENIR
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        AppColors.border, //                   <--- border color
                    width: 0.5,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(KategoriProdukDetail(), arguments: "Souvenir");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image section
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 2,
                            right: Dimensions.width10 / 2,
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/souvenir.png")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 4,
                            right: Dimensions.width10 / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Souvenir",
                              size: Dimensions.font20 / 2,
                            ),
                          ],
                        ),
                      )
                      //text container
                    ],
                  ),
                ),
              ),

              //PERLENGKAPAN RUMAH
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color:
                        AppColors.border, //                   <--- border color
                    width: 0.5,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(KategoriProdukDetail(),
                        arguments: "Perlengkapan Rumah");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image section
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 2,
                            right: Dimensions.width10 / 2,
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/Perlengkapan Rumah.png")),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Perlengkapan Rumah",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: Dimensions.height20 / 2))
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //NON HALAL
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.border, //
                    width: 0.5,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(KategoriProdukDetail(), arguments: "Non Halal");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image section
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 2,
                            right: Dimensions.width10 / 2,
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/Non Halal.png")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 4,
                            right: Dimensions.width10 / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Non Halal",
                              size: Dimensions.font20 / 2,
                            ),
                          ],
                        ),
                      )
                      //text container
                    ],
                  ),
                ),
              ),

              //JASA
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.border, //
                    width: 0.5,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(KategoriProdukDetail(), arguments: "Jasa");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image section
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 2,
                            right: Dimensions.width10 / 2,
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/kategori/Jasa.png")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width10 / 4,
                            right: Dimensions.width10 / 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Jasa",
                              size: Dimensions.font20 / 2,
                            ),
                          ],
                        ),
                      )
                      //text container
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
