import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  String? hintText;
  TextFieldWidget({
    super.key,
    this.hintText,
});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,

      ),
    );
  }
}
