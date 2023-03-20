import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import '../utils/colors.dart';

enum FormData {
  Gender,
}
class Genders {
  String genders;
  Genders(this.genders);
}

class AppDropdownField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  bool isObscure;
  AppDropdownField({Key? key, required this.hintText, required this.icon, this.isObscure = false}) : super(key: key);

  FormData? selected;
  List<DropdownMenuItem> generateItems(List<Genders> genders) {
    List<DropdownMenuItem> items = [];
    for (var item in genders) {
      items.add(DropdownMenuItem(
        child: Text(item.genders),
        value: item,
      ));
    }
    return items;
  }

  Genders? selectedGender;
  List<Genders> genders = [Genders("Laki-Laki"), Genders("Perempuan")];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color : Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon, color: AppColors.redColor,),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  borderSide: BorderSide(
                      width: 1.0,
                      color: AppColors.redColor
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  borderSide: BorderSide(
                      width: 1.0,
                      color: Colors.white
                  )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              )
          ),
          value: selectedGender,
          items: generateItems(genders),
          onChanged: (item) {
              selectedGender = item;
              Text(
                (selectedGender != null)
                    ? selectedGender!.genders
                    : "Belum ada terpilih",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(
                        255, 245, 47, 47)),
              );
            }
        ),


      ),
    );
  }
}
