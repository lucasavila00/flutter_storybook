import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_storybook/types.dart';

import 'context.dart';

List<StoryViewport> defaultViewports = [
  StoryViewport(
    name: 'iPhone 7 Plus',
    // copied from values printed on emulator
    mediaQueryData: MediaQueryData(
      size: Size(414.0, 736.0),
      devicePixelRatio: 3.0,
      textScaleFactor: 1.0,
      platformBrightness: Brightness.light,
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      viewPadding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      viewInsets: EdgeInsets.zero,
      physicalDepth: 1.7976931348623157e+308,
      alwaysUse24HourFormat: false,
      accessibleNavigation: false,
      highContrast: false,
      disableAnimations: false,
      invertColors: false,
      boldText: false,
    ),
    themeData: ThemeData(
      // this doesn't seem to be enough on iOS.
      // text is still not pixel perfect equal
      platform: TargetPlatform.iOS,
    ),
  ),
  StoryViewport(
    name: 'Android',
    // copied from values printed on emulator
    mediaQueryData: MediaQueryData(
      size: Size(360.0, 640.0),
      devicePixelRatio: 1.5,
      textScaleFactor: 1.0,
      platformBrightness: Brightness.light,
      padding: EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
      viewPadding: EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
      viewInsets: EdgeInsets.zero,
      physicalDepth: 1.7976931348623157e+308,
      alwaysUse24HourFormat: true,
      accessibleNavigation: false,
      highContrast: false,
      disableAnimations: false,
      invertColors: false,
      boldText: false,
    ),
    themeData: ThemeData(
      platform: TargetPlatform.android,
    ),
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
        () => (BuildContext context) => _StoryWithController(
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

class _StoryWithController extends HookWidget {
  final List<String> routeNames;
  final String name;
  final Widget child;
  final List<StoryViewport> appViewports;

  const _StoryWithController({
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
      showcase: false,
    );
  }
}
