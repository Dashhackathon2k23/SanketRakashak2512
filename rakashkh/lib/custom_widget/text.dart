import 'package:flutter/cupertino.dart';

class TextWidget extends StatefulWidget {
  String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;

 TextWidget({super.key,
   required this.text,
   this.color,
   this.fontSize,
   this.fontWeight,
   this.textAlign,
});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text, style: TextStyle(color: widget.color,fontSize: widget.fontSize, fontWeight: widget.fontWeight),textAlign: widget.textAlign,);
  }
}
