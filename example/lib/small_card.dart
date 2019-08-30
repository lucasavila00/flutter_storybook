import 'package:flutter/material.dart';

// This is a 'real' component, one like many you have
// on your app.
class SmallCard extends StatelessWidget {
  final bool online;
  final String name;
  final int age;
  final void Function(int) onStarsPressed;
  final void Function() seeMore;

  const SmallCard({
    Key key,
    @required this.online,
    @required this.name,
    @required this.age,
    @required this.onStarsPressed,
    @required this.seeMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: online
                ? Icon(Icons.verified_user)
                : Icon(Icons.signal_wifi_off),
            title: Text(name),
            subtitle: Text('$age ${age == 1 ? 'year' : 'years'} old'),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('1 STAR'),
                onPressed: () {
                  onStarsPressed(1);
                  // logLike('1');
                },
              ),
              FlatButton(
                child: const Text('2 STARS'),
                onPressed: () {
                  onStarsPressed(2);
                },
              ),
              FlatButton(
                child: const Text('SEE MORE'),
                onPressed: seeMore,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
