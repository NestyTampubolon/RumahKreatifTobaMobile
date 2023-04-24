import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextAlign textAlign;
  SmallText(
      {Key? key,
        this.color = const Color(0xFF625D5D),
        required this.text,
        this.size = 12,
        this.height = 1.2,
        this.textAlign = TextAlign.start,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: size,
          height: height),
    );
  }
}
