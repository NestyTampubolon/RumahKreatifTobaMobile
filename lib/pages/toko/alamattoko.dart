import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rumah_kreatif_toba/models/province.dart';
import 'package:rumah_kreatif_toba/pages/toko/passwordtoko.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_dropdown_field.dart';
import 'package:rumah_kreatif_toba/widgets/app_text_field.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:rumah_kreatif_toba/widgets/monserrat_text.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../home/home_page.dart';

class AlamatTokoPage extends StatefulWidget {
  const AlamatTokoPage({Key? key}) : super(key: key);

  @override
  State<AlamatTokoPage> createState() => _AlamatTokoPageState();
}

class _AlamatTokoPageState extends State<AlamatTokoPage> {
  var ProvinsiController = TextEditingController();
  var KabupatenController = TextEditingController();
  var KecamatanController = TextEditingController();
  var JalanController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.border),
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 250,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: BigText(
                            text: "Alamat Toko",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        DropdownSearch<Province>(
                          asyncItems: (String filter) async {
                            Uri url = Uri.parse(
                                "https://pro.rajaongkir.com/api/province");
                            try {
                              final response = await http.get(
                                url,
                                headers: {
                                  "key": "41df939eff72c9b050a81d89b4be72ba",
                                },
                              );

                              var data = json.decode(response.body)
                                  as Map<String, dynamic>;

                              var statusCode =
                                  data["rajaongkir"]["status"]["code"];

                              if (statusCode != 200) {
                                throw data["rajaongkir"]["status"]
                                    ["description"];
                              }

                              var allProvince =
                                  data["rajaongkir"]["result"] as List<dynamic>;

                              var models = Province.fromJsonList(allProvince);
                              return models;
                            } catch (err) {
                              print(err);
                              return List<Province>.empty();
                            }
                          },
                          onChanged: (value) => print(value!.province),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Provinsi",
                              hintText: "Provinsi anda",
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: SmallText(
                text: " * Pastikan data yang pilih benar ",
                size: 14,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => {
                Get.to(
                  () => PasswordTokoPage(),
                ),
              },
              child: Container(
                width: 306,
                height: 45,
                // alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.border,
                      width: 3,
                    ),
                    color: AppColors.border),
                child: Center(
                  child: BigText(
                    text: "Tambah",
                    fontWeight: FontWeight.bold,
                    size: Dimensions.font20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
