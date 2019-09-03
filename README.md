# flutter_storybook

Storybooks for Flutter.

Run on macOS for fast development or the web to share results.

Easily have golden tests for all your stories.

Early development.

## Getting Started

- Install 'flutter_storybook'
  TODO: how to install

- Create another target file

```dart
// lib/stories.dart

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_storybook/flutter_storybook.dart';

void main() {
  // Only needed for macOS
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(
    // Use StoryApp, a MaterialApp wrapper
    StoryApp(
      stories: [
        SmallCardStory(),
      ],
    ),
  );
}


// Extend StoryBase to be able to use the hooks
// and have the type checker make sure name is implemented.
class SmallCardStory extends StoryBase {
  // This is the unique id and display text of this story
  @override
  String get name => 'Small Card';

  @override
  Widget build(BuildContext context) {
    // only bool, int and String knobs are supported
    final bool online = useKnob(false, 'Online');
    final int age = useKnob(55, 'Age');
    final String name = useKnob('Jhon', 'Name');

    // use action will log it to the actions pannel
    final void Function(String) logStars = useAction('Gave Star');

    // go to another story
    final void Function() goToMore = useStory('Big Card');

    // Remember to return a StoryPage
    return StoryPage(
      builder: (BuildContext context) =>
        // SmallCard is any custom widget
        SmallCard(
          online: online,
          age: age,
          name: name,
          onStarsPressed: (int stars) => logStars('$stars'),
          seeMore: goToMore,
        ),
    );
  }
}

```

- Run it

#### macOS

\$ flutter run -d macOS -t lib/stories.dart

#### web

\$ flutter run -d chrome -t lib/stories.dart


# Golden Tests

```dart
// lib/golden.dart
import 'package:flutter_storybook/flutter_storybook.dart';

void main() async {
  await loadDefaultGoldenFonts();
  goldenStories(
    stories: [
      SmallCardStory(),
    ],
  );
}
```

## Run it
$  flutter test lib/golden.dart 