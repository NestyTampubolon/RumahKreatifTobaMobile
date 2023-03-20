import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/data/api/api_client.dart';
import 'package:rumah_kreatif_toba/models/users_models.dart';
import 'package:rumah_kreatif_toba/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registrasi(Users users) async {
    return await apiClient.postData(AppConstants.REGISTRASI_URL, users.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<Response> login(String username, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URL, {"username": username, "password": password});
  }

  Future<String> getUserToken() async{
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  Future<bool> saveUserToken(String token) async {
    if (token == null) {
      return false;
    }
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String no_hp, String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, no_hp);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
