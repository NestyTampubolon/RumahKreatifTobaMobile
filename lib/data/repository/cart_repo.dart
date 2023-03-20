import 'package:rumah_kreatif_toba/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
    final SharedPreferences sharedPreferences;
    CartRepo({required this.sharedPreferences});

    List<String> cart = [];

    // void removeCart(){
    //     cart = [];
    //     sharedPreferences.remove(AppConstants.CART_LIST);
    // }
    //
    // void clearCartHistory(){
    //     removeCart();
    //     sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // }
}