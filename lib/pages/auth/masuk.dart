import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/pages/auth/register.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../base/custom_loader.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';

class Masuk extends StatelessWidget {
  const Masuk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

      if(username.isEmpty){
        showCustomSnackBar("Username masih kosong", title: "Username");
      }else if(password.isEmpty){
        showCustomSnackBar("Password masih kosong", title: "Password");
      }else{
        authController.login(username, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?  SingleChildScrollView(
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
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: usernameController, hintText: 'Username', icon: Icons.person,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: passwordController, hintText: 'Password', icon: Icons.lock, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Lupa kata sandi?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      )
                  )),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(height: Dimensions.height20,),
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child:Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.redColor
                    ),
                    child: Center(
                      child: BigText(text: "Masuk",
                        size: Dimensions.font20,color: Colors.white,),
                    )


                ),
              ),

              SizedBox(height: Dimensions.height10,),
              RichText(text: TextSpan(
                  text: "Tidak memiliki Akun? ",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16
                  ),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(() => Register(), transition: Transition.fadeIn),
                        text: "Daftar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: Dimensions.font16
                        )
                    )
                  ]
              )),
              SizedBox(height: Dimensions.height15,),

            ],
          ),
        ) : CustomLoader();
      },)


    );
  }
}
