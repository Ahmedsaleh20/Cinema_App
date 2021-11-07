import 'package:flutter/material.dart';

class CustemText extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight?fontWidget;
  final double ?fontSize;
  final double ?space;
  final TextOverflow ?overflow;

  const CustemText({this.text,this.color, this.space,this.overflow, this.fontWidget, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(text!.length>15?text!.replaceRange(12, text!.length, "..."):"$text", style: TextStyle(
      color:color,
      fontWeight:fontWidget,
      letterSpacing:space,
      fontSize:fontSize,
      overflow: overflow,

    ),maxLines: 2,);
  }
}
