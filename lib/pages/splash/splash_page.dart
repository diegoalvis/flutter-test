import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//void main() async{
//  runApp();}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Bogotá App"),
          automaticallyImplyLeading: false
      ),
      body: new Center(
        child: new Text("Done!",
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
          ),),

      ),
    );
  }
}

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
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

final logo_get='https://bogotadc.travel/drpl/sites/default/files/2021-01/logosplashexample.png';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
    home: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/splash.jpg"),

              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text("Bogotá")
              ],

            ),
          )/* add child content here */,
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
              child:         Container(
                height: 65,
                width: 110,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("lib/assets/images/logo_bogota.png"),
             // scale: 0.1,
      //logosplashexample
              fit: BoxFit.scaleDown,
              ),
              ),
              child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
              Text("Bogotá")
              ],

              ),
              )/* add child content here */,
              ),
                      ),
          ),

          ),


      ],
    )
  );
  }
}
