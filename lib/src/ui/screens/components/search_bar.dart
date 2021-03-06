import 'package:ains_open_dart/src/index.dart';
import 'package:ains_open_dart/src/theme/colors.dart';

class WhmSearchBar extends StatelessWidget {
  const WhmSearchBar(
      {@required this.shrinkOffset, @required this.expandedHeight});

  final double shrinkOffset;
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold.of(context);

    return Positioned(
        top: _top(shrinkOffset),
        left: 0.0,
        right: 0.0,
        child: Opacity(
            opacity: 1,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Colors.white),
                    child: Row(children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.menu, color: SanColors.primary),
                          onPressed: () {
                            if (_scaffold.hasDrawer) {
                              _scaffold.openDrawer();
                            }
                          }),
                      const Expanded(
                          child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                              )
                          )
                      ),
                      IconButton(
                          icon: Icon(Icons.search, color: SanColors.primary),
                          onPressed: () {
                            print('your menu action here');
                          })
                      ]
                    )
                )
            )
        )
    );
  }

  double _top(double shrinkOffset) {
    var size = expandedHeight / 2 - shrinkOffset;

    if (size < 0) {
      size = 30;
    }
    return size;
  }
}
