import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_storybook/flutter_storybook.dart';
import 'package:flutter_storybook_example/stories.dart';

void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

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
