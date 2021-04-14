import 'package:bogota_app/commons/idt_colors.dart';
import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {

  const TextFieldCustom({
    Key? key,
    required TextEditingController controller,
    required this.decoration,required this.style,
  }) : _controllerEmail = controller, super(key: key);

  final TextEditingController _controllerEmail;
  final InputDecoration decoration;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: IdtColors.blackShadow,
      keyboardType: TextInputType.emailAddress,
      style: style,
      controller: _controllerEmail,
      decoration: decoration,
    );
  }
}
