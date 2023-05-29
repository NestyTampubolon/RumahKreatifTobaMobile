import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/alamat_controller.dart';

import '../base/show_custom_message.dart';
import '../base/snackbar_message.dart';
import '../data/repository/pengiriman_repo.dart';
import '../models/response_model.dart';
import '../routes/route_helper.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'auth_controller.dart';

class PengirimanController extends GetxController{
  final PengirimanRepo pengirimanRepo;
  PengirimanController({required this.pengirimanRepo});

  // int _paymentIndex = 0;
  // int get paymentIndex => _paymentIndex;

  @override
  void initState() {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<AlamatController>().getAlamatUser();
    }
  }
  String _alamatType = "aa";
  String get alamatType => _alamatType;

  RxInt paymentIndex = RxInt(0);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _typePengiriman = "Pilih Pengiriman";
  String get typePengiriman => _typePengiriman;

  RxString checkedtypePengiriman = RxString("Pilih Pengiriman");


  Future<ResponseModel> beliProduk(int? user_id, List cart_id, int merchant_id, int metode_pembelian, int harga_pembelian, String potongan_pembelian,  String alamat_purchase, String courier_code, String service) async {
    _isLoading = true;
    update();
    Response response = await pengirimanRepo.beliProduk(user_id!, cart_id, merchant_id, metode_pembelian, harga_pembelian, potongan_pembelian, alamat_purchase, courier_code, service);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      AwesomeSnackbarButton("Berhasil","Produk berhasil dibeli",ContentType.success);

      Get.offNamed(RouteHelper.getMenungguPembayaranPage());
    }else{
      responseModel = ResponseModel(false, response.statusText!);
      AwesomeSnackbarButton("Gagal",response.statusText!,ContentType.failure);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> beliLangsung(int? user_id, int product_id, int metode_pembelian, int jumlah_masuk_keranjang, int harga_pembelian, String potongan_pembelian,  String alamat_purchase, String courier_code, String service) async {
    _isLoading = true;
    update();
    Response response = await pengirimanRepo.beliLangsung(user_id!, product_id,  metode_pembelian, jumlah_masuk_keranjang, harga_pembelian, potongan_pembelian, alamat_purchase, courier_code, service);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      AwesomeSnackbarButton("Berhasil","Produk berhasil dibeli",ContentType.success);
      Get.offNamed(RouteHelper.getMenungguPembayaranPage());
    }else{
      responseModel = ResponseModel(false, response.statusText!);

    }
    _isLoading = false;
    update();
    return responseModel;
  }


  void setPaymentIndex(int index){
    paymentIndex.value = index;
    update();
  }

  void setTypePengiriman(String title) {
    checkedtypePengiriman.value = title;
    update();
  }

  void setTypeAlamat(String type){
    _alamatType = type;
    update();
  }





}