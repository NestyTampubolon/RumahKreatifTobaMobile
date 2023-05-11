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
}
