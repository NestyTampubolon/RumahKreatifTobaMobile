import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/data/repository/wishlist_repo.dart';
import 'package:rumah_kreatif_toba/models/wishlist_models.dart';

import '../base/show_custom_message.dart';
import '../models/response_model.dart';
import '../utils/app_constants.dart';

class WishlistController extends GetxController{
  final WishlistRepo wishlistRepo;
  WishlistController({required this.wishlistRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _wishlistList=[];
  List<dynamic> get wishlistList => _wishlistList;

  Future<ResponseModel> tambahWishlist(int? user_id, int product_id) async {
    _isLoading = true;
    update();
    Response response = await wishlistRepo.tambahWishlist(user_id!, product_id);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      showCustomSnackBar(response.body["message"],
          title: "Berhasil");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getWishlistList() async{
    var controller = Get.find<UserController>();
    Response response = await wishlistRepo.getWishlistList(controller.users.id!);
    if(response.statusCode == 200){
      List<dynamic> responseBody = response.body;
      _wishlistList = [];
      for (dynamic item in responseBody) {
        WishlistModel wishlist = WishlistModel.fromJson(item);
        _wishlistList.add(wishlist);
      }
      _isLoading = true;
      update();
    }else{

    }
  }

  Future<ResponseModel> hapusWishlist(int wishlist_id) async {
    _isLoading = true;
    update();
    Response response = await wishlistRepo.hapusWishlist(wishlist_id);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      showCustomSnackBar("Wishlist berhasil dihapus",
          title: "Berhasil");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

}