import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hk;
import 'package:flutter_storybook/types.dart';

class KnobsRenderer extends StatelessWidget {
  KnobsRenderer({
    Key key,
    @required this.knobs,
    @required this.height,
  }) : super(key: key);

  final List<KnobWrapperBase> knobs;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Knobs'),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              ...knobs.map((knob) {
                if (knob is KnobWrapperPrimitive) {
                  if (knob.value is bool) {
                    return BoolKnob(knob: knob);
                  }
                  if (knob.value is String) {
                    return StringKnob(knob: knob);
                  }
                  if (knob.value is int) {
                    return IntKnob(knob: knob);
                  }

                  throw Exception(
                    'Knob of primitive type ${knob.value.runtimeType} not supported.',
                  );
                }

                throw Exception(
                  'Knob of type ${knob.runtimeType} not supported',
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}

class BoolKnob extends StatelessWidget {
  const BoolKnob({
    Key key,
    @required this.knob,
  }) : super(key: key);
  final KnobWrapperPrimitive<bool> knob;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Switch(
          onChanged: (v) {
            knob.value = v;
          },
          value: knob.value,
        ),
        Text(knob.name),
      ],
    );
  }
}

class IntKnob extends hk.HookWidget {
  IntKnob({
    Key key,
    @required this.knob,
  }) : super(key: key);
  final KnobWrapperPrimitive<int> knob;
  @override
  Widget build(BuildContext context) {
    final controller = hk.useMemoized(
      () => TextEditingController(text: knob.value.toString()),
    );
    hk.useEffect(
      () {
        void listener() {
          knob.value = int.tryParse(controller.text) ?? 0;
          controller.value = TextEditingValue(
            text: (int.tryParse(controller.text) ?? 0).toString(),
          );
        }

        controller.addListener(listener);

        return () {
          controller.removeListener(listener);
          controller.dispose();
        };
      },
      [],
    );

    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: knob.name,
      ),
      controller: controller,
    );
  }
}

class StringKnob extends hk.HookWidget {
  StringKnob({
    Key key,
    @required this.knob,
  }) : super(key: key);
  final KnobWrapperPrimitive<String> knob;
  @override
  Widget build(BuildContext context) {
    final controller = hk.useMemoized(
      () => TextEditingController(text: knob.value),
    );
    hk.useEffect(
      () {
        void listener() {
          knob.value = controller.text;
        }

        controller.addListener(listener);

        return () {
          controller.removeListener(listener);
          controller.dispose();
        };
      },
      [],
    );

    return TextField(
      decoration: InputDecoration(
        labelText: knob.name,
      ),
      controller: controller,
    );
  }
}
