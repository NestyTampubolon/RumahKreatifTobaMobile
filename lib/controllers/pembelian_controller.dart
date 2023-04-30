import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/data/repository/pembelian_repo.dart';
import '../base/show_custom_message.dart';
import '../models/purchase_models.dart';
import '../models/response_model.dart';

class PembelianController extends GetxController{
  final PembelianRepo pembelianRepo;
  PembelianController({required this.pembelianRepo});


  List<dynamic> _pembelianList = [];
  List<dynamic> get pembelianList => _pembelianList;

  List<dynamic> _detailPembelianList = [];
  List<dynamic> get detailPembelianList => _detailPembelianList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    getPembelianList(); // Call the function here
  }

  Future<void> getPembelianList() async{
    var controller = Get.find<UserController>().usersList[0];
    Response response = await pembelianRepo.daftarPembelian(controller.id!);
    if(response.statusCode == 200){
      List<dynamic> responseBody = response.body;
      _pembelianList = [];
      for (dynamic item in responseBody) {
        PurchaseModel purchase = PurchaseModel.fromJson(item);
        _pembelianList.add(purchase);
      }
      _isLoading = true;
      update();
    }else{

    }
  }

  Future<ResponseModel> detailPembelian(String kode_pembelian) async {
    Response response = await pembelianRepo.detailPembelian(kode_pembelian);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.body;
      _detailPembelianList.clear();
      for (dynamic item in responseBody) {
        PurchaseModel purchase = PurchaseModel.fromJson(item);
        _detailPembelianList.add(purchase);
      }
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


}