import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_storybook/flutter_storybook.dart';
import 'package:flutter_storybook_example/stories.dart';

void main() async {
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

  final fontDataIcons = File('fonts/MaterialIcons-Regular.ttf')
      .readAsBytes()
      .then((bytes) => ByteData.view(Uint8List.fromList(bytes).buffer));
  final FontLoader fontLoaderIcons = FontLoader('MaterialIcons')
    ..addFont(fontDataIcons);
  await fontLoaderIcons.load();

  showcaseStories([
    SmallCardStory(),
    BigCardStory(),
  ]);
}
