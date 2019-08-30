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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: viewport.mediaQueryData.size.width,
      height: viewport.mediaQueryData.size.height,
      child: MediaQuery(
        data: viewport.mediaQueryData,
        child: Theme(
          data: viewport.themeData,
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
