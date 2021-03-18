import 'dart:async';

import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/home/home_page.dart';
import 'package:bogota_app/pages/splash/splash_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(
          locator<IdtRoute>(),
          locator<ApiInteractor>()
      ),
      builder: (context, _) {
        return SplashScreen();
      },
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // startTime() async {
  //   var _duration = new Duration(seconds: 2);
  //   return new Timer(_duration, navigationPage);
  // }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> HomePage()));
  }

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<SplashViewModel>();
    viewModel.getSplash();
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