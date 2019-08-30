import 'package:flutter/material.dart';
import 'package:flutter_storybook_example/small_card.dart';

void main() {
  // This runs only the 'real' component.
  // Used to debug differences between web, macOS and ground truth.
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
