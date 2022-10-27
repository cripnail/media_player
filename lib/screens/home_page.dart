import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../widgets/custom_controls_widget.dart';
import '../widgets/progress_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;
  late final List<Duration> timestamps;

  @override
  initState() {
    super.initState();
    // _controller = VideoPlayerController.asset('assets/Butterfly-209.mp4/');
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      closedCaptionFile: _loadCaptions(),
    );
    _controller.addListener(() {
      setState() {}
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: 200,
        child: Stack(
          children: <Widget>[
            VideoPlayer(_controller),
            ClosedCaption(
              text: _controller.value.caption.text,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: VideoProgressIndicator(_controller, allowScrubbing: true),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _controller.pause();
                            },
                            icon: const Icon(Icons.pause),
                          ),
                          IconButton(
                            onPressed: () {
                              _controller.play();
                            },
                            icon: const Icon(Icons.play_arrow),
                          ),
                          const SizedBox(width: 22),
                          CustomControlsWidget(
                            controller: _controller,
                            timestamps: timestamps,
                          ),
                        ],
                      ),
                      Expanded(child: progressSlider()),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('assets/bumble_bee_caption.vtt');
    return WebVTTCaptionFile(fileContents);
  }
}
