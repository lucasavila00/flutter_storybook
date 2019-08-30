import 'package:flutter/material.dart';
import 'package:flutter_storybook_example/small_card.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'The component for real',
      home: Scaffold(
        body: SmallCard(
          online: false,
          name: 'Jhon',
          age: 55,
          onStarsPressed: (int stars) => {},
          seeMore: () {},
        ),
      ),
    ),
  );
}
