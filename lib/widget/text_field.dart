import 'package:bogota_app/commons/idt_colors.dart';
import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
    required TextEditingController controller,
    this.cursorColor: IdtColors.blackShadow,
    required this.decoration,
    required this.style,
    this.keyboardType: TextInputType.text,
    this.obscureText: false,
    this.validator,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final InputDecoration decoration;
  final TextStyle style;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color cursorColor;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      style: style,
      controller: _controller,
      decoration: decoration,
    );
  }
}
