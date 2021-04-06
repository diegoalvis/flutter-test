import 'package:bogota_app/data/repository/interactor.dart';


import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/repository/service/filter_service.dart';
import 'package:bogota_app/data/repository/service/food_service.dart';
import 'package:bogota_app/data/repository/service/gps_service.dart';
import 'package:bogota_app/data/repository/service/sleep_service.dart';
import 'package:bogota_app/data/repository/service/splash_service.dart';
import 'package:bogota_app/data/repository/service/unmissable_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() async {

  locator.registerSingleton<IdtRoute>(IdtRoute());
  locator.registerSingleton<ApiInteractor>(ApiInteractor());
  locator.registerSingleton<FilterService>(FilterService());
  locator.registerSingleton<GpsService>(GpsService());
  locator.registerSingleton<SplashService>(SplashService());

  locator.registerSingleton<PlacesSleepService>(PlacesSleepService());
  locator.registerSingleton<UnmissableService>(UnmissableService());
  locator.registerSingleton<PlacesFoodService>(PlacesFoodService());
  // locator.registerSingleton<ZoneService>(ZoneService());

  /* locator.registerSingletonAsync(() async {
    final database = Database();
    await database.initDb();
    return database;
  }); */

}
