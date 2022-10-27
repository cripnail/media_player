import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomControlsWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final List<Duration> timestamps;

  const CustomControlsWidget({
    required this.controller,
    required this.timestamps,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildButton(const Icon(Icons.fast_rewind), rewindToPosition),
      const SizedBox(width: 12),
      buildButton(const Icon(Icons.replay_10), rewind10Seconds),
      const SizedBox(width: 12),
      buildButton(const Icon(Icons.forward_10), forward10Seconds),
      const SizedBox(width: 12),
      buildButton(const Icon(Icons.fast_forward), forwardToPosition),
    ],
  );

  Widget buildButton(Widget child, void Function()? onPressed) => SizedBox(
        height: 50,
        width: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.1),
          ),
          child: child,
        ),
      );

  Future rewindToPosition() async {
    if (timestamps.isEmpty) return;
    Duration rewind(Duration currentPosition) => timestamps.lastWhere(
          (element) => currentPosition > element + const Duration(seconds: 2),
          orElse: () => Duration.zero,
        );

    await goToPosition(rewind);
  }

  Future forwardToPosition() async {
    if (timestamps.isEmpty) return;
    Duration forward(Duration currentPosition) => timestamps.firstWhere(
          (position) => currentPosition < position,
          orElse: () => const Duration(days: 1),
        );

    await goToPosition(forward);
  }

  Future forward10Seconds() async =>
      goToPosition((currentPosition) => currentPosition + const Duration(seconds: 5));

  Future rewind10Seconds() async =>
      goToPosition((currentPosition) => currentPosition - const Duration(seconds: 5));

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await controller.position;
    final newPosition = builder(currentPosition!);

    await controller.seekTo(newPosition);
  }
}
