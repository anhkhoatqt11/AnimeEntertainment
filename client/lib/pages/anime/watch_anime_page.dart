import 'package:anime_and_comic_entertainment/components/animes/CommentComponent.dart';
import 'package:anime_and_comic_entertainment/components/animes/VideoComponent.dart';
import 'package:anime_and_comic_entertainment/components/ui/AdTiming.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
    List<int> listEpisode = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
    List<String> listGenre = ['Giả tưởng', 'Học đường'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Color(0xFF141414),
          body: Column(children: [
            GestureDetector(
              onTap: () {
                Provider.of<MiniPlayerControllerProvider>(context,
                        listen: false)
                    .setMiniController(PanelState.MAX);
              },
              child: Container(
                color: const Color(0xFF141414),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Stack(children: [
                                // anime video player
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                              widget.percent >
                                          186
                                      ? MediaQuery.of(context).size.width *
                                          widget.percent
                                      : 186,
                                  child: _controller.value.isInitialized
                                      ? AspectRatio(
                                          aspectRatio:
                                              _controller.value.aspectRatio,
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
                                            alignment: AlignmentDirectional
                                                .bottomStart,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              widget.percent >
                                                          186
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          widget.percent
                                                      : 186,
                                                  child: _controllerAd
                                                          .value.isInitialized
                                                      ? AspectRatio(
                                                          aspectRatio:
                                                              _controllerAd
                                                                  .value
                                                                  .aspectRatio,
                                                          child: Container(
                                                            color: const Color(
                                                                0xFF141414),
                                                          ),
                                                        )
                                                      : AspectRatio(
                                                          aspectRatio: 16 / 9,
                                                          child: Container(
                                                            color: Colors
                                                                .grey[300],
                                                            child: const Center(
                                                              child: GFLoader(
                                                                  type: GFLoaderType
                                                                      .circle),
                                                            ),
                                                          ),
                                                        )),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            widget.percent >
                                                        186
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        widget.percent
                                                    : 186,
                                                child: _controllerAd
                                                        .value.isInitialized
                                                    ? AspectRatio(
                                                        aspectRatio:
                                                            _controllerAd.value
                                                                .aspectRatio,
                                                        child: _playerWidgetAd,
                                                      )
                                                    : Container(),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 0, 10),
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
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                186 -
                                                56,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  color: Colors.grey[400],
                                                  fontSize: 13),
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
                                        Provider.of<VideoProvider>(context,
                                                listen: false)
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
                                      : value.position.inSeconds /
                                          value.duration.inSeconds,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Utils.primaryColor),
                                );
                              },
                            )
                          : Container(),
                    ]),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) => LinearGradient(
                                    colors: Utils.gradientColors,
                                    begin: Alignment.centerLeft,
                                    stops: [0, 0.4],
                                    end: Alignment.centerRight)
                                .createShader(rect),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.youtube,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Năng lực lop hoc hoang gia",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Tap 12 - Buoi lien hoan vui nhon va nguoi ban tho au oi cung nhau di choi nhe",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(children: [
                                  FaIcon(
                                    FontAwesomeIcons.solidThumbsUp,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Thích",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ]),
                                Column(children: [
                                  FaIcon(
                                    FontAwesomeIcons.solidBookmark,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Lưu phim",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ]),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                "Dành cho độ tuổi: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Flexible(
                                child: Text("13+",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Utils.accentColor,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Thể loại: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Expanded(
                                child: Wrap(
                                    spacing: 2,
                                    children: List.generate(
                                      listGenre.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          print(listGenre[index]);
                                        },
                                        child: Text(
                                            listGenre[index] +
                                                (index == listGenre.length - 1
                                                    ? ""
                                                    : ", "),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Utils.primaryColor,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Phát sóng: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Flexible(
                                child: Text("Thứ 4 hàng tuần",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Nhà phát hành: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Flexible(
                                child: Text("MuseVN",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                        dividerColor: Colors.grey,
                        dividerHeight: .2,
                        labelColor: Utils.primaryColor,
                        indicatorColor: Utils.primaryColor,
                        tabs: [
                          Tab(
                            text: "Danh sách tập",
                          ),
                          Tab(
                            text: "Bình luận",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      height: listEpisode.length * 88,
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Column(
                                children:
                                    List.generate(listEpisode.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      height: 80,
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://www.shutterstock.com/image-vector/anime-girl-kindhearted-spirit-befriends-600nw-2323507949.jpg",
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 125,
                                            color: Colors.blue,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: Container(
                                                width: 125,
                                                color: Colors.yellow,
                                              ),
                                            ),
                                          ),
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill)),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                          height: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Tập 24 - Ngày anhs sáng thiên thần hoàng gia thiên la hoàng gia thiên la thiên la hoàng gia thiên la",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.clock,
                                                        color: Colors.grey,
                                                        size: 12,
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        "66:99",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                  ShaderMask(
                                                      shaderCallback: (rect) =>
                                                          LinearGradient(
                                                            colors: Utils
                                                                .gradientColors,
                                                            begin: Alignment
                                                                .topCenter,
                                                          ).createShader(rect),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidBookmark,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ))
                                                ],
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              );
                            })),
                          ),
                          CommentComponent(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
