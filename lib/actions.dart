import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_storybook/types.dart';

class StorybookActionTimed extends StorybookAction {
  StorybookActionTimed({
    @required this.when,
    @required String name,
    @required String text,
  }) : super(name: name, text: text);

  final DateTime when;
}

class ActionsRenderer extends HookWidget {
  ActionsRenderer({
    Key key,
    @required this.actions,
    @required this.height,
  }) : super(key: key);

  final Stream<StorybookAction> actions;

  final double height;
  @override
  Widget build(BuildContext context) {
    final _actions = useState(<StorybookActionTimed>[]);

    useEffect(() {
      assert(actions != null);

      void onData(StorybookAction a) {
        final now = DateTime.now().toLocal();

        _actions.value = [
          ..._actions.value,
          StorybookActionTimed(name: a.name, when: now, text: a.text),
        ];
      }

      final sub = actions.listen(onData);

      return sub.cancel;
    }, [actions]);

    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Actions'),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            reverse: true,
            children: _actions.value.reversed.map((x) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Text('${x.when}- ${x.name}: ${x.text}'),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
