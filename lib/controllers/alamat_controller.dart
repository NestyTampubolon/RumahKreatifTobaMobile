import 'dart:convert';
import 'dart:ffi';
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
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../base/snackbar_message.dart';
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
  var subAsal = 0.obs;
  RxString selected = "".obs;
  RxInt alamatID = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;
  var namakurir = "".obs;

  final AlamatRepo alamatRepo;

  AlamatController({required this.alamatRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RxList<dynamic> _daftarAlamatList = <dynamic>[].obs;
  List<dynamic> get daftarAlamatList => _daftarAlamatList.value;

  RxList<dynamic> _daftarAlamatMerchantList = <dynamic>[].obs;
  List<dynamic> get daftarAlamatMerchantList => _daftarAlamatMerchantList.value;

  RxList<dynamic> _daftarAlamatTokoList = <dynamic>[].obs;
  List<dynamic> get daftarAlamatTokoList => _daftarAlamatTokoList.value;

  RxList<Alamat> _daftarAlamatUserList = <Alamat>[].obs;
  List<dynamic> get getDaftarAlamatUserList => _daftarAlamatUserList.value;

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

  void setAsal(int? asal) {
    subAsal.value = asal!;
    update();
  }

  void setTypeAlamat(String? getalamat) {
    selected.value = getalamat!;
    update();
  }

  void setId(int? idAlamat){
    alamatID.value = idAlamat!;
    update();
  }

  void setAlamat(){

  }

  Future<void> getAlamat() async {
    var controller = Get.find<UserController>().usersList[0];
    Response response = await alamatRepo.getAlamat(controller.id!);;
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body["alamat"];
      _daftarAlamatList.value = [];
      for (dynamic item in responseBody) {
        Alamat alamat = Alamat.fromJson(item);
        print(alamat.city_name);
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
      AwesomeSnackbarButton("Berhasil","Berhasil menambah alamat",ContentType.success);
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
      AwesomeSnackbarButton("Berhasil","Alamat berhasil dihapus",ContentType.success);
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
      _daftarAlamatTokoList.value = [];
      for (dynamic item in responseBody) {
        AlamatToko alamat = AlamatToko.fromJson(item);
        _daftarAlamatTokoList.add(alamat);
      }
      print("ALAMAT " + _daftarAlamatTokoList.length.toString());

      _isLoading = true;
      update();
    } else {}
  }

  Future<void> getAlamatMerchant(int? merchant_id) async {
    Response response = await alamatRepo.getAlamatToko(merchant_id!);
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body["alamattoko"];
      _daftarAlamatTokoList.value = [];
      for (dynamic item in responseBody) {
        AlamatToko alamat = AlamatToko.fromJson(item);
        _daftarAlamatTokoList.add(alamat);
        cityTujuanId.value = alamat.city_id.toString()!;
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
      AwesomeSnackbarButton("Berhasil","Berhasil menambah alamat toko",ContentType.success);
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

  Future <ResponseModel> hapusAlamatToko(int? merchant_address_id) async {
    Response response = await alamatRepo.hapusAlamatToko(merchant_address_id);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      AwesomeSnackbarButton("Berhasil","Alamat toko berhasil dihapus",ContentType.success);
      getAlamatToko();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }

  Future<void> getAlamatUser() async {
    var alamat = daftarAlamatList[0];
    Response response = await alamatRepo.getAlamatUser(alamat.user_address_id);
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body["alamat"];
      _daftarAlamatUserList.value = [];
      for (dynamic item in responseBody) {
        Alamat alamat = Alamat.fromJson(item);
        _daftarAlamatUserList.add(alamat);
      }
      _isLoading = true;
      update();
    } else {}
  }
}
