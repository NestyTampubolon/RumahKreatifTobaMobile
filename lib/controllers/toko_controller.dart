import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/models/response_model.dart';

import '../data/repository/toko_repo.dart';
import '../models/toko_models.dart';
import '../models/users_models.dart';

class TokoController extends GetxController implements GetxService {
  final TokoRepo tokoRepo;
  TokoController({
    required this.tokoRepo,
  });
  List<dynamic> _tokoList = [];
  List<dynamic> get tokoList => _tokoList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

}
