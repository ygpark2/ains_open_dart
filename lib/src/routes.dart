import 'package:ains_open_dart/src/index.dart';
import 'package:ains_open_dart/src/ui/screens/components/platform_wrapper.dart';
import 'package:ains_open_dart/src/ui/screens/home.dart';
import 'package:ains_open_dart/src/ui/screens/route_not_found.dart';
import 'package:ains_open_dart/src/utilities/constants.dart';

Widget _wrapper(Widget page) {
  return PlatformWrapper(
    page: page,
  );
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>
            _wrapper(RouteNotFound(name: settings.name)),
      );
  }
}

// Add app DYNAMIC routes here
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  Routes.HOME_ROUTE[0]: (BuildContext context) => _wrapper(HomePage()),
};
