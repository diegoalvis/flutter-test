import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/splash/splash_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>(),
      ),
      builder: (context, _) {
        return SplashWidget();
      },
    );
  }
}

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => new _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<SplashViewModel>();
    viewModel.getSplash();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SplashViewModel>();

    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: viewModel.status.imgSplash != null
                  ? NetworkImage(viewModel.status.imgSplash!)
                  : AssetImage(IdtAssets.splash) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
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
                  )),
            ),
          ),
        ),
      ],
    ));
  }
}
