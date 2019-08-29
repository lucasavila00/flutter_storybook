import 'package:flutter/material.dart';

import 'types.dart';

class TabRenderer extends StatelessWidget {
  TabRenderer({
    Key key,
    @required this.childBuilder,
    @required this.viewport,
  }) : super(key: key);
  final Widget Function(BuildContext) childBuilder;

  final StoryViewport viewport;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: ViewportSizer(
                viewport: viewport,
                childBuilder: childBuilder,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ViewportSizer extends StatelessWidget {
  ViewportSizer({
    Key key,
    @required this.childBuilder,
    @required this.viewport,
  }) : super(key: key);
  final StoryViewport viewport;
  final Widget Function(BuildContext) childBuilder;

  // Runner: flutter: ThemeData#c7972(buttonTheme: ButtonThemeData#34c55(buttonColor: Color(0xffe0e0e0), focusColor: Color(0x1f000000), hoverColor: Color(0x0a000000), colorScheme: ColorScheme#ece0f(primary: MaterialColor(primary value: Color(0xff2196f3)), primaryVariant: Color(0xff1976d2), secondary: Color(0xff2196f3), secondaryVariant: Color(0xff1976d2), background: Color(0xff90caf9), error: Color(0xffd32f2f), onSecondary: Color(0xffffffff), onBackground: Color(0xffffffff)), materialTapTargetSize: MaterialTapTargetSize.padded), toggleButtonsTheme: ToggleButtonsThemeData#61203, textTheme: TextTheme#ee018(display4: TextStyle(debugLabel: (englishLike display4 2014).merge(blackCupertino display4), inherit: false, color: Color(0x8a000000), family: .SF UI Display, size: 112.0, weight: 100, baseline: alphabetic, decoration: TextDecoration.none), display3: TextStyle(debugLabel: (englishLike display3 2014).merge(blackCupertino display3), inherit: false, color: Color(0x8a000000), family: .SF UI Display, size: 56.0, <…>

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: viewport.mediaQueryData.size.width ,
        height: viewport.mediaQueryData.size.height ,
        child:Theme(
      data: viewport.themeData,
      child: MediaQuery(
            data: viewport.mediaQueryData,
            child: Scaffold(
          body: Builder(
                      builder: (BuildContext context) => childBuilder(context),
                    ),
          ),
        ),
      ),
    );
  }
}
