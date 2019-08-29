import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_storybook/types.dart';

import 'context.dart';

void Function() useStory(String routeName) {
  final context = useContext();

  return () {
    Navigator.of(context).pushNamed(routeName);
  };
}

void Function(String) useAction(String name) {
  final context = useContext();
  final StoryContext storyContext = StoryContext.of(context);

  return (String text) {
    storyContext.actionsController.add(StorybookAction(name: name, text: text));
  };
}

T useKnob<T>(
  T initialData,
  String name,
) {
  final ValueNotifier<T> v = useState(initialData);
  final knob = KnobWrapperPrimitive<T>(name: name, valueNotifier: v);
  final context = useContext();
  final StoryContext storyContext = StoryContext.of(context);
  storyContext.addKnob(knob);

  return knob.value;
}
