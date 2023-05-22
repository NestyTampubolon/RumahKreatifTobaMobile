class PurchaseModel {
  int? purchaseId;
  String? kodePembelian;
  int? userId;
  int? checkoutId;
  String? alamatPurchase;
  int? hargaPembelian;
  int? potonganPembelian;
  String? statusPembelian;
  String? noResi;
  String? courierCode;
  String? service;
  int? ongkir;
  int? isCancelled;
  String? createdAt;
  String? updatedAt;
  int? productPurchaseId;
  int? productId;
  int? beratPembelianProduk;
  int? jumlahPembelianProduk;
  int? hargaPembelianProduk;
  int? proofOfPaymentId;
  String? proofOfPaymentImage;
  int? merchantId;
  int? categoryId;
  String? productName;
  String? productDescription;
  int? price;
  int? heavy;
  int? isDeleted;
  String? name;

  PurchaseModel(
      {this.purchaseId,
        this.kodePembelian,
        this.userId,
        this.checkoutId,
        this.alamatPurchase,
        this.hargaPembelian,
        this.potonganPembelian,
        this.statusPembelian,
        this.noResi,
        this.courierCode,
        this.service,
        this.ongkir,
        this.isCancelled,
        this.createdAt,
        this.updatedAt,
        this.productPurchaseId,
        this.productId,
        this.beratPembelianProduk,
        this.jumlahPembelianProduk,
        this.hargaPembelianProduk,
        this.proofOfPaymentId,
        this.proofOfPaymentImage,
        this.merchantId,
        this.categoryId,
        this.productName,
        this.productDescription,
        this.price,
        this.heavy,
        this.isDeleted,
        this.name});

  PurchaseModel.fromJson(Map<String, dynamic> json) {
    purchaseId = json['purchase_id'];
    kodePembelian = json['kode_pembelian'];
    userId = json['user_id'];
    checkoutId = json['checkout_id'];
    alamatPurchase = json['alamat_purchase'];
    hargaPembelian = json['harga_pembelian'];
    potonganPembelian = json['potongan_pembelian'];
    statusPembelian = json['status_pembelian'];
    noResi = json['no_resi'];
    courierCode = json['courier_code'];
    service = json['service'];
    ongkir = json['ongkir'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productPurchaseId = json['product_purchase_id'];
    productId = json['product_id'];
    beratPembelianProduk = json['berat_pembelian_produk'];
    jumlahPembelianProduk = json['jumlah_pembelian_produk'];
    hargaPembelianProduk = json['harga_pembelian_produk'];
    proofOfPaymentId = json['proof_of_payment_id'];
    proofOfPaymentImage = json['proof_of_payment_image'];
    merchantId = json['merchant_id'];
    categoryId = json['category_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    price = json['price'];
    heavy = json['heavy'];
    isDeleted = json['is_deleted'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchase_id'] = this.purchaseId;
    data['kode_pembelian'] = this.kodePembelian;
    data['user_id'] = this.userId;
    data['checkout_id'] = this.checkoutId;
    data['alamat_purchase'] = this.alamatPurchase;
    data['harga_pembelian'] = this.hargaPembelian;
    data['potongan_pembelian'] = this.potonganPembelian;
    data['status_pembelian'] = this.statusPembelian;
    data['no_resi'] = this.noResi;
    data['courier_code'] = this.courierCode;
    data['service'] = this.service;
    data['ongkir'] = this.ongkir;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_purchase_id'] = this.productPurchaseId;
    data['product_id'] = this.productId;
    data['berat_pembelian_produk'] = this.beratPembelianProduk;
    data['jumlah_pembelian_produk'] = this.jumlahPembelianProduk;
    data['harga_pembelian_produk'] = this.hargaPembelianProduk;
    data['proof_of_payment_id'] = this.proofOfPaymentId;
    data['proof_of_payment_image'] = this.proofOfPaymentImage;
    data['merchant_id'] = this.merchantId;
    data['category_id'] = this.categoryId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['price'] = this.price;
    data['heavy'] = this.heavy;
    data['is_deleted'] = this.isDeleted;
    data['name'] = this.name;
    return data;
  }
}