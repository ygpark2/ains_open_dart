import 'package:ains_open_dart/src/index.dart';
import 'package:ains_open_dart/src/ui/screens/components/theme_switch.dart';
import 'package:ains_open_dart/src/ui/screens/home.dart';
import 'package:ains_open_dart/src/ui/screens/notifications.dart';
import 'package:ains_open_dart/src/ui/screens/people.dart';
import 'package:ains_open_dart/src/ui/screens/settings.dart';
import 'package:ains_open_dart/src/ui/screens/user.dart';
import 'package:ains_open_dart/src/ui/screens/videos.dart';
import 'package:ains_open_dart/src/utilities/constants.dart';

// ignore: must_be_immutable
class AinsOpenDartTabController extends StatefulWidget {
  AinsOpenDartTabController({Key key}) : super(key: key);

  int _selectedPage = 0;

  @override
  State<StatefulWidget> createState() => _AinsOpenDartTabController();
}

class _AinsOpenDartTabController extends State<AinsOpenDartTabController> {
  final List<BottomNavigationBarItem> tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.people), title: Container()),
    BottomNavigationBarItem(
        icon: Icon(Icons.video_library), title: Container()),
    BottomNavigationBarItem(
        icon: Icon(Icons.notifications), title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.menu), title: Container()),
  ];

  final List<Widget> items = <Widget>[
    HomePage(),
    PeoplePage(),
    VideoPage(),
    NotificationPage(),
    UserPage(),
    SettingPage()
  ];

  Widget _ios(BuildContext context) {
    var theme = CupertinoTheme.of(context);

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: theme.barBackgroundColor,
        activeColor: theme.textTheme.textStyle.color,
        items: tabs,
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context1) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(APP_TITLE),
                leading: ThemeSwitch(),
              ),
              child: items[index],
            );
          },
        );
      },
    );
  }

  Widget _android(BuildContext context) {
    var appBarTheme = Theme.of(context).appBarTheme;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        primary: true,
        resizeToAvoidBottomInset: false,
        body: Scaffold(
          appBar: AppBar(
            leading: ThemeSwitch(),
            title: Center(child: Text(APP_TITLE)),
          ),
          body: items[widget._selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: appBarTheme.color,
            selectedIconTheme: appBarTheme.iconTheme,
            unselectedIconTheme: appBarTheme.iconTheme.copyWith(
              color: Colors.grey,
            ),
            type: BottomNavigationBarType.fixed,
            currentIndex: widget._selectedPage,
            onTap: (int index) {
              setState(() {
                widget._selectedPage = index;
              });
            },
            items: tabs,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _ios(context);
    }
    return _android(context);
  }
}
