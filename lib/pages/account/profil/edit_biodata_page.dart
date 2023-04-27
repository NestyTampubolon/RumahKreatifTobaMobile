import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import '../../../base/show_custom_message.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_date_field.dart';
import '../../../widgets/app_dropdown_field.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/input_text_field.dart';

class EditBiodataPage extends StatefulWidget {
  const EditBiodataPage({Key? key}) : super(key: key);

  @override
  State<EditBiodataPage> createState() => _EditBiodataPageState();
}

class _EditBiodataPageState extends State<EditBiodataPage> {
  @override
  Widget build(BuildContext context) {

    var users = Get.find<UserController>().usersList[0];
    final NamaController = TextEditingController(text: users.name);
    final NomorHandphoneController = TextEditingController(text: users.noHp);
    final jenisKelaminController = TextEditingController(text:users.gender);
    var tanggalLahirController = TextEditingController(text : users.birthday);

    Future<void> _ubahProfil() async {
      String name = NamaController.text.trim();
      String noHp = NomorHandphoneController.text.trim();
      String gender = jenisKelaminController.text.trim();
      String birthday = tanggalLahirController.text.toString();

      if (name.isEmpty) {
        showCustomSnackBar("Nama masih kosong", title: "Nama");
      } else if (noHp.isEmpty) {
        showCustomSnackBar("Nomor handphone masih kosong", title: "Nomor Handphone");
      } else if (gender.isEmpty) {
        showCustomSnackBar("Jenis kelamin masih kosong", title: "Jenis Kelamin");
      } else if (birthday.isEmpty) {
        showCustomSnackBar("Tanggal lahir Password masih kosong",
            title: "Tanggal Lahir ");
      }else{
        var controller = Get.find<UserController>();
        var userController = Get.find<UserController>().usersList[0];
        controller
            .ubahProfil(userController.id, name,noHp, birthday, gender)
            .then((status) async {
          if (status.isSuccess) {
            print("Berhasil");
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: Dimensions.height45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back,
                      iconColor: AppColors.redColor,
                      backgroundColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20,
                  ),
                  Container(
                    child: BigText(
                      text: "Ubah Biodata ",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),

            // Nama
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height10),
              child: BigText(
                text: "Nama",
                size: Dimensions.font16,
              ),
            ),
            InputTextField(
              textController: NamaController,
              labelText: "A",
            ),
            SizedBox(
              height: Dimensions.height20,
            ),

            // Jenis Kelamin
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height10),
              child: BigText(
                text: "Jenis Kelamin",
                size: Dimensions.font16,
              ),
            ),
            AppDropdownField(
              controller: jenisKelaminController,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),

            // Tanggal Lahir
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height10),
              child: BigText(
                text: "Tanggal Lahir",
                size: Dimensions.font16,
              ),
            ),
            AppDateField(
              textController: tanggalLahirController,
              hintText: 'Tanggal Lahir',
              icon: Icons.calendar_today,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),

            // Nomor Handphone
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height10),
              child: BigText(
                text: "Nomor Handphone",
                size: Dimensions.font16,
              ),
            ),
            InputTextField(
              textController: NomorHandphoneController,
            ),
            SizedBox(
              height: Dimensions.height45,
            ),

            GestureDetector(
              onTap: (){
                _ubahProfil();
              },
              child: Center(
                child: Container(
                  width: Dimensions.width45*3,
                  height: Dimensions.width45,
                  // alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.redColor),
                  child: Center(
                    child: BigText(
                      text: "Ubah",
                      fontWeight: FontWeight.bold,
                      size: Dimensions.font20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )


          ]),
    ));
  }
}
