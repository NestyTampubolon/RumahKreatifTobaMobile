import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/cart_controller.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/models/produk_models.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'dart:convert';

import '../data/repository/produk_repo.dart';
import '../models/cart_models.dart';


class PopularProdukController extends GetxController{
  final PopularProdukRepo popularProdukRepo;
  PopularProdukController({required this.popularProdukRepo});
  List<dynamic> _popularProdukList=[];
  List<dynamic> get popularProdukList => _popularProdukList;

  List<dynamic> _kategoriProdukList=[];
  List<dynamic> get kategoriProdukList => _kategoriProdukList;
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

  Future<void> getKategoriProdukList(String namaKategori) async{
    Response response = await popularProdukRepo.getKategoriProdukList(namaKategori);
    if(response.statusCode == 200){
      List<dynamic> responseBody = response.body;
      _kategoriProdukList = [];
      for (dynamic item in responseBody) {
        Produk produk = Produk.fromJson(item);
        _kategoriProdukList.add(produk);
      }
      _isLoaded = true;
      update();
    }else{

    }
  }


  //Daftar Produk sesuai merchant
  List<dynamic> _daftarProdukList=[];
  List<dynamic> get daftarProdukList => _daftarProdukList;

  Future<void> getProdukList() async{
    var controller = Get.find<UserController>();
    Response response = await popularProdukRepo.getProdukList(controller.users.id!);
    if(response.statusCode == 200){
      List<dynamic> responseBody = response.body;
      _daftarProdukList = [];
      for (dynamic item in responseBody) {
        Produk produk = Produk.fromJson(item);
        _daftarProdukList.add(produk);
      }
      _isLoaded = true;
      update();
    }else{

    }
  }

}