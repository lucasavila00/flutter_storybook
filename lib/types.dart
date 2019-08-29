import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class KnobWrapperBase<T> {
  String get name;
  T get value;
  set value(T v);
}

class KnobWrapperPrimitive<T> extends KnobWrapperBase<T> {
  KnobWrapperPrimitive({
    @required this.name,
    @required this.valueNotifier,
  });
  final String name;

  final ValueNotifier<T> valueNotifier;

  T get value => valueNotifier.value;
  set value(T v) => valueNotifier.value = v;
}

abstract class StoryBase extends HookWidget {
  String get name;
}

class StorybookAction {
  final String name;
  final String text;

  StorybookAction({
    @required this.name,
    @required this.text,
  });

  @override
  String toString() {
    return "$name: $text";
  }
}

class StoryViewport {
  final String name;
  // final Orientation orientation;
  final TargetPlatform platform;

  // final double _height;
  // final double _width;
  // final double devicePixelRatio;
  // double get width =>
  //     (orientation == Orientation.portrait ? _width : _height);
  // double get height =>
  //     (orientation == Orientation.portrait ? _height : _width);

  final MediaQueryData mediaQueryData;
  final ThemeData themeData;

  const StoryViewport({

    @required this.name,

    @required this.mediaQueryData,
    @required this.themeData,

    // @required this.orientation,
    @required this.platform,
    // @required this.devicePixelRatio,

    // @required double height,
    // @required double width,
  })  ;
}
