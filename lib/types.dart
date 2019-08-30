import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class StoryBase extends HookWidget {
  String get name;
}

class StoryViewport {
  final String name;
  final MediaQueryData mediaQueryData;
  final ThemeData themeData;

  const StoryViewport({
    @required this.name,
    @required this.mediaQueryData,
    @required this.themeData,
  });
}

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
