import 'package:bogota_app/commons/idt_colors.dart';
import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {

  const TextFieldCustom({
    Key? key,
    required TextEditingController controller,
    required this.decoration, required this.style, this.keyboardType: TextInputType.text, this.obscureText :false,
  })
      : _controllerEmail = controller,
        super(key: key);

  final TextEditingController _controllerEmail;
  final InputDecoration decoration;
  final TextStyle style;
  final TextInputType  keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      cursorColor: IdtColors.blackShadow,
      keyboardType: keyboardType,
      style: style,
      controller: _controllerEmail,
      decoration: decoration,
    );
  }
}
