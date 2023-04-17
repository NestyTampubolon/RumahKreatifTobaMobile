class Subdistrict {
  String? subdistrictId;
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;
  String? subdistrictName;

  Subdistrict({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
    this.subdistrictId,
    this.subdistrictName,
  });

  Subdistrict.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
    subdistrictId = json['subdistrict_id'];
    subdistrictName = json['subdistrict_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['province_id'] = provinceId;
    data['province'] = province;
    data['type'] = type;
    data['city_name'] = cityName;
    data['postal_code'] = postalCode;
    data['subdistrict_id'] = subdistrictId;
    data['subdistrict_name'] = subdistrictName;
    return data;
  }

  static List<Subdistrict> fromJsonList(List list) {
    if (list.length == 0) return List<Subdistrict>.empty();
    return list.map((item) => Subdistrict.fromJson(item)).toList();
  }

  @override
  String toString() => subdistrictName!;
}
