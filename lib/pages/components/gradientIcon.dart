import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GradientIcon extends StatelessWidget {

  final IconData icon;
  final double size;
  final LinearGradient gradient;

  GradientIcon({@required this.icon, @required this.size, @required this.gradient});

  @override
  Widget build(BuildContext context) {
    return gradientIcon(icon, size, gradient);
  }

  Widget gradientIcon(icon, size, gradient){

    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }

}

