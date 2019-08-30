import 'package:flutter/material.dart';
import 'package:flutter_storybook/types.dart';

import 'actions.dart';
import 'context.dart';
import 'knobs.dart';
import 'tab_renderer.dart';

class StoryPage extends StatelessWidget {
  StoryPage({
    Key key,
    @required this.builder,
    this.viewports,
  }) : super(key: key);
  final List<StoryViewport> viewports;
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: (viewports ?? StoryContext.of(context).appViewports).length,
      child: Scaffold(
        primary: true,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: StoryContext.of(context).routeNames.map((n) {
              return ListTile(
                title: Text(n),
                onTap: () {
                  Navigator.of(context).pushNamed(n);
                },
              );
            }).toList(),
          ),
        ),
        appBar: AppBar(
          title: Text(
            StoryContext.of(context).name,
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: (viewports ?? StoryContext.of(context).appViewports).map((v) {
              return Tab(
                text: v.name,
              );
            }).toList(),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TabBarView(
                  children: (viewports ?? StoryContext.of(context).appViewports)
                      .map((v) {
                    return TabRenderer(
                      viewport: v,
                      childBuilder: builder,
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: KnobsRenderer(
                    height: MediaQuery.of(context).size.height / 6,
                    knobs: StoryContext.of(context).knobs,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ActionsRenderer(
                    height: MediaQuery.of(context).size.height / 6,
                    actions: StoryContext.of(context).actionsController.stream,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
