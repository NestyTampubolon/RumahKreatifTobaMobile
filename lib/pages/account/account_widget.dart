import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.signColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
          borderRadius: BorderRadius.circular(
              Dimensions.radius15),
      ),
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),
      margin: EdgeInsets.only(
        left: Dimensions.width20,
        right: Dimensions.width20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              appIcon,
              SizedBox(width: Dimensions.width20),
              bigText,
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: Dimensions.width10),
            child: AppIcon(icon: Icons.chevron_right_outlined, iconSize: Dimensions.iconSize24, iconColor: AppColors.redColor, backgroundColor: Colors.white.withOpacity(0.0),),
          )

        ],
      ),
    );
  }
}
