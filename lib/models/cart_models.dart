import 'package:rumah_kreatif_toba/models/produk_models.dart';

class CartModel {
  int? cartId;
  int? userId;
  int? productId;
  int? jumlahMasukKeranjang;
  Null? createdAt;
  Null? updatedAt;
  int? merchantId;
  int? categoryId;
  String? productName;
  String? productDescription;
  int? price;
  int? heavy;
  int? isDeleted;
  Produk? produk;

  CartModel(
      {this.cartId,
        this.userId,
        this.productId,
        this.jumlahMasukKeranjang,
        this.createdAt,
        this.updatedAt,
        this.merchantId,
        this.categoryId,
        this.productName,
        this.productDescription,
        this.price,
        this.heavy,
        this.isDeleted,
        this.produk
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    jumlahMasukKeranjang = json['jumlah_masuk_keranjang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merchantId = json['merchant_id'];
    categoryId = json['category_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    price = json['price'];
    heavy = json['heavy'];
    isDeleted = json['is_deleted'];
    produk = Produk.fromJson(json['produk']);
  }
}