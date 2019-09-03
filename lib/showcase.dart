import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_storybook/app.dart';
import 'package:flutter_storybook/context.dart';
import 'package:flutter_storybook/tab_renderer.dart';
import 'package:flutter_storybook/types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:showcase/showcase.dart';

Container Function(Viewport) _showcaseBuilder({
  @required StoryViewport viewport,
}) =>
    (
      Widget child,
    ) =>
        Container(
          child: StoryContext(
            showcase: true,
            actionsController: null,
            routeNames: [],
            name: '',
            appViewports: [],
            child: ViewportSizer(
              childBuilder: (BuildContext context) => child,
              viewport: viewport,
            ),
          ),
        );

void showcaseStories(
  List<StoryBase> stories, {
  List<StoryViewport> viewports,
}) {
  (viewports ?? defaultViewports).forEach(
    (vp) {
      group(
        'Showcase of ${vp.name}',
        () {
          showcaseWidgets(
            stories,
            outDir: 'showcase/${vp.name}',
            customContainerBuilder: _showcaseBuilder(
              viewport: vp,
            ),
          );
        },
      );
    },
  );
}
