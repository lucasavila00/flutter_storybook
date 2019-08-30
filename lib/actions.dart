import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_storybook/types.dart';

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
    final _actions = useState(<StorybookAction>[]);

    useEffect(() {
      assert(actions != null);

      void onData(StorybookAction a) {
        _actions.value = [..._actions.value, a];
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
              final now = DateTime.now().toLocal().toString();
              return Container(
                padding: EdgeInsets.all(8),
                child: Text('$now: $x'),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
