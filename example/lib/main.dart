import 'package:flutter/material.dart';
import 'package:flutter_storybook_example/small_card.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Storybook',
      home: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return SmallCard(
            online: false,
            name: 'Jhon',
            age: 55,
            onStarsPressed: (int stars) => {},
            seeMore: () {},
          );
        }),
      ),
    ),
  );
}
