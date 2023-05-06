class Produk {
  int productId;
  int? merchantId;
  int? categoryId;
  String? productName;
  String? productDescription;
  int? price;
  int? heavy;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? namaKategori;
  int? userId;
  String? namaMerchant;
  String? deskripsiToko;
  String? kontakToko;
  String? fotoMerchant;
  int? isVerified;
  int? stock_id;
  int? stok;
  String? productImageName;

  Produk(
      {required this.productId,
      required this.merchantId,
      required this.categoryId,
      required this.productName,
      required this.productDescription,
      required this.price,
      required this.heavy,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt,
      required this.namaKategori,
      required this.userId,
      required this.namaMerchant,
      required this.deskripsiToko,
      required this.kontakToko,
      required this.fotoMerchant,
      required this.isVerified,
      required this.stock_id,
      required this.stok,
      required this.productImageName});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
        productId: json['product_id'],
        merchantId: json['merchant_id'],
        categoryId: json['category_id'],
        productName: json['product_name'],
        productDescription: json['product_description'],
        price: json['price'],
        heavy: json['heavy'],
        isDeleted: json['is_deleted'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        namaKategori: json['nama_kategori'],
        userId: json['user_id'],
        namaMerchant: json['nama_merchant'],
        deskripsiToko: json['deskripsi_toko'],
        kontakToko: json['kontak_toko'],
        fotoMerchant: json['foto_merchant'],
        isVerified: json['is_verified'],
        stock_id: json['stock_id'],
        stok: json['stok'],
        productImageName: json['product_image_name']);
  }
}
