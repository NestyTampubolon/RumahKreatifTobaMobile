import 'dart:convert';

import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/data/repository/auth_repo.dart';
import 'package:rumah_kreatif_toba/models/response_model.dart';

import '../data/repository/user_repo.dart';
import '../models/users_models.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({required this.userRepo,});

  bool _isLoading = false;
  late Users _users;
  bool get isLoading => _isLoading;
  Users get users => _users;

  Future<ResponseModel> getUser() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      _users = Users.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    }else{
      print("tidak berhasil mendapatkan data");
      responseModel = ResponseModel(false, response.statusText!);
    }
    print("berhasil mendapatkan data");
    _isLoading = false;
    update();
    return responseModel;
  }
}

