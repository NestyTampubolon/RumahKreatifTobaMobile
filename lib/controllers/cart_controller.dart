import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_models.dart';
import '../models/produk_models.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(Produk produk, int jumlahMasukKeranjang) {
    var totalQuantity = 0;
    if (_items.containsKey(produk.productId)) {
      _items.update(produk.productId!, (value) {
        totalQuantity = value.jumlahMasukKeranjang! + jumlahMasukKeranjang;
        return CartModel(
          productId: value.productId,
          jumlahMasukKeranjang: value.jumlahMasukKeranjang! + jumlahMasukKeranjang,
          merchantId: value.merchantId,
          categoryId: value.categoryId,
          productName: value.productName,
          price: value.price,
          heavy: value.heavy,
        );
      });

      if(totalQuantity <=0){
        _items.remove(produk.productId);
      }

    } else {
      print("length of the item is " + _items.length.toString());
      _items.putIfAbsent(produk.productId!, () {
        print("adding item to the cart " +
            produk.productId!.toString() +
            " quantity " +
            jumlahMasukKeranjang.toString());
        _items.forEach((key, value) {
          print("quantity is " + value.jumlahMasukKeranjang.toString());
        });
        return CartModel(
          productId: produk.productId,
          jumlahMasukKeranjang: jumlahMasukKeranjang,
          merchantId: produk.merchantId,
          categoryId: produk.categoryId,
          productName: produk.productName,
          price: produk.price,
          heavy: produk.heavy,
        );
      });
    }
  }

  // Map<int, CartModel> get items => _items;

  // void addItem(Produk produk, int jumlahMasukKeranjang) {
  //   var totalQuantity = 0;
  //   if(_items.containsKey(produk.productId!)){
  //     _items.update(produk.productId!, (value){
  //       totalQuantity = value.jumlahMasukKeranjang! + jumlahMasukKeranjang;
  //       return CartModel(
  //         productId: value.productId,
  //         jumlahMasukKeranjang: value.jumlahMasukKeranjang! + jumlahMasukKeranjang,
  //         merchantId: value.merchantId,
  //         categoryId: value.categoryId,
  //         productName: value.productName,
  //         price: value.price,
  //         heavy: value.heavy,
  //       );
  //     });
  //   }else{
  //     if(jumlahMasukKeranjang > 0 ){
  //       _items.putIfAbsent(produk.productId!, () {
  //         print("adding item to the cart id " + produk.productId!.toString() + " quantity");
  //         _items.forEach((key, value) {
  //           print("quantity is " + value.jumlahMasukKeranjang.toString());
  //         });
  //         return CartModel(
  //           productId: produk.productId,
  //           jumlahMasukKeranjang: jumlahMasukKeranjang,
  //           merchantId: produk.merchantId,
  //           categoryId: produk.categoryId,
  //           productName: produk.productName,
  //           price: produk.price,
  //           heavy: produk.heavy,
  //         );
  //       });
  //
  //       if(totalQuantity <= 0 ){
  //         _items.remove(produk.productId);
  //       }
  //     }else{
  //       Get.snackbar("Batas Item", "Jumlah item tidak ada",
  //           backgroundColor: AppColors.redColor,
  //           colorText: Colors.white
  //       );
  //     }
  //
  //   }
  //
  // }

  bool existInCart(Produk produk){
    if(_items.containsKey(produk.productId)){
      return true;
    }
    return false;
  }

  int getQuantity(Produk produk){
    var quantity = 0;
    if(_items.containsKey(produk.productId)){
      _items.forEach((key, value) {
        if(key == produk.productId){
          quantity = value.jumlahMasukKeranjang!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.jumlahMasukKeranjang!;
    });
    return totalQuantity;
  }


  // int get totalItems{
  //   var totalQuantity = 0;
  //   _items.forEach((key, value) {
  //       totalQuantity += value.jumlahMasukKeranjang!;
  //
  //   });
  //   return totalQuantity;
  // }
}
