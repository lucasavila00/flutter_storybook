import 'package:flutter_storybook/flutter_storybook.dart';
import 'package:flutter_storybook_example/stories.dart';

void main() async {
  await loadDefaultGoldenFonts();
  goldenStories(
    [
      SmallCardStory(),
      BigCardStory(),
    ],
  );
}
