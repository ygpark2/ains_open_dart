import 'package:ains_open_dart/src/index.dart';
import 'package:ains_open_dart/src/utilities/constants.dart';

class NavigationProvider {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {ScreenArguments args}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: args);
  }
}
