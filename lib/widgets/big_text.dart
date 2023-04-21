import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  TextAlign textAlign;
  FontWeight fontWeight;
  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 20,
      this.textAlign = TextAlign.end,
        this.fontWeight = FontWeight.normal,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: overFlow,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: 'Montserrat',
          color: color,
          fontWeight: fontWeight,
          fontSize: size == 0 ? Dimensions.font16 : size),
    );
  }
}
