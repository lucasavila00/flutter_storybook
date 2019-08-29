import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_storybook/types.dart';

import 'context.dart';

class StoryWithController extends HookWidget {
  final List<String> routeNames;
  final String name;
  final Widget child;
  final List<StoryViewport> appViewports;

  const StoryWithController({
    Key key,
    @required this.routeNames,
    @required this.name,
    @required this.child,
    @required this.appViewports,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final controller = useStreamController<StorybookAction>();
    return StoryContext(
      child: child,
      name: name,
      routeNames: routeNames,
      actionsController: controller,
      appViewports: appViewports,
    );
  }
}

List<StoryViewport> defaultViewports = [
  StoryViewport(
    name: 'iPhone 7 Plus',
    mediaQueryData: MediaQueryData(
      size: Size(414.0, 736.0),
      devicePixelRatio: 3.0,
      //  textScaleFactor: 1.0, platformBrightness: Brightness.light, padding: EdgeInsets(0.0, 20.0, 0.0, 0.0), viewPadding: EdgeInsets(0.0, 20.0, 0.0, 0.0), viewInsets: EdgeInsets.zero, physicalDepth: 1.7976931348623157e+308, alwaysUse24HourFormat: false, accessibleNavigation: false, highContrast: false,disableAnimations: false, invertColors: false, boldText: false
      ),
    themeData: ThemeData(platform: TargetPlatform.iOS),
    // devicePixelRatio: 3.0,
    // height: 1920,
    // width: 1080,
    // orientation: Orientation.portrait,
    platform: TargetPlatform.iOS,
  ),

];

class StoryApp extends StatelessWidget {
  final List<StoryBase> stories;
  final List<StoryViewport> viewports;

  const StoryApp({
    Key key,
    @required this.stories,
    this.viewports,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routes = <String, Widget Function(BuildContext)>{};
    final List<String> routeNames = stories.map((x) => x.name).toList();
    stories.forEach((h) {
      routes.putIfAbsent(
        h.name,
        () => (BuildContext context) => StoryWithController(
              name: h.name,
              routeNames: routeNames,
              child: h,
              appViewports: viewports ?? defaultViewports,
            ),
      );
    });

    return MaterialApp(
      title: 'Flutter Storybook',
      initialRoute: stories[0].name,
      routes: routes,
    );
  }
}
