import 'package:flutter/material.dart';
import 'package:flutter_storybook/flutter_storybook.dart';
import 'package:flutter_storybook_example/stories.dart';

void main() async {
  runApp(
    StoryApp(
      // If you need a different viewport
      // viewports: <StoryViewport>[
      //   ...defaultViewports,
      //   StoryViewport(
      //     name: 'Ipad 2',
      //     width: 768,
      //     height: 1024,
      //     orientation: Orientation.portrait,
      //     platform: TargetPlatform.iOS,
      //   )
      // ],
      stories: [
        SmallCardStory(),
        BigCardStory(),
      ],
    ),
  );
}
