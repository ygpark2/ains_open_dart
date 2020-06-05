import 'package:ains_open_dart/src/index.dart';
import 'package:ains_open_dart/src/ui/widgets/buttons/raised.dart';
import 'package:ains_open_dart/src/ui/widgets/drawer/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AinsOpenDartRaisedButton(),
          const Text(
            'You have pushed the button this many times:',
          ),
        ],
      ),
    );
  }
}
