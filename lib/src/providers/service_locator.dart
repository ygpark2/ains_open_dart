import 'package:get_it/get_it.dart';
import 'package:ains_open_dart/src/providers/navigator_provider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationProvider());
}
