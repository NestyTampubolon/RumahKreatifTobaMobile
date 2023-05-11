import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/data/repository/alamat_repo.dart';
import 'package:rumah_kreatif_toba/models/alamat_model.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';

class AlamatController extends GetxController {
  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;

  final AlamatRepo alamatRepo;
  AlamatController({required this.alamatRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> _daftarAlamatList=[];
  List<dynamic> get daftarAlamatList => _daftarAlamatList;

  Future<void> getAlamat() async{
    var controller = Get.find<UserController>().usersList[0];
    Response response = await alamatRepo.getAlamat(controller.id!);
    if(response.statusCode == 200){
      List<dynamic> responseBody = response.body["users_address"];
      _daftarAlamatList = [];
      for (dynamic item in responseBody) {
        Alamat alamat = Alamat.fromJson(item);
        _daftarAlamatList.add(alamat);
      }
      _isLoading = true;
      update();
    }else{

    }
  }
}
