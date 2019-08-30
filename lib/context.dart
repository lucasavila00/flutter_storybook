import 'dart:async';
import 'package:flutter/material.dart';

import 'types.dart';

class StoryContext extends InheritedWidget {
  StoryContext({
    Key key,
    @required Widget child,
    @required this.name,
    @required this.routeNames,
    @required this.actionsController,
    @required this.appViewports,
  }) : super(key: key, child: child);

  final String name;
  final List<String> routeNames;
  final knobs = <KnobWrapperBase>[];
  final StreamController<StorybookAction> actionsController;
  final List<StoryViewport> appViewports;

  void addKnob(KnobWrapperBase knob) {
    if (knobs.any((x) => x.name == knob.name)) {
      return;
    }
    knobs.add(knob);
  }

  static StoryContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(StoryContext);
  }

  @override
  bool updateShouldNotify(StoryContext oldWidget) =>
      name != oldWidget.name || knobs != oldWidget.knobs;
}
