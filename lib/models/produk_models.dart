class Produk {
  int? _productId;
  int? _merchantId;
  int? _categoryId;
  String? _productName;
  String? _productDescription;
  int? _price;
  int? _heavy;
  int? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  String? get productName => _productName;
  int? get price => _price;
  Produk(
      { required productId,
        required merchantId,
        required categoryId,
        required productName,
        required productDescription,
        required price,
        required heavy,
        required isDeleted,
        required createdAt,
        required updatedAt}){
    this._productId = productId;
    this._merchantId = merchantId;
    this._categoryId = categoryId;
    this._productName = productName;
    this._productDescription = productDescription;
    this._price = price;
    this._heavy = heavy;
    this._isDeleted = isDeleted;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  Produk.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _merchantId = json['merchant_id'];
    _categoryId = json['category_id'];
    _productName = json['product_name'];
    _productDescription = json['product_description'];
    _price = json['price'];
    _heavy = json['heavy'];
    _isDeleted = json['is_deleted'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
}