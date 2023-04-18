import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/models/response_model.dart';

import '../data/repository/Toko_repo.dart';
import '../data/repository/toko_repo.dart';
import '../models/toko_models.dart';
import '../models/users_models.dart';

class TokoController extends GetxController implements GetxService {
  final TokoRepo tokoRepo;
  TokoController({
    required this.tokoRepo,
  });
  List<dynamic> _tokoList = [];
  List<dynamic> get tokoList => _tokoList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registrasi(Toko toko) async {
    _isLoading = true;
    update();
    Response response = await tokoRepo.registerToko(toko);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // void saveUserNumberAndPassword(String no_hp, String password) {
  //   tokoRepo.saveUserNumberAndPassword(no_hp, password);
  // }

  // bool userLoggedIn() {
  //   return tokoRepo.userLoggedIn();
  // }

  // bool clearSharedData() {
  //   return tokoRepo.clearSharedData();
  // }
}
