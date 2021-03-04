import 'package:flutter/material.dart';

import 'commons/idt_colors.dart';

class AppTheme{

  static final textTheme = TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'MuseoSans',
      color: Color(0xff212121)
    )
  );

  static ThemeData build() => ThemeData(
    //appBarTheme: , agregar color
    primaryColor:  IdtColors.blue,
    primaryColorDark: IdtColors.blueDark,
    accentColor: IdtColors.blueAccent,
    backgroundColor: IdtColors.white,
    brightness: Brightness.light,

    textTheme: textTheme.copyWith(
      bodyText2: textTheme.bodyText1.copyWith(
        fontSize: 12
      )
    )
  );
}

extension GFilesAttributes on TextTheme{

  TextStyle get titleBlack => bodyText1.copyWith(
    color: IdtColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600
  );

  TextStyle get titleWhite => bodyText1.copyWith(
    color: IdtColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold
  );

  TextStyle get subTitleBlack => bodyText1.copyWith(
    color: IdtColors.black,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  TextStyle get textMenu => bodyText1.copyWith(
    color: IdtColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  TextStyle get textDescrip => bodyText1.copyWith(
    color: IdtColors.grayText,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  TextStyle get textWhiteShadow => bodyText1.copyWith(
    color: Colors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        color: IdtColors.black.withOpacity(1),
        offset: Offset(0, 0),
        blurRadius: 10,
      ),
    ],
  );

  TextStyle get titleGray  => bodyText1.copyWith(
      color: IdtColors.gray,
      fontSize: 16
  );

  TextStyle get textDetail => bodyText1.copyWith(
    color: IdtColors.black,
    fontSize: 16
  );
  TextStyle get grayDetail => bodyText1.copyWith(
      color: IdtColors.gray,
      fontSize: 12
  );
  TextStyle get blueDetail => bodyText1.copyWith(
      color: IdtColors.blue,
      fontSize: 14
  );
  TextStyle get textButtomWhite => bodyText1.copyWith(
      color: IdtColors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600
  );
  TextStyle get textButtomBlue => bodyText1.copyWith(
      color: IdtColors.blue,
      fontSize: 14,
      fontWeight: FontWeight.w600
  );
}