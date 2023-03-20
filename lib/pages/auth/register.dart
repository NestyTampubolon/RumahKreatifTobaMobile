import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/base/custom_loader.dart';
import 'package:rumah_kreatif_toba/controllers/auth_controller.dart';
import 'package:rumah_kreatif_toba/models/users_models.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../base/show_custom_message.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_date_field.dart';
import '../../widgets/app_dropdown_field.dart';
import '../../widgets/app_text_field.dart';
import 'package:intl/intl.dart';

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

    void _registration(AuthController authController){
      String name = namaLengkapController.text.trim();
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      String no_hp = nomorTeleponController.text.trim();
      String birthday = tanggalLahirController.text.trim();
      String gender = jenisKelaminController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Nama masih kosong", title: "Nama");
      }else if(username.isEmpty){
        showCustomSnackBar("Username masih kosong", title: "Username");
      }else if(password.isEmpty){
        showCustomSnackBar("Password masih kosong", title: "Password");
      }else if(email.isEmpty){
        showCustomSnackBar("Email masih kosong", title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Email tidak sesuai", title: "Invalid Email");
      }else if(no_hp.isEmpty){
        showCustomSnackBar("Nomor Telepon masih kosong", title: "Nomor Telepon");
      }else if(birthday.isEmpty){
        showCustomSnackBar("Tanggal Lahir masih kosong", title: "Tanggal Lahir");
      }else if(gender.isEmpty){
        showCustomSnackBar("Jenis Kelamin masih kosong", title: "Jenis Kelamin");
      }else{
        Users users = Users(name: name, username: username, password: password, email: email, no_hp: no_hp, birthday: birthday, gender: gender);
        authController.registrasi(users).then((status){
          if(status.isSuccess){
            print("Sukses registrasi");
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              Container(
                width: Dimensions.screenHeight*0.25,
                height: Dimensions.screenHeight*0.25,
                margin: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/logo_rkt.png"))),
              ),
              AppTextField(textController: namaLengkapController, hintText: 'Nama Lengkap', icon: Icons.person,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: usernameController, hintText: 'Username', icon: Icons.person,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: emailController, hintText: 'Email', icon: Icons.mail,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: passwordController, hintText: 'Password', icon: Icons.lock, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: konfirmasiPasswordController, hintText: 'Konfirmasi Password', icon: Icons.lock, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: nomorTeleponController, hintText: 'Nomor Telepon', icon: Icons.phone_android,textInputType: TextInputType.number,),
              SizedBox(height: Dimensions.height20,),
              AppDateField(textController: tanggalLahirController, hintText: 'Tanggal Lahir', icon: Icons.calendar_today,),
              SizedBox(height: Dimensions.height20,),
              AppDropdownField(hintText: 'Jenis Kelamin', icon: Icons.people,),
              SizedBox(height: Dimensions.height20,),
              GestureDetector(
                onTap : () {
                  _registration(_authController);
                },
                child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.redColor
                    ),
                    child: Center(
                      child: BigText(text: "Daftar",
                        size: Dimensions.font20,color: Colors.white,),
                    )


                ),
              ),

              SizedBox(height: Dimensions.height10,),
              RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Sudah memiliki akun?",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                  )
              )),
              SizedBox(height: Dimensions.height15,),

            ],
          ),
        ):CustomLoader();
      })
    );
  }
}
