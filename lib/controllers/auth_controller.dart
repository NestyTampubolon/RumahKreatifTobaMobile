import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/data/repository/auth_repo.dart';
import 'package:rumah_kreatif_toba/models/response_model.dart';
import '../base/show_custom_message.dart';
import '../base/snackbar_message.dart';
import '../models/users_models.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });
  List<dynamic> _userList = [];
  List<dynamic> get userList => _userList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  Future<ResponseModel> registrasi(Users users) async {
    update();
    Response response = await authRepo.registrasi(users);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String username, String password) async {
    Response response = await authRepo.login(username, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["token"] != null) {
        authRepo.saveUserToken(response.body["token"]);
        responseModel = ResponseModel(true, response.body["token"]);
      }else{
        AwesomeSnackbarButton("Gagal",response.body["message"],ContentType.failure);
      }
      } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String no_hp, String password) {
    authRepo.saveUserNumberAndPassword(no_hp, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
