import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/base/show_custom_message.dart';
import 'package:rumah_kreatif_toba/data/repository/alamat_repo.dart';
import 'package:rumah_kreatif_toba/models/alamat_model.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/pages/alamat/daftaralamat.dart';

import '../models/response_model.dart';

class AlamatController extends GetxController {
  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;

  final AlamatRepo alamatRepo;
  AlamatController({required this.alamatRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _daftarAlamatList = [];
  List<dynamic> get daftarAlamatList => _daftarAlamatList;

  Future<void> getAlamat() async {
    var controller = Get.find<UserController>().usersList[0];
    Response response = await alamatRepo.getAlamat(controller.id!);
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body["users_address"];
      _daftarAlamatList = [];
      for (dynamic item in responseBody) {
        Alamat alamat = Alamat.fromJson(item);
        _daftarAlamatList.add(alamat);
      }
      _isLoading = true;
      update();
    } else {}
  }

  Future<ResponseModel> tambahAlamat(
      int? user_id,
      int user_address_id,
      int province_id,
      String province_name,
      int city_id,
      String city_name,
      int subdistrict_id,
      String subdistrict_name,
      String user_street_address) async {
    _isLoading = true;
    update();
    Response response = await alamatRepo.tambahAlamat(
      user_id!,
      user_address_id,
      province_id,
      province_name,
      city_id,
      city_name,
      subdistrict_id,
      subdistrict_name,
      user_street_address,
    );
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      showCustomSnackBar("Berhasil menambah alamat", title: "Berhasil");
      Get.to(
        () => DaftarAlamatPage(),
      );
      getAlamat();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
