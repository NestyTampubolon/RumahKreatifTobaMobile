import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/pengiriman_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/currency_format.dart';
import '../../widgets/price_text.dart';

class BeliLangsungPage extends StatefulWidget {
  const BeliLangsungPage({Key? key}) : super(key: key);

  @override
  State<BeliLangsungPage> createState() => _BeliLangsungPageState();
}

class _BeliLangsungPageState extends State<BeliLangsungPage> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengirimanController(pengirimanRepo: Get.find()));
    Get.put(() => PengirimanController(pengirimanRepo: Get.find()));

    Future<void> _beliLangsung(int productId,int jumlahMasukKeranjang, int hargapembelian) async {
      bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
      if (_userLoggedIn) {
        var controller = Get.find<PengirimanController>();
        var userController = Get.find<UserController>().usersList[0];

        controller
            .beliLangsung(userController.id, productId, Get.find<PengirimanController>().paymentIndex,
            jumlahMasukKeranjang, hargapembelian, "", "", "", "")
            .then((status) async {
          if (status.isSuccess) {

          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
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
                        iconColor: AppColors.redColor,
                        backgroundColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width20,
                    ),
                    BigText(
                      text: "Beli Langsung",
                      size: Dimensions.font20,
                    ),
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
                    Container(
                      child: Row(
                        children: [
                          BigText(
                            text: "Barang yang dibeli",
                            size: Dimensions.font20,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                    GetBuilder<CartController>(builder: (cartController) {
                      var _beliList = cartController.getItems;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: cartController.getItems.length,
                          itemBuilder: (_, index) {
                            return Container(
                              width: Dimensions.screenWidth / 1.2,
                              height: Dimensions.height45 * 4,
                              margin: EdgeInsets.only(
                                  right: Dimensions.width10 / 2,
                                  left: Dimensions.width10 / 2,
                                  bottom: Dimensions.height10 / 2,
                                  top: Dimensions.height10 / 2),
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.buttonBackgroundColor),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: Dimensions.height20 * 4,
                                          height: Dimensions.height20 * 4,
                                          margin: EdgeInsets.only(
                                              top: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      "assets/images/coffee.jpg")),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  Dimensions.radius20),
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      ExcludeFocus(
                                        child: Container(
                                          height: Dimensions.height20 * 5,
                                          width: Dimensions.width45 * 3,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: cartController.getItems[index].productName!,
                                                size: Dimensions.font26 / 1.5,
                                              ),
                                              PriceText(
                                                text:
                                                CurrencyFormat.convertToIdr(
                                                    cartController.getItems[index]!.price, 0),
                                                size: Dimensions.font16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: Dimensions.width45 * 3,
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width10,
                                            right: Dimensions.width10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors
                                                    .buttonBackgroundColor),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                cartController.addItem(_beliList[index].produk!, -1);
                                              },
                                              child: AppIcon(
                                                  iconSize:
                                                  Dimensions.iconSize24,
                                                  iconColor: AppColors.redColor,
                                                  backgroundColor: Colors.white,
                                                  icon: Icons.remove),
                                            ),
                                            BigText(
                                              text: _beliList[index].jumlahMasukKeranjang.toString(),
                                              size: Dimensions.font26 / 1.5,
                                            ), //produk.inCartItems.toString()),
                                            GestureDetector(
                                              onTap: () {
                                                cartController.addItem(_beliList[index].produk!, 1);
                                              },
                                              child: AppIcon(
                                                  iconSize:
                                                  Dimensions.iconSize24,
                                                  iconColor: AppColors.redColor,
                                                  backgroundColor: Colors.white,
                                                  icon: Icons.add),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    }),
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
                    Container(
                      child: Row(
                        children: [
                          BigText(
                            text: "Rincian Pengiriman",
                            size: Dimensions.font20,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                    Divider(color: AppColors.buttonBackgroundColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      margin: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.redColor),
                          borderRadius: BorderRadius.circular(
                              Dimensions.radius20 / 2),
                          color: Colors.white),
                      child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor:
                                Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      width: Dimensions
                                          .screenWidth,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius
                                                  .circular(
                                                  Dimensions
                                                      .radius20),
                                              topRight: Radius
                                                  .circular(
                                                  Dimensions
                                                      .radius20))),
                                      padding: EdgeInsets.only(
                                          top: Dimensions
                                              .height30,
                                          left: Dimensions
                                              .width20,
                                          right: Dimensions
                                              .width20),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            GestureDetector(
                                              onTap:(){
                                                Navigator.pop(
                                                    context);
                                              },
                                              child: AppIcon(
                                                icon: CupertinoIcons
                                                    .xmark,
                                                size: Dimensions
                                                    .iconSize24,
                                                iconColor:
                                                AppColors
                                                    .redColor,
                                                backgroundColor:
                                                Colors.white
                                                    .withOpacity(
                                                    0.0),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions
                                                  .width20,
                                            ),
                                            BigText(
                                              text:
                                              "Pilih Pengiriman",
                                              size: Dimensions
                                                  .font26,
                                            ),
                                          ]),
                                          Divider(
                                              color: AppColors
                                                  .buttonBackgroundColor),
                                          Container(
                                            height: 200,
                                            padding: EdgeInsets.only(
                                                left: Dimensions
                                                    .width20,
                                                right: Dimensions
                                                    .width20,
                                                top: Dimensions
                                                    .height20),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(
                                                            () {
                                                          Get.find<
                                                              PengirimanController>()
                                                              .setPaymentIndex(
                                                              1);
                                                        });
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child:
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(Dimensions.radius20 / 4),
                                                        color: Theme.of(context).cardColor,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey[200]!,
                                                              blurRadius: 5,
                                                              spreadRadius: 1)
                                                        ]),
                                                    child:
                                                    ListTile(
                                                      leading:
                                                      Icon(
                                                        Icons
                                                            .money,
                                                        size:
                                                        40,
                                                        color: Get.find<PengirimanController>().paymentIndex ==
                                                            1
                                                            ? AppColors.redColor
                                                            : Theme.of(context).disabledColor,
                                                      ),
                                                      title:
                                                      Text(
                                                        "Ambil Ditempat Rp0",
                                                        style: TextStyle(
                                                            fontSize:
                                                            Dimensions.font20),
                                                      ),
                                                      // subtitle:
                                                      // Text(
                                                      //   "aa",
                                                      //   maxLines:
                                                      //   1,
                                                      //   overflow:
                                                      //   TextOverflow.ellipsis,
                                                      //   style: TextStyle(
                                                      //       color:
                                                      //       Theme.of(context).disabledColor,
                                                      //       fontSize: Dimensions.font16),
                                                      // ),
                                                      trailing: Get.find<PengirimanController>().paymentIndex ==
                                                          1
                                                          ? Icon(
                                                          Icons.check_circle,
                                                          color: Theme.of(context).primaryColor)
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: Dimensions
                                                        .height10),
                                                InkWell(
                                                  onTap: () {
                                                    setState(
                                                            () {
                                                          Get.find<
                                                              PengirimanController>()
                                                              .setPaymentIndex(
                                                              2);
                                                        });
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child:
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(Dimensions.radius20 / 4),
                                                        color: Theme.of(context).cardColor,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey[200]!,
                                                              blurRadius: 5,
                                                              spreadRadius: 1)
                                                        ]),
                                                    child:
                                                    ListTile(
                                                      leading:
                                                      Icon(
                                                        Icons
                                                            .money,
                                                        size:
                                                        40,
                                                        color: Get.find<PengirimanController>().paymentIndex ==
                                                            2
                                                            ? AppColors.redColor
                                                            : Theme.of(context).disabledColor,
                                                      ),
                                                      title:
                                                      Text(
                                                        "Pesanan Dikirim",
                                                        style: TextStyle(
                                                            fontSize:
                                                            Dimensions.font20),
                                                      ),
                                                      //subtitle:
                                                      // Text(
                                                      //   "aa",
                                                      //   maxLines:
                                                      //   1,
                                                      //   overflow:
                                                      //   TextOverflow.ellipsis,
                                                      //   style: TextStyle(
                                                      //       color:
                                                      //       Theme.of(context).disabledColor,
                                                      //       fontSize: Dimensions.font16),
                                                      // ),
                                                      trailing: Get.find<PengirimanController>().paymentIndex ==
                                                          2
                                                          ? Icon(
                                                          Icons.check_circle,
                                                          color: Theme.of(context).primaryColor)
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                                // GestureDetector(
                                                //   onTap: () => {
                                                //     setState(
                                                //             () {
                                                //               Get.find<PengirimanController>().typePengiriman;
                                                //   _metodePembelian[
                                                //   merchantIndex] = 2;
                                                //         }),
                                                //     print(_metodePembelian),
                                                //   Navigator.pop(
                                                //   context)
                                                //   },
                                                //   child: PaymentOptionButton(icon: Icons.money, title: "Pesanan Dikirim", subTitle: "subTitle", index: 2)
                                                // ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(children: [
                            AppIcon(
                              icon: Icons.note,
                              iconColor: AppColors.redColor,
                              backgroundColor:
                              Colors.white.withOpacity(0.0),
                            ),
                            BigText(
                              text: Get.find<
                                  PengirimanController>()
                                  .paymentIndex
                                  .toString() == '0' ? 'Pilih Pengiriman' : Get.find<
                                  PengirimanController>()
                                  .paymentIndex
                                  .toString() == '1' ? 'Ambil Ditempat Rp0' : 'Pesanan Dikirim',
                              size: Dimensions.height15,
                            ),
                          ])),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimensions.bottomHeightBar,
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      bottom: Dimensions.height10,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        height: Dimensions.height30*2,
                        decoration: BoxDecoration(
                            // border: Border.all(
                            //     color: AppColors.buttonBackgroundColor),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: Column(
                          children: [
                            BigText(
                                text: "Total Harga",
                                size: Dimensions
                                    .height15
                            ),
                            PriceText(
                              text: CurrencyFormat.convertToIdr(
                                  cartController.totalAmount, 0),
                              size: Dimensions.font16,
                            ),
                          ],
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.redColor),
                        child: GestureDetector(
                            onTap: () {
                              _beliLangsung(cartController.getItems[0]!.productId!, cartController.getItems[0].jumlahMasukKeranjang!, cartController.totalAmount.toInt());
                            },
                            child: Row(children: [
                              BigText(
                                text: "Beli Langsung",
                                color: Colors.white,
                                  size: Dimensions
                                      .height15
                              ),
                            ])),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
