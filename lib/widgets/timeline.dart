import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class MyTimeline extends StatefulWidget {
  const MyTimeline({super.key});

  @override
  State<MyTimeline> createState() => _MyTimelineState();
}

class _MyTimelineState extends State<MyTimeline> {
  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
    builder: TimelineTileBuilder.fromStyle(
      contentsAlign: ContentsAlign.alternating,
      contentsBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text('Timeline Event $index'),
      ),
      itemCount: 10,
    ),
  );
  }
}