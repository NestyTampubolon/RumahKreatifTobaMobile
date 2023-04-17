import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/popular_produk_controller.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk_detail.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/card_kategori.dart';

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

class KategoriProduk extends StatelessWidget {
  const KategoriProduk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kategori;
    Future<void> _getProduk(PopularProdukController produkController) async {
      produkController.getKategoriProdukList(kategori);
    }

    return Scaffold(
        //backgroundColor: Colors.blue[100],
        body: GetBuilder<PopularProdukController>(builder: (_produkController) {
      return Column(
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
                  Container(
                    child: BigText(text: "Kategori",fontWeight: FontWeight.bold,),
                  ),
                  Center(
                      child: Row(
                        children: [
                          Container(
                            width: Dimensions.height45,
                            height: Dimensions.height45,
                            child: Icon(
                              Icons.search,
                              color: AppColors.redColor,
                              size: Dimensions.iconSize24,
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
                                            iconColor: Colors.transparent,
                                            backgroundColor: AppColors.notification,
                                          ))
                                          : Container(),
                                      controller.keranjangList.length >= 1
                                          ? Positioned(
                                        right: 3,
                                        top: 3,
                                        child: BigText(
                                          text: controller.keranjangList.length.toString(),
                                          size: 12,
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
          Container(
              height: Dimensions.height45 * 5,
              margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10),
              child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: <Widget>[
                    CardKategori(kategori: "Makanan"),
                    CardKategori(kategori: "Minuman"),
                    CardKategori(kategori: "Pakaian"),
                    CardKategori(kategori: "Ulos"),
                    CardKategori(kategori: "Souvenir"),
                    CardKategori(kategori: "Perlengkapan Rumah"),
                    CardKategori(kategori: "Non Halal"),
                    CardKategori(kategori: "Jasa"),

                  ]))
        ],
      );
    }));
  }
}
