import 'dart:convert';

import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/models/response_model.dart';
import 'package:rumah_kreatif_toba/pages/toko/daftarberhasil.dart';
import 'dart:io';
import '../data/repository/toko_repo.dart';
import '../models/toko_models.dart';
import '../models/users_models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../pages/toko/menungguverifikasi.dart';
import '../routes/route_helper.dart';
import 'package:get/get.dart';

class TokoController extends GetxController {
  final TokoRepo tokoRepo;
  TokoController({
    required this.tokoRepo,
  });
  List<dynamic> _tokoList = [];
  List<dynamic> get tokoList => _tokoList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.43.97/tobazonerework/public/api/verifikasitoko'));
    if (GetPlatform.isMobile && KTP != null && SelfieKTP != null) {
      File _fileKTP = File(KTP.path);
      request.files.add(http.MultipartFile(
          'foto_ktp', _fileKTP.readAsBytes().asStream(), _fileKTP.lengthSync(),
          filename: _fileKTP.path.split('/').last));

      File _fileSelfieKTP = File(KTP.path);
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
    var controller = Get.find<UserController>();
    Response response = await tokoRepo.cekVerifikasi(controller.users.id!);
    if (response.statusCode == 200) {
      if (response.body == 0) {
        Get.to(DaftarBerhasil());
      } else if (response.body == 1) {
        Get.to(MenungguVerifikasi());
      } else if (response.body == 2) {
        Get.toNamed(RouteHelper.getTokoPage());
      }
      _isLoading = true;
      update();
    } else {}
  }

  // bool cekUser() {
  //   return _responseBodycekVerifikasi;
  // }
}
