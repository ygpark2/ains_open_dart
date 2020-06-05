import 'package:ains_open_dart/src/blocs/theme/bloc.dart';
import 'package:ains_open_dart/src/index.dart';
import 'package:ains_open_dart/src/providers/navigator_provider.dart';
import 'package:ains_open_dart/src/providers/service_locator.dart';
import 'package:ains_open_dart/src/ui/screens/containers/tab_controller.dart';
import 'package:ains_open_dart/src/utilities/constants.dart';

import 'routes.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.

  Widget _iosApp(ChangeThemeState state) {
    return CupertinoApp(
      title: APP_TITLE,
      theme: state.themeData as CupertinoThemeData,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      routes: routes,
      navigatorKey: locator<NavigationProvider>().navigatorKey,
      onGenerateRoute: onGenerateRoute,
      home: AinsOpenDartTabController(),
    );
  }

  Widget _androidApp(ChangeThemeState state) {
    return MaterialApp(
      title: APP_TITLE,
      theme: state.themeData as ThemeData,
      debugShowCheckedModeBanner: false,
      routes: routes,
      navigatorKey: locator<NavigationProvider>().navigatorKey,
      onGenerateRoute: onGenerateRoute,
      home: AinsOpenDartTabController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context1) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Material(
            child: (() {
              if (Platform.isIOS) {
                return _iosApp(state as ChangeThemeState);
              }
              return _androidApp(state as ChangeThemeState);
            })(),
          );
        },
      ),
    );
  }
}
