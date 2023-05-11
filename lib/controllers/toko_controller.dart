import 'dart:convert';

import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/models/response_model.dart';
import 'package:rumah_kreatif_toba/models/toko_models.dart';
import 'package:rumah_kreatif_toba/pages/toko/daftarberhasil.dart';
import 'package:rumah_kreatif_toba/pages/toko/hometoko/hometoko_page.dart';
import 'package:rumah_kreatif_toba/pages/toko/namatoko.dart';
import 'package:rumah_kreatif_toba/pages/toko/passwordtoko.dart';
import 'dart:io';
import '../base/show_custom_message.dart';
import '../data/repository/toko_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../pages/toko/hometoko/hometoko.dart';
import '../pages/toko/infotokoktp.dart';
import '../pages/toko/menungguverifikasi.dart';
import '../pages/toko/menungguverifikasitoko.dart';
import '../routes/route_helper.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';

class TokoController extends GetxController {
  final TokoRepo tokoRepo;
  TokoController({
    required this.tokoRepo,
  });
  List<dynamic> _tokoList = [];
  List<dynamic> get tokoList => _tokoList;

  List<dynamic> _profilTokoList = [];
  List<dynamic> get profilTokoList => _profilTokoList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _jumlahpesanan = 0;
  int _jumlahpesanantelahbayar = 0;
  int _jumlahpesananbelumbayar = 0;




  @override
  void initState() {
    pickImage();
    pickImageSelfieKTP();
  }

  PickedFile? _pickedFileKTP;
  PickedFile? get pickedFileKTP => _pickedFileKTP;

  PickedFile? _pickedFileSelfieKTP;
  PickedFile? get pickedFileSelfieKTP => _pickedFileSelfieKTP;

  String? _imagePath;
  String? get imagePath => _imagePath;

  final _picker = ImagePicker();
  Future<void> pickImage() async {
    _pickedFileKTP = await _picker.getImage(source: ImageSource.gallery);
    update();
  }

  final _pickerSelfieKTP = ImagePicker();
  Future<void> pickImageSelfieKTP() async {
    _pickedFileSelfieKTP =
        await _pickerSelfieKTP.getImage(source: ImageSource.gallery);
    update();
  }

  Future<bool> verifikasiToko(int? user_id) async {
    _isLoading = true;
    update();
    bool success = false;

    // Send the request
    http.StreamedResponse? response = (await uploadVerifikasiToko(
            user_id, _pickedFileKTP, _pickedFileSelfieKTP))
        as http.StreamedResponse?;
    if (response?.statusCode == 200) {
      success = true;
      dynamic decodedData = jsonDecode(await response!.stream.bytesToString());

      if (decodedData is Map) {
        Map map = decodedData;
        // Your code here
        String message = map["message"] ?? "";
        print(message);
        _imagePath = message;
      } else {
        // Handle error
        print('Error: Response was not a map');
      }
    } else {
      print(response);
    }

    update();
    return success;
  }

