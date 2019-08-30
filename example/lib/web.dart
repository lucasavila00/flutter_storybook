import 'package:flutter/material.dart';
import 'package:flutter_storybook/flutter_storybook.dart';
import 'package:flutter_storybook_example/stories.dart';

void main() async {
  runApp(
    StoryApp(
      // If you need a different viewport
      // viewports: <StoryViewport>[
      //   ...defaultViewports,
      // ],
      stories: [
        SmallCardStory(),
        BigCardStory(),
      ],
    ),
  );
}
