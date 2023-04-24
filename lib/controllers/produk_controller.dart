import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'dart:io';
import '../base/show_custom_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../data/repository/produk_repo.dart';
import '../pages/toko/hometoko/hometoko.dart';
import '../pages/toko/hometoko/hometoko_page.dart';
import '../routes/route_helper.dart';

import '../utils/app_constants.dart';


class ProdukController extends GetxController {
  final PopularProdukRepo produkRepo;
  ProdukController({required this.produkRepo});


  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  PickedFile? _pickedFileGambarProduk1;
  PickedFile? get pickedFileGambarProduk1 => _pickedFileGambarProduk1;

  String? _imagePathGambarProduk1;
  String? get imagePathGambarProduk1 => _imagePathGambarProduk1;

  final _pickerGambarProduk1 = ImagePicker();
  Future<void> pickImageGambarProduk1() async {
    _pickedFileGambarProduk1 =
    await _pickerGambarProduk1.getImage(source: ImageSource.gallery);
    update();
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
    _isLoaded = true;
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
        _imagePathFotoMerchant = message;
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

  PickedFile? _pickedFileGambarProduk2;
  PickedFile? get pickedFileGambarProduk2 => _pickedFileGambarProduk2;

  String? _imagePathGambarProduk2;
  String? get imagePathGambarProduk2 => _imagePathGambarProduk2;

  final _pickerGambarProduk2 = ImagePicker();
  Future<void> pickImageGambarProduk2() async {
    _pickedFileGambarProduk2  =
    await _pickerGambarProduk2 .getImage(source: ImageSource.gallery);
    update();
  }


  PickedFile? _pickedFileGambarProduk3;
  PickedFile? get pickedFileGambarProduk3 => _pickedFileGambarProduk3;

  String? _imagePathGambarProduk3;
  String? get imagePathGambarProduk3 => _imagePathGambarProduk3;

  final _pickerGambarProduk3  = ImagePicker();
  Future<void> pickImageGambarProduk3() async {
    _pickedFileGambarProduk3 =
    await _pickerGambarProduk3.getImage(source: ImageSource.gallery);
    update();
  }

  Future<bool> tambahProduk(int? user_id, String product_name, String product_description, int price, int heavy, String kategori, int stok) async {
    _isLoaded = true;
    update();
    bool success = false;

    // Send the request
    List<http.StreamedResponse>? response = await uploadTambahProduk(
        user_id,
        product_name,
        product_description,
        price,
        heavy,
        kategori,
        stok,
        _pickedFileGambarProduk1,
        _pickedFileGambarProduk2,
        _pickedFileGambarProduk3
    );

    dynamic decodedData;

    for (StreamedResponse resp in response) {
      if (resp.statusCode == 200) {
        success = true;
        decodedData = jsonDecode(await resp.stream.bytesToString());

        if (decodedData is Map) {
          Map map = decodedData;
          // Your code here
          String message = map["message"] ?? "";
          print(message);
          _imagePathGambarProduk1 = message;
        } else {
          // Handle error
          print('Error: Response was not a map');
        }
        break; // Exit the loop after the first successful response
      }
    }

    if (!success) {
      print('Error: Response status code was not 200');
    }

    update();
    return success;
  }

  Future<List<http.StreamedResponse>> uploadTambahProduk(
      int? user_id, String product_name, String product_description, int price, int heavy, String kategori, int stok,
      PickedFile? GambarProduk1, PickedFile? GambarProduk2, PickedFile? GambarProduk3,) async {
    List<http.StreamedResponse> responses = [];

    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse(AppConstants.BASE_URL + AppConstants.TAMBAH_PRODUK_URL));
    if (GetPlatform.isMobile && GambarProduk1 != null && GambarProduk2 != null && GambarProduk3 != null ) {
      File _fileGambarProduk1 = File(GambarProduk1.path);
      request.files.add(http.MultipartFile(
          'product_image[0]',
          _fileGambarProduk1.readAsBytes().asStream(),
          _fileGambarProduk1.lengthSync(),
          filename: _fileGambarProduk1.path.split('/').last));

      File _fileGambarProduk2 = File(GambarProduk2.path);
      request.files.add(http.MultipartFile(
          'product_image[1]',
          _fileGambarProduk2.readAsBytes().asStream(),
          _fileGambarProduk2.lengthSync(),
          filename: _fileGambarProduk2.path.split('/').last));

      File _fileGambarProduk3 = File(GambarProduk3.path);
      request.files.add(http.MultipartFile(
          'product_image[2]',
          _fileGambarProduk3.readAsBytes().asStream(),
          _fileGambarProduk3.lengthSync(),
          filename: _fileGambarProduk3.path.split('/').last));
    }
    request.fields['user_id'] = user_id.toString();
    request.fields['product_name'] = product_name.toString();
    request.fields['product_description'] = product_description.toString();
    request.fields['price'] = price.toString();
    request.fields['heavy'] = heavy.toString();
    request.fields['kategori'] = kategori.toString();
    request.fields['stok'] = stok.toString();

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      HomeTokoPage(initialIndex: 1);
      showCustomSnackBar(
          "Tambah produk berhasil",
          title: "Berhasil");
      print("Uploaded!");
    }
    responses.add(response);
    return responses;
  }


}