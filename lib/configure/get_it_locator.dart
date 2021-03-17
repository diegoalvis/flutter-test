import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/api/repository/service/filter_service.dart';
import 'package:bogota_app/api/repository/service/splash_service.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() async {

  locator.registerSingleton<IdtRoute>(IdtRoute());
  locator.registerSingleton<ApiInteractor>(ApiInteractor());
  locator.registerSingleton<FilterService>(FilterService());
  locator.registerSingleton<SplashService>(SplashService());

  /* locator.registerSingletonAsync(() async {
    final database = Database();
    await database.initDb();
    return database;
  }); */

}
