import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AnimeVideoComponent extends StatefulWidget {
  final String videoId;
  final double per;
  const AnimeVideoComponent(
      {required this.per, required this.videoId, super.key});

  @override
  State<AnimeVideoComponent> createState() => Anime_VideoComponentState();
}

class Anime_VideoComponentState extends State<AnimeVideoComponent> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  late Chewie _playerWidget;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: false,
          looping: false,
          materialProgressColors: ChewieProgressColors(
            playedColor: Utils.primaryColor,
            handleColor: Utils.primaryColor,
          ),
          optionsTranslation: OptionsTranslation(
            playbackSpeedButtonText: 'Tốc độ phát',
            subtitlesButtonText: 'Phụ đề',
            cancelButtonText: 'Hủy',
          ),
          // subtitle: Subtitles([
          //   Subtitle(
          //     index: 0,
          //     start: Duration.zero,
          //     end: const Duration(seconds: 10),
          //     text: 'Hello from subtitles',
          //   ),
          //   Subtitle(
          //     index: 1,
          //     start: const Duration(seconds: 10),
          //     end: const Duration(seconds: 20),
          //     text: 'Whats up? :)',
          //   ),
          // ]),
          // subtitleBuilder: (context, subtitle) => Container(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Text(
          //     subtitle,
          //     style: const TextStyle(color: Colors.red, fontSize: 30),
          //   ),
          // ),
        );
        _playerWidget = Chewie(controller: _chewieController);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widget.per > 186
          ? MediaQuery.of(context).size.width * widget.per
          : 186,
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: _playerWidget,
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
