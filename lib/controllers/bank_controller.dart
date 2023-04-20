import 'package:rumah_kreatif_toba/data/repository/bank_repo.dart';
import 'package:get/get.dart';
import '../base/show_custom_message.dart';
import '../models/response_model.dart';
import '../pages/toko/namatoko.dart';


class BankController extends GetxController{
  final BankRepo bankRepo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BankController({required this.bankRepo});


  Future<ResponseModel> tambahRekening(int? user_id, String nama_bank, String nomor_rekening, String atas_nama) async {
    _isLoading = true;
    update();
    Response response = await bankRepo.tambahRekening(user_id!, nama_bank, nomor_rekening, atas_nama);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      showCustomSnackBar("Berhasil menambah rekening",
          title: "Berhasil");
      Get.to(
            () => NamaToko(),
      );
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}