import 'package:anime_and_comic_entertainment/components/animes/VideoComponent.dart';
import 'package:anime_and_comic_entertainment/components/ui/AdTiming.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class WatchAnimePage extends StatefulWidget {
  final String? videoId;
  final double height;
  final double percent;
  final double maxHeight;
  const WatchAnimePage(
      {required this.videoId,
      required this.percent,
      required this.height,
      required this.maxHeight,
      super.key});

  @override
  State<WatchAnimePage> createState() => _WatchAnimePageState();
}

class _WatchAnimePageState extends State<WatchAnimePage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  late Chewie _playerWidget;
  late VideoPlayerController _controllerAd;
  late ChewieController _chewieControllerAd;
  late Chewie _playerWidgetAd;

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
    _controllerAd = VideoPlayerController.networkUrl(Uri.parse(widget.videoId ==
            'asss'
        ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
        : 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        _chewieControllerAd = ChewieController(
            videoPlayerController: _controllerAd,
            autoPlay: false,
            looping: false,
            showControls: false);
        _playerWidgetAd = Chewie(controller: _chewieControllerAd);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<MiniPlayerControllerProvider>(context, listen: false)
            .setMiniController(PanelState.MAX);
      },
      child: Container(
        color: const Color(0xFF141414),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Stack(children: [
                // anime video player
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * widget.percent > 186
                          ? MediaQuery.of(context).size.width * widget.percent
                          : 186,
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: _playerWidget,
                        )
                      : Container(),
                ),
                // ad video player
                ValueListenableBuilder(
                  valueListenable: _controllerAd,
                  builder: (context, value, child) {
                    return !value.isCompleted
                        ? Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                              widget.percent >
                                          186
                                      ? MediaQuery.of(context).size.width *
                                          widget.percent
                                      : 186,
                                  child: _controllerAd.value.isInitialized
                                      ? AspectRatio(
                                          aspectRatio:
                                              _controllerAd.value.aspectRatio,
                                          child: Container(
                                            color: const Color(0xFF141414),
                                          ),
                                        )
                                      : AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: GFLoader(
                                                  type: GFLoaderType.circle),
                                            ),
                                          ),
                                        )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                            widget.percent >
                                        186
                                    ? MediaQuery.of(context).size.width *
                                        widget.percent
                                    : 186,
                                child: _controllerAd.value.isInitialized
                                    ? AspectRatio(
                                        aspectRatio:
                                            _controllerAd.value.aspectRatio,
                                        child: _playerWidgetAd,
                                      )
                                    : Container(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                child: AdTiming(
                                    content:
                                        'Quảng cáo: ${(value.position.inSeconds)}.0/${value.duration.inSeconds}.0s'),
                              )
                            ],
                          )
                        : Container();
                  },
                ),
              ]),
              widget.percent == 0
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 186 - 56,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Vì sợ đau nên tôi nâng hết phòng thủ",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Tập 12 - Cánh hoa hoàng hôn",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              widget.percent == 0
                  ? IconButton(
                      color: Colors.white,
                      onPressed: () {
                        Provider.of<VideoProvider>(context, listen: false)
                            .setAnime(Animes());
                      },
                      icon: const Icon(Icons.close))
                  : Container()
            ]),
          ]),
          widget.percent == 0
              ? ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value.duration.inSeconds == 0
                          ? 0.0
                          : value.position.inSeconds / value.duration.inSeconds,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Utils.primaryColor),
                    );
                  },
                )
              : Container(),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
