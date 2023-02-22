import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class PopularProdukRepo extends GetxService{
  final ApiClient apiClient;
  PopularProdukRepo({required this.apiClient});

  Future<Response> getPopularProdukList()  async{
    //return await apiClient.getData("/api/v1/products/popular");

    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }

}