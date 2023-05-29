import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/base/show_custom_message.dart';
import 'package:rumah_kreatif_toba/controllers/toko_controller.dart';
import 'package:rumah_kreatif_toba/data/repository/alamat_repo.dart';
import 'package:rumah_kreatif_toba/models/alamat_model.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/models/alamat_toko_model.dart';
import 'package:rumah_kreatif_toba/pages/alamat/daftaralamat.dart';
import 'package:rumah_kreatif_toba/pages/toko/AlamatToko/daftar_alamat_toko.dart';

import '../models/response_model.dart';

class AlamatController extends GetxController {
  RxString provAsalId = "0".obs;
  RxString province = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString city = "0".obs;
  RxString subAsalId = "0".obs;
  RxString sub= "0".obs;
  RxString cityTujuanId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString subTujuanId = "0".obs;
  RxInt berat = 0.obs;
  RxInt HargaPengiriman = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;

  final AlamatRepo alamatRepo;

  AlamatController({required this.alamatRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _daftarAlamatList = [];
  List<dynamic> get daftarAlamatList => _daftarAlamatList;

  List<dynamic> _daftarAlamatTokoList = [];
  List<dynamic> get daftarAlamatTokoList => _daftarAlamatTokoList;

  List<dynamic> _daftarAlamatUserList = [];
  List<dynamic> get daftarAlamatUserList => _daftarAlamatUserList;

  void showButton(){
    if(kurir != ""){
      hiddenButton.value = false;
    }else{
      hiddenButton.value = true;
    }
  }
  void setHargaPengiriman(int? harga) {
    HargaPengiriman.value = harga!;
    update();
  }

  Future<void> getAlamat() async {
    var controller = Get.find<UserController>().usersList[0];
    Response response = await alamatRepo.getAlamat(controller.id!);
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body["alamat"];
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
      String province_name,
      String city_name,
      String subdistrict_name,
      String user_street_address,
      String province_id,
      String city_id,
      String subdistrict_id,
      ) async {
    _isLoading = true;
    update();
    Response response = await alamatRepo.tambahAlamat(
      user_id!,
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

  Future<ResponseModel> hapusAlamat(int? user_address_id) async {
    Response response = await alamatRepo.hapusAlamat(user_address_id);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      showCustomSnackBar("Alamat berhasil dihapus", title: "Berhasil");
      getAlamat();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }

  Future<void> getAlamatToko() async {
    var controller = Get.find<TokoController>().profilTokoList[0];
    Response response = await alamatRepo.getAlamatToko(controller.merchant_id!);
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body["alamattoko"];
      _daftarAlamatTokoList = [];
      for (dynamic item in responseBody) {
        AlamatToko alamat = AlamatToko.fromJson(item);
        _daftarAlamatTokoList.add(alamat);
      }
      _isLoading = true;
      update();
    } else {}
  }

  Future<ResponseModel> tambahAlamatToko(
      int? merchant_id,
      String province_name,
      String city_name,
      String subdistrict_name,
      String user_street_address,
      String province_id,
      String city_id,
      String subdistrict_id,
      ) async {
    _isLoading = true;
    update();
    Response response = await alamatRepo.tambahAlamatToko(
      merchant_id!,
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
      showCustomSnackBar("Berhasil menambah alamat toko", title: "Berhasil");
      Get.to(
              () => DaftarAlamatTokoPage()
      );
      getAlamatToko();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> hapusAlamatToko(int? merchant_address_id) async {
    Response response = await alamatRepo.hapusAlamatToko(merchant_address_id);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      showCustomSnackBar("Alamat toko berhasil dihapus", title: "Berhasil");
      getAlamatToko();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }

  Future<void> getAlamatUser() async {
    var controller = Get.find<AlamatController>().daftarAlamatList[0];
    Response response = await alamatRepo.getAlamatUser(controller.user_address_id!);
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body["alamat"];
      _daftarAlamatUserList = [];
      for (dynamic item in responseBody) {
        Alamat alamat = Alamat.fromJson(item);
        _daftarAlamatUserList.add(alamat);
      }
      _isLoading = true;
      update();
    } else {}
  }
}
