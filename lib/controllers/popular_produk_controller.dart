import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/models/produk_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/repository/popular_produk_repo.dart';


class PopularProdukController extends GetxController{
  final PopularProdukRepo popularProdukRepo;
  PopularProdukController({required this.popularProdukRepo});
  List<dynamic> _popularProdukList=[];
  List<dynamic> get popularProdukList => _popularProdukList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getPopularProdukList() async{
    Response response = await popularProdukRepo.getPopularProdukList();
    if(response.statusCode == 200){
      List<dynamic> responseBody = response.body;
      _popularProdukList = [];
      for (dynamic item in responseBody) {
        Produk produk = Produk.fromJson(item);
        _popularProdukList.add(produk);
      }
      _isLoaded = true;
      update();
    }else{

    }
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load data');
    }
  }
}