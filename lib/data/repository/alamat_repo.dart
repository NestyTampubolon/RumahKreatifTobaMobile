import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';
import 'package:get/get.dart';

class AlamatRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AlamatRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getAlamat(int user_id) async {
    return await apiClient
        .postData(AppConstants.DAFTAR_ALAMAT, {"user_id": user_id});
  }

  Future<Response> tambahAlamat(
    int user_id,
    String province_id,
    String province_name,
    String city_id,
    String city_name,
    String subdistrict_id,
    String subdistrict_name,
    String user_street_address,
  ) async {
    return await apiClient.postData(AppConstants.TAMBAH_ALAMAT, {
      "user_id": user_id,
      "province_id": province_id,
      "province_name": province_name,
      "city_id": city_id,
      "city_name": city_name,
      "subdistrict_id": subdistrict_id,
      "subdistrict_name": subdistrict_name,
      "user_street_address": user_street_address,
    });
  }

  Future<Response> hapusAlamat(int user_address_id) async {
    return await apiClient.postData(AppConstants.HAPUS_ALAMAT_URL, {"user_address_id": user_address_id});
  }

  Future<Response> getAlamatToko(int merchant_id) async {
    return await apiClient
        .postData(AppConstants.DAFTAR_ALAMAT_TOKO_URL, {"merchant_id": merchant_id});
  }

}
