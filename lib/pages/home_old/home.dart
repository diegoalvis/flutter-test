import 'package:bogota_app/pages/home_old/home_add_places.dart';
import 'package:bogota_app/pages/home_old/home_user.dart';
import 'package:bogota_app/pages/imperdibles/imperdibles.dart';
import 'package:bogota_app/pages/audioguias/audioguias.dart';
import 'package:bogota_app/pages/home_old/masalla.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/bogota_icon.dart';

class Home extends StatefulWidget {
  static const String routeName = "/HomePage";
  Home({Key? key, this.state = true, this.i, this.newscreen = false}) : super(key: key);
  final bool state;
  int? i;
  final bool newscreen;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Indica los screens a los que se puede enrutar la app
  final List<Widget> screens = [
    Audioguias(),
    Audioguias(),
    Imperdibles(),
    Mas_Alla(),
    Home_User(
      state: true,
    ),
    Home_Add_Places(),
  ];
  @override
  late Widget currentScreen;

  void initState() {
    /// i: indica el indice del screen que se mostrará
    /// newscreen indica si se ha enrutado desde otra vista

    print(widget.i);
    // TODO: implement initState
    super.initState();
    print(widget.newscreen);
    if (widget.newscreen) {
      currentScreen = screens[widget.i!];
    } else {
      currentScreen = Home_User(
        state: false,
      );
    }
  }

  /// Variables y propiedades
  final orange = Color(0xFFFF7C47);
  final grey = Colors.grey;
  int currentTab = 2; /// indica la vista actual
  //
  final PageStorageBucket bucket = PageStorageBucket();

  var home_selected = BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(colors: [
        Color(0xFFBD411A),
        Color(0xFFDC4C1F),
        Color(0xFFFF8033),
        Color(0xFFFF7C47),
      ]));

  var home_unselected = BoxDecoration(
      shape: BoxShape.circle, color: Colors.white
      //  gradient: LinearGradient(colors: [Colors.grey,Colors.grey]));
      //    gradient: LinearGradient(colors: [Colors.orange[900],Colors.orange[200]])
      );

  // Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    print("widget.i2");
    print(widget.newscreen);

    return Scaffold(
      extendBody: true,
      //  primary: true,
      // backgroundColor: Colors.blue,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.blue,
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Bogota_icon.home,
            color: currentTab == 2 ? Colors.white : Colors.grey,
            size: 35,
          ),
          decoration: currentTab == 2 ? home_selected : home_unselected,
        ),
        onPressed: () {
          setState(() {
            print(currentTab);
            currentScreen = Home_User(
              state: false,
            ); // if user taps on this dashboard tab will be active
            currentTab = 2;
            print(currentTab);
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        //  clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: Container(
          height: 52,
          decoration: new BoxDecoration(
              //  color: Colors.white10,
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          )),
          child: Row(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  MaterialButton(
                    minWidth: 195,
                    onPressed: () {
                      setState(() {
                        currentScreen = Mas_Alla();
                        //   Dashboard(); // if user taps on this dashboard tab will be active

                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Bogota_icon.compass,
                          color: currentTab == 0 ? orange : grey,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Center(
                child: Container(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              // Right Tab bar icons

              Row(
                //    mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  MaterialButton(
                    minWidth: 195,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Home_Add_Places(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: currentTab == 1
                              ? orange
                              : currentTab == 3
                                  ? grey
                                  : grey,
                          size: 30,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      //    resizeToAvoidBottomInset: true,
    );
  }
}
