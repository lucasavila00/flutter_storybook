import 'package:flutter/material.dart';

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

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
    // printWrapped(Theme.of(context).typography.toString());
    printWrapped(MediaQuery.of(context).toString());
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
