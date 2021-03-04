import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class TitleSection extends StatelessWidget {

  final String title;

  TitleSection(this.title);

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: textTheme.titleBlack,
    );
  }
}