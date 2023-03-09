import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/cart_controller.dart';
import 'package:rumah_kreatif_toba/models/produk_models.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'dart:convert';

import '../data/repository/popular_produk_repo.dart';
import '../models/cart_models.dart';


class PopularProdukController extends GetxController{
  final PopularProdukRepo popularProdukRepo;
  PopularProdukController({required this.popularProdukRepo});
  List<dynamic> _popularProdukList=[];
  List<dynamic> get popularProdukList => _popularProdukList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getPopularProdukList() async{
    Response response = await popularProdukRepo.getPopularProdukList();
    if(response.statusCode == 200){
      List<dynamic> responseBody = response.body;
      _popularProdukList = [];
      for (dynamic item in responseBody) {
        Produk produk = Produk.fromJson(item);
        _popularProdukList.add(produk);
      }
      _isLoaded = true;
      update();
    }else{

    }
  }

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity + 1);
    }else{
      _quantity = checkQuantity(_quantity - 1);
      // print("decrement " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Batas Item", "Item sudah mencapai batas",
      backgroundColor: AppColors.redColor,
        colorText: Colors.white
      );
      if(_inCartItems > 0 ){
        _quantity = - _inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity) > 20){
      Get.snackbar("Batas Item", "Item sudah mencapai batas",
          backgroundColor: AppColors.redColor,
          colorText: Colors.white
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduk(Produk produk,CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(produk);
    print("exist or not "+ exist.toString());
    // var exist = false;
  }

  void addItem(Produk produk){
        _cart.addItem(produk, _quantity);
        _quantity = 0;
        _inCartItems = _cart.getQuantity(produk);
        _cart.items.forEach((key, value) {
          print("The id is " + value.productId.toString() + " The quantity is " + value.jumlahMasukKeranjang.toString());
        });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }
  // int get totalItems{
  //   return _cart.totalItems;
  // }

}