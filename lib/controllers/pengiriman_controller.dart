import 'package:get/get.dart';

import '../base/show_custom_message.dart';
import '../data/repository/pengiriman_repo.dart';
import '../models/response_model.dart';

class PengirimanController extends GetxController{
  final PengirimanRepo pengirimanRepo;
  PengirimanController({required this.pengirimanRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> beliProduk(int? user_id, List cart_id, List merchant_id, List metode_pembelian, List harga_pembelian, String potongan_pembelian,  String alamat_purchase, String courier_code, String service) async {
    _isLoading = true;
    update();
    Response response = await pengirimanRepo.beliProduk(user_id!, cart_id, merchant_id, metode_pembelian, harga_pembelian, potongan_pembelian, alamat_purchase, courier_code, service);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      showCustomSnackBar("Produk berhasil dibeli",
          title: "Berhasil");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
      showCustomSnackBar(response.statusText!,
          title: "Berhasil");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

}