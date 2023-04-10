import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/data/api/api_client.dart';
import 'package:rumah_kreatif_toba/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    //apiClient.getData(uri)
    return await apiClient.getData(AppConstants.USER_URL);
  }
}
