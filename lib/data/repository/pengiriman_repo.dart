import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';
import 'package:get/get.dart';

class PengirimanRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  PengirimanRepo({  required this.apiClient,required this.sharedPreferences});

  Future<Response> beliProduk(int user_id, List cart_id, int merchant_id, int metode_pembelian, int harga_pembelian, String potongan_pembelian, String alamat_purchase, String courier_code, String service ) async {
    return await apiClient.postData(AppConstants.BELI_PRODUK, {"user_id": user_id, "cart_id" : cart_id, "merchant_id": merchant_id, "metode_pembelian": metode_pembelian,"harga_pembelian" : harga_pembelian, "potongan_pembelian" : potongan_pembelian, "alamat_purchase" : alamat_purchase, "courier_code" : courier_code, "service" : service  });
  }

}