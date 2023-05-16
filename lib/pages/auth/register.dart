import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/base/custom_loader.dart';
import 'package:rumah_kreatif_toba/controllers/auth_controller.dart';
import 'package:rumah_kreatif_toba/models/users_models.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../base/show_custom_message.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_date_field.dart';
import '../../widgets/app_dropdown_field.dart';
import '../../widgets/app_text_field.dart';
import 'package:intl/intl.dart';

import '../../widgets/app_text_field_password.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController dateinput = TextEditingController();
    var namaLengkapController = TextEditingController();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    var konfirmasiPasswordController = TextEditingController();
    var emailController = TextEditingController();
    var nomorTeleponController = TextEditingController();
    var tanggalLahirController = TextEditingController();
    var jenisKelaminController = TextEditingController();
    var genderValue;
    var birthdayValue;

    Future<void> _registration(AuthController authController) async {
      String name = namaLengkapController.text.trim();
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      String konfirmasiPassword = konfirmasiPasswordController.text.toString();
      String email = emailController.text.trim();
      String no_hp = nomorTeleponController.text.trim();
      String birthday = tanggalLahirController.text.trim();
      String gender = jenisKelaminController.text.trim();

      DateTime parsedBirthday = DateFormat('dd-MM-yyyy').parse(birthday);
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedBirthday);
      birthdayValue = formattedDate;

      if (jenisKelaminController.text.trim() == "Laki-laki") {
        gender = "L";
      } else if (jenisKelaminController.text.trim() == "Perempuan") {
        gender = "P";
      }

      if (name.isEmpty) {
        showCustomSnackBar("Nama masih kosong", title: "Nama");
      } else if (username.isEmpty) {
        showCustomSnackBar("Username masih kosong", title: "Username");
      } else if (password.isEmpty) {
        showCustomSnackBar("Password masih kosong", title: "Password");
      } else if (konfirmasiPassword.isEmpty) {
        showCustomSnackBar("Konfirmasi Password masih kosong",
            title: "Password");
      } else if (email.isEmpty) {
        showCustomSnackBar("Email masih kosong", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Email tidak sesuai", title: "Invalid Email");
      } else if (no_hp.isEmpty) {
        showCustomSnackBar("Nomor Telepon masih kosong",
            title: "Nomor Telepon");
      } else if (gender == null) {
        showCustomSnackBar("Jenis Kelamin masih kosong",
            title: "Jenis Kelamin");
      } else if (birthdayValue == null) {
        showCustomSnackBar("Tanggal Lahir masih kosong",
            title: "Tanggal Lahir");
      } else if (konfirmasiPassword != password) {
        showCustomSnackBar("Password tidak sama dengan Konfirmasi Password",
            title: "Konfirmasi Password");
      } else {
        Users users = Users(
            name: name,
            username: username,
            password: password,
            email: email,
            noHp: no_hp,
            birthday: birthdayValue,
            gender: gender);
        authController.registrasi(users).then((status) {
          if (status.isSuccess) {
            print("Sukses registrasi");
            Get.snackbar("Registrasi", "Akun sudah berhasil di daftar silahkan kembali masuk dengan username dan passsword Anda!",
                backgroundColor: AppColors.redColor,
                colorText: Colors.white
            );
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      Container(
                        width: Dimensions.screenHeight * 0.25,
                        height: Dimensions.screenHeight * 0.25,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10,
                            right: Dimensions.width10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage("assets/images/logo_rkt.png"))),
                      ),
                      AppTextField(
                        textController: namaLengkapController,
                        hintText: 'Nama Lengkap',
                        icon: Icons.person,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                        textController: usernameController,
                        hintText: 'Username',
                        icon: Icons.person,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                        textController: emailController,
                        hintText: 'Email',
                        icon: Icons.mail,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextFieldPassword(
                        textController: passwordController,
                        hintText: 'Password',
                        icon: Icons.lock,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextFieldPassword(
                        textController: konfirmasiPasswordController,
                        hintText: 'Konfirmasi Password',
                        icon: Icons.lock,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                        textController: nomorTeleponController,
                        hintText: 'Nomor Telepon',
                        icon: Icons.phone_android,
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppDropdownField(
                        hintText: 'Jenis Kelamin',
                        icon: Icons.people,
                        controller: jenisKelaminController,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppDateField(
                        textController: tanggalLahirController,
                        hintText: 'Tanggal Lahir',
                        icon: Icons.calendar_today,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
                        },
                        child: Container(
                            width: Dimensions.width45*3,
                            height: Dimensions.height45,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.redColor),
                            child: Center(
                              child: BigText(
                                text: "Daftar",
                                size: Dimensions.font20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Sudah memiliki Akun? ",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.back(),
                                    text: "Masuk",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: Dimensions.font16))
                              ])),
                      SizedBox(
                        height: Dimensions.height15,
                      ),
                    ],
                  ),
                )
              : CustomLoader();
        }));
  }
}
