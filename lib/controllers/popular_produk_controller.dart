import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/cart_controller.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/models/produk_models.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'dart:convert';

import '../base/show_custom_message.dart';
import '../data/repository/produk_repo.dart';
import '../models/cart_models.dart';
import '../models/response_model.dart';
import '../pages/produk/produk_detail.dart';
import '../routes/route_helper.dart';


class PopularProdukController extends GetxController{
  final PopularProdukRepo popularProdukRepo;
  PopularProdukController({required this.popularProdukRepo});
  List<dynamic> _popularProdukList=[];
  List<dynamic> get popularProdukList => _popularProdukList;

  List<dynamic> _produkmakananminumanList=[];
  List<dynamic> get produkMakananMinumanList => _produkmakananminumanList;

  List<dynamic> _produkPakaianList=[];
  List<dynamic> get produkPakaianList => _produkPakaianList;

  List<dynamic> _produkTerbaruList=[];
  List<dynamic> get produkTerbaruList => _produkTerbaruList;

  List<dynamic> _detailProdukList=[];
  List<dynamic> get detailProdukList => _detailProdukList;

  List<dynamic> _imageProdukList=[];
  List<dynamic> get imageProdukList => _imageProdukList;

  List<dynamic> _kategoriProdukList=[];
  List<dynamic> get kategoriProdukList => _kategoriProdukList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProdukList() async{
    Response response = await popularProdukRepo.getPopularProdukList();
    if(response.statusCode == 200){
      List<dynamic> responseBodyproduk = response.body["products"];
      _popularProdukList = [];
      for (dynamic item in responseBodyproduk) {
        Produk produk = Produk.fromJson(item);
        _popularProdukList.add(produk);
      }


      late ResponseModel responseModel;
      if (response.statusCode == 200) {
        List<dynamic> responseBody = response.body["produk_makanan_minuman_terlaris"];
        _produkmakananminumanList.clear();
        for (dynamic item in responseBody) {
          Produk produk = Produk.fromJson(item);
          _produkmakananminumanList.add(produk);
        }

        List<dynamic> responseBodyTerlaris= response.body["produk_pakaian_terlaris"];
        _produkPakaianList.clear();
        for (dynamic item in responseBodyTerlaris) {
          Produk produk = Produk.fromJson(item);
          _produkPakaianList.add(produk);
        }

        List<dynamic> responseBodyTerbaru= response.body["new_products"];
        _produkTerbaruList.clear();
        for (dynamic item in responseBodyTerbaru) {
          Produk produk = Produk.fromJson(item);
          _produkTerbaruList.add(produk);
        }

        List<dynamic> responseBodyImage= response.body["product_images"];
        _imageProdukList.clear();
        for (dynamic item in responseBodyImage) {
          Produk produk = Produk.fromJson(item);
          _imageProdukList.add(produk);
        }

        responseModel = ResponseModel(true, "successfully");
      } else {
        responseModel = ResponseModel(false, response.statusText!);
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
    var controller = Get.find<UserController>().usersList[0];
    Response response = await popularProdukRepo.getProdukList(controller.id!);
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

  Future<ResponseModel> hapusProduk(int product_id) async {
    Response response = await popularProdukRepo.hapusProduk(product_id);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      showCustomSnackBar("Produk berhasil dihapus",
          title: "Berhasil");
      getProdukList();
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoaded = true;
    update();
    return responseModel;
  }



  Future<ResponseModel> detailProduk(int product_id) async {
    Response response = await popularProdukRepo.detailProduk(product_id);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body;
      _detailProdukList.clear();
      for (dynamic item in responseBody) {
        Produk produk = Produk.fromJson(item);
        _detailProdukList.add(produk);
      }
      print("halloo ${product_id}");
      Get.to(ProdukDetail());
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoaded = false;
    update();
    return responseModel;
  }

}