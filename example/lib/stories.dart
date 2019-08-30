import 'package:flutter/material.dart';
import 'package:flutter_storybook/flutter_storybook.dart';
import 'package:flutter_storybook_example/small_card.dart';

class SmallCardStory extends StoryBase {
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

    return StoryPage(
      builder: (BuildContext context) => SmallCard(
        online: online,
        age: age,
        name: name,
        onStarsPressed: (int stars) => logStars('$stars'),
        seeMore: goToMore,
      ),
    );
  }
}

class BigCardStory extends StoryBase {
  @override
  String get name => 'Big Card';

  @override
  Widget build(BuildContext context) {
    return StoryPage(
      // If you need a different viewport just for this story
      // viewports: <StoryViewport>[
      //   ...defaultViewports,
      // ],
      builder: (BuildContext context) {
        return Container(
          child: Text('Big card...'),
        );
      },
    );
  }
}
