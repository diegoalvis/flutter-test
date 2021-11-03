import 'dart:async';

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/pages/home/home_page.dart';
import 'package:bogota_app/pages/select_language/select_language_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> SelectLanguagePage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IdtAssets.splash),
                fit: BoxFit.cover,
              ),
            )
          ),
          Positioned(
            top: 10.0,
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Container(
                  height: 65,
                  width: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(IdtAssets.logo_bogota),
                      fit: BoxFit.scaleDown,
                    ),
                  )
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}