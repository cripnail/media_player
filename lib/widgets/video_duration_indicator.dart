import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDurationIndicator extends StatefulWidget {
  const VideoDurationIndicator({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  VideoDurationIndicatorState createState() => VideoDurationIndicatorState();
}

class VideoDurationIndicatorState extends State<VideoDurationIndicator> {
  late Duration totalDuration;

  Duration? currentPosition;
  Timer? currentPositionTimer;

  @override
  void initState() {
    super.initState();

    totalDuration = widget.controller.value.duration;
    currentPositionTimer =
        Timer(const Duration(seconds: 1), getCurrentPosition);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? theme = Theme.of(context).textTheme.caption?.copyWith(
          color: Colors.white,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currentPosition.toString().split('.')[0],
          style: theme,
        ),
        Text(
          totalDuration.toString().split('.')[0],
          style: theme,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    currentPositionTimer?.cancel();
  }

  void getCurrentPosition() {
    setState(() => currentPosition = widget.controller.value.position);
    currentPositionTimer =
        Timer(const Duration(seconds: 1), getCurrentPosition);
  }
}
