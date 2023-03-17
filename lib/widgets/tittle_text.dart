import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class TittleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  TittleText(
      {Key? key,
        this.color = const Color(0xFF332d2b),
        required this.text,
        this.size = 20,
        this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: overFlow,
      style: TextStyle(
          fontFamily: 'Montserrat',
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: size==0?Dimensions.font16:size),
    );
  }
}
