import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/pages/home/home_page_body.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';

import '../../utils/dimensions.dart';


class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Test1", color: AppColors.redColor,size: Dimensions.height30),
                      Text("Test")
                    ],
                  ),
                  Center(
                     child:  Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.redColor),
                      )
                  )
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: HomePageBody(),
          )),
        ],
      ),
    );
  }
}
