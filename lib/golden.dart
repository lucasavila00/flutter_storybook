import 'package:flutter/widgets.dart';
import 'package:flutter_storybook/app.dart';
import 'package:flutter_storybook/context.dart';
import 'package:flutter_storybook/tab_renderer.dart';
import 'package:flutter_storybook/types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

Future<void> loadDefaultGoldenFonts() async {
  final fontDataRoboto = File('fonts/Roboto/Roboto-Regular.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));

  final FontLoader fontLoader = FontLoader('Roboto')..addFont(fontDataRoboto);
  await fontLoader.load();

  final fontDataSF = File('fonts/SF/SF-UI-Text-Regular.otf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final FontLoader fontLoaderSf = FontLoader('.SF UI Text')
    ..addFont(fontDataSF);
  await fontLoaderSf.load();

  final fontDataSF2 = File('fonts/SF/SF-UI-Display-Regular.otf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final FontLoader fontLoaderSf2 = FontLoader('.SF UI Display')
    ..addFont(fontDataSF2);
  await fontLoaderSf2.load();

  final fontDataIcons = File('fonts/MaterialIcons-Regular.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final FontLoader fontLoaderIcons = FontLoader('MaterialIcons')
    ..addFont(fontDataIcons);
  await fontLoaderIcons.load();
}

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

void goldenStories(
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
            outDir: 'golden/${vp.name}',
            customContainerBuilder: _showcaseBuilder(
              viewport: vp,
            ),
          );
        },
      );
    },
  );
}

// from https://github.com/comigor/showcase
typedef ContainerBuilder = Container Function(Widget child);

/// Use [GoldenBoundary] to wrap a [Widget] and be able to find its
/// [RenderObject] from a [GlobalKey].
class GoldenBoundary extends StatelessWidget {
  /// Default constructor. Use [customContainerBuilder] if you want to customize
  /// the wrapping container.
  const GoldenBoundary({
    @required this.child,
    this.globalKey,
    this.size,
    this.customContainerBuilder,
  }) : assert(size != null || customContainerBuilder != null,
            'At least one of [size] or [customContainerBuilder] is required.');

  /// The widget to be wrapped.
  final Widget child;

  /// A custom key to find this widget later.
  final GlobalKey globalKey;

  /// A function to customize the wrapping container.
  final ContainerBuilder customContainerBuilder;

  /// The size of the wrapping container.
  final Size size;

  Widget _defaultContainerBuilder(Widget child) => Container(
        padding: const EdgeInsets.all(10.0),
        width: size != null ? size.width : 640.0,
        height: size != null ? size.height : 640.0,
        child: child,
      );

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: RepaintBoundary(
            key: globalKey,
            child: customContainerBuilder != null
                ? customContainerBuilder(child)
                : _defaultContainerBuilder(child),
          ),
        ),
      );
}

Future<void> _makeTest(Widget widget, int index,
    {ContainerBuilder customContainerBuilder, Size size, String outDir}) async {
  final String strIndex = index.toString().padLeft(3, '0');
  testWidgets('[$strIndex] Showcasing ${widget.toString()}',
      (WidgetTester tester) async {
    final GlobalKey key = GlobalKey();

    await tester.pumpWidget(GoldenBoundary(
      globalKey: key,
      child: widget,
      size: size,
      customContainerBuilder: customContainerBuilder,
    ));

    await expectLater(
        find.byType(GoldenBoundary),
        matchesGoldenFile(
            '${outDir ?? 'showcase'}/${strIndex}_${widget.toString()}.png'));
  });
}

/// Use this function to generate screenshots of your widgets. See optional
/// parameters for custom configurations.
void showcaseWidgets(List<Widget> widgets,
    {ContainerBuilder customContainerBuilder, Size size, String outDir}) {
  widgets.asMap().forEach((int index, Widget widget) => _makeTest(
        widget,
        index,
        customContainerBuilder: customContainerBuilder,
        size: size,
        outDir: outDir,
      ));
}