  Future<List<http.StreamedResponse>> uploadVerifikasiToko(
      int? user_id, PickedFile? KTP, PickedFile? SelfieKTP) async {
    List<http.StreamedResponse> responses = [];

    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse(AppConstants.BASE_URL + AppConstants.VERIFIKASI_TOKO_URL));
    if (GetPlatform.isMobile && KTP != null && SelfieKTP != null) {
      File _fileKTP = File(KTP.path);
      request.files.add(http.MultipartFile(
          'foto_ktp', _fileKTP.readAsBytes().asStream(), _fileKTP.lengthSync(),
          filename: _fileKTP.path.split('/').last));

      File _fileSelfieKTP = File(SelfieKTP.path);
      request.files.add(http.MultipartFile('ktp_dan_selfie',
          _fileSelfieKTP.readAsBytes().asStream(), _fileSelfieKTP.lengthSync(),
          filename: _fileSelfieKTP.path.split('/').last));
    }
    request.fields['user_id'] = user_id.toString();
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Get.toNamed(RouteHelper.getInitial());
      print("Uploaded!");
    }
    responses.add(response);
    return responses;
  }

  Future<void> cekVerifikasi() async {
    var controller = Get.find<UserController>().usersList[0];
    Response response = await tokoRepo.cekVerifikasi(controller.id!);
    if (response.statusCode == 200) {
      if (response.body == 0) {
        Get.to(DaftarBerhasil());
      } else if (response.body == 1) {
        Get.to(NamaToko());
      } else if (response.body == 2) {
        Get.to(PasswordTokoPage());
      } else if (response.body == 3) {
        Get.to(MenungguVerifikasiToko());
      } else if (response.body == 4) {
        Get.to(MenungguVerifikasi());
      } else if (response.body == 5) {
        Get.to(TokoKTP());
      }
      _isLoading = true;
      update();
    } else {}
  }

  PickedFile? _pickedFileFotoMerchant;
  PickedFile? get pickedFileFotoMerchant => _pickedFileFotoMerchant;

  String? _imagePathFotoMerchant;
  String? get imagePathFotoMerchant => _imagePathFotoMerchant;

  final _pickerFotoMerchant = ImagePicker();
  Future<void> pickImageFotoMerchant() async {
    _pickedFileFotoMerchant =
        await _pickerFotoMerchant.getImage(source: ImageSource.gallery);
    update();
  }

  Future<bool> tambahToko(int? user_id, String nama_merchant,
      String deskripsi_toko, String kontak_toko) async {
    _isLoading = true;
    update();
    bool success = false;

    // Send the request
    http.StreamedResponse? response = (await uploadTambahToko(
        user_id,
        nama_merchant,
        deskripsi_toko,
        kontak_toko,
        _pickedFileFotoMerchant)) as http.StreamedResponse?;
    if (response?.statusCode == 200) {
      success = true;
      dynamic decodedData = jsonDecode(await response!.stream.bytesToString());

      if (decodedData is Map) {
        Map map = decodedData;
        // Your code here
        String message = map["message"] ?? "";
        print(message);
        _imagePath = message;
      } else {
        // Handle error
        print('Error: Response was not a map');
      }
    } else {
      print(response);
    }
    update();
    return success;
  }

  Future<List<http.StreamedResponse>> uploadTambahToko(
      int? user_id,
      String nama_merchant,
      String deskripsi_toko,
      String kontak_toko,
      PickedFile? fotoMerchant) async {
    List<http.StreamedResponse> responses = [];

    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse(AppConstants.BASE_URL + AppConstants.TAMBAH_TOKO_URL));
    if (GetPlatform.isMobile && fotoMerchant != null) {
      File _fileFotoMerchant = File(fotoMerchant.path);
      request.files.add(http.MultipartFile(
          'foto_merchant',
          _fileFotoMerchant.readAsBytes().asStream(),
          _fileFotoMerchant.lengthSync(),
          filename: _fileFotoMerchant.path.split('/').last));
    }
    request.fields['user_id'] = user_id.toString();
    request.fields['nama_merchant'] = nama_merchant.toString();
    request.fields['deskripsi_toko'] = deskripsi_toko.toString();
    request.fields['kontak_toko'] = kontak_toko.toString();
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Get.offNamed(RouteHelper.getMenungguVerifikasiTokoPage());
      showCustomSnackBar(
          "Pendaftaran toko berhasil, tunggu toko Anda diverifikasi",
          title: "Berhasil");
      print("Uploaded!");
    }
    responses.add(response);
    return responses;
  }

  Future<ResponseModel> masukToko(int? user_id, String password) async {
    _isLoading = true;
    update();
    Response response = await tokoRepo.masukToko(user_id!, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body == 200) {
        showCustomSnackBar("Berhasil Masuk", title: "Berhasil");
         profilToko();
        Get.to(HomeTokoPage(initialIndex: 0));
      }
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> profilToko() async {
    _isLoading = true;
    update();
    var controller = Get.find<UserController>().usersList[0];
    Response response = await tokoRepo.profilToko(controller.id!);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body;
      _profilTokoList = [];
      for (dynamic item in responseBody) {
        Toko toko = Toko.fromJson(item);
        _profilTokoList.add(toko);
      }
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> homeToko() async {
    _isLoading = true;
    update();
    var controller = Get.find<UserController>().usersList[0];
    Response response = await tokoRepo.profilToko(controller.id!);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      try {
        final responseBody = response.body as List<dynamic>;
        final firstItem = responseBody.first as Map<String, dynamic>;
        final responseBodyjumlahpesanan = firstItem["jumlah_pesanan_sedang_berlangsung"] as String;
        final responseBodyjumlahpesananbelumbayar = firstItem["jumlah_pesanan_berhasil_belum_dibayar"] as String;
        final responseBodyjumlahpesanantelahbayar = firstItem["jumlah_pesanan_berhasil_telah_dibayar"] as String;

        print(responseBodyjumlahpesanan);
        final jumlah_pesanan_sedang_berlangsung = int.tryParse(responseBodyjumlahpesanan) ?? 0;
        final jumlah_pesanan_belum_bayar = int.tryParse(responseBodyjumlahpesananbelumbayar) ?? 0;
        final jumlah_pesanan_telah_bayar = int.tryParse(responseBodyjumlahpesanantelahbayar) ?? 0;

        _jumlahpesanan = jumlah_pesanan_sedang_berlangsung;
        _jumlahpesananbelumbayar = jumlah_pesanan_belum_bayar;
        _jumlahpesanantelahbayar = jumlah_pesanan_telah_bayar;
        update();
      } catch (e) {
        print("Error parsing response: $e");
      }
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

}
