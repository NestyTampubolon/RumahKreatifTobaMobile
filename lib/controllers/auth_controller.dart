import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/data/repository/auth_repo.dart';
import 'package:rumah_kreatif_toba/models/response_model.dart';

import '../models/users_models.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({required this.authRepo,});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registrasi(Users users) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registrasi(users);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String username, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(username, password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      if (response.body["token"] != null) {
        authRepo.saveUserToken(response.body["token"]);
        print(response.body["token"].toString());
      }
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String no_hp, String password)  {
    authRepo.saveUserNumberAndPassword(no_hp, password);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}

