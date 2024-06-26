import 'package:anime_and_comic_entertainment/components/animes/CommentComponent.dart';
import 'package:anime_and_comic_entertainment/components/animes/SuggestionByView.dart';
import 'package:anime_and_comic_entertainment/components/ui/AdTiming.dart';
import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_comment.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchAnimePage extends StatefulWidget {
  final String? videoId;
  final String? animeId;
  final double height;
  final double percent;
  final double maxHeight;
  const WatchAnimePage(
      {required this.videoId,
      required this.animeId,
      required this.percent,
      required this.height,
      required this.maxHeight,
      super.key});

  @override
  State<WatchAnimePage> createState() => _WatchAnimePageState();
}

class _WatchAnimePageState extends State<WatchAnimePage>
    with SingleTickerProviderStateMixin {
  // define component
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  late Chewie _playerWidget;
  VideoPlayerController? _controllerAd;
  ChewieController? _chewieControllerAd;
  late Chewie _playerWidgetAd;
  late TabController _tabController;

  // define data
  late int _tabIndex = 0;
  late Animes detailAnime = Animes();
  late bool isLoadingAnimeDetail = true;
  late bool isLoadingEpisodeDetail = true;
  late bool completeInitAd = false;
  late bool completeInitContent = false;
  late AnimeEpisodes detailAnimeEpisode = AnimeEpisodes();
  late List<int> bufferWatchRecord = [];
  late bool viewDone = false;
  late bool isLogedIn = false;
  late String userId = "";
  late int positionInit = 0;

  Future<void> _launchUrl(String urlAd) async {
    if (!await launchUrl(Uri.parse(urlAd))) {
      throw Exception('Could not launch ${Uri.parse(urlAd)}');
    }
  }

  Future<void> handlePush(int value) async {
    if (bufferWatchRecord.length == 2) {
      if (viewDone == false) {
        viewDone = !viewDone;
        AnimesApi.updateEpisodeView(context, widget.videoId);
        if (Provider.of<UserProvider>(context, listen: false)
                .user
                .authentication['sessionToken'] !=
            "") {
          Provider.of<UserProvider>(context, listen: false).setWatchingTime(1);
          await DailyQuestsApi.updateQuestLog(context, "");
        }
      }
      ;
      return;
    }
    if (bufferWatchRecord.isNotEmpty && bufferWatchRecord.last != value - 1) {
      if (bufferWatchRecord.last != value) {
        bufferWatchRecord.clear();
        bufferWatchRecord.add(value);
      }
    } else {
      bufferWatchRecord.add(value);
    }
  }

  Future<Animes> getAnimeDetailInEpisodePageById() async {
    var result = await AnimesApi.getAnimeDetailInEpisodePageById(
        context, widget.animeId);
    return result;
  }

  Future<void> checkUserHistoryHadSeenEpisode() async {
    userId = Provider.of<UserProvider>(context, listen: false).user.id;
    if (userId == "") return;
    positionInit = await AnimesApi.checkUserHistoryHadSeenEpisode(
        context, widget.videoId, userId);
    return;
  }

  Future<AnimeEpisodes> getAnimeEpisodeDetailById() async {
    var result =
        await AnimesApi.getAnimeEpisodeDetailById(context, widget.videoId);
    return result;
  }

  void checkUserHasLikeOrSaveAndWatchEpisode() async {
    userId = Provider.of<UserProvider>(context, listen: false).user.id;
    if (userId == "") return;
    isLogedIn = true;
    Provider.of<VideoProvider>(context, listen: false)
        .setLikeSave(userId, context);
  }

  _handleTabSelection() {
    setState(() {
      _tabIndex = _tabController.index;
    });
  }

  _handleVideoPlaying() {
    handlePush(_controller!.value.position.inSeconds);
  }

  @override
  void initState() {
    super.initState();
    FirebaseApi().listenEvent(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _handleTabSelection();
    });
    checkUserHasLikeOrSaveAndWatchEpisode();
    checkUserHistoryHadSeenEpisode().then((value) {
      getAnimeEpisodeDetailById().then((value) {
        setState(() {
          detailAnimeEpisode = value;
          isLoadingEpisodeDetail = false;
        });
        getAnimeDetailInEpisodePageById().then((value) => setState(() {
              detailAnime = value;
              isLoadingAnimeDetail = false;
            }));

        _controller =
            VideoPlayerController.networkUrl(Uri.parse(value.content!))
              ..initialize().then((_) {
                // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                _chewieController = ChewieController(
                  videoPlayerController: _controller!,
                  autoPlay: false,
                  looping: false,
                  startAt: Duration(seconds: positionInit),
                  materialProgressColors: ChewieProgressColors(
                    playedColor: Utils.primaryColor,
                    handleColor: Utils.primaryColor,
                  ),
                  optionsTranslation: OptionsTranslation(
                    playbackSpeedButtonText: 'Tốc độ phát',
                    subtitlesButtonText: 'Phụ đề',
                    cancelButtonText: 'Hủy',
                  ),
                );
                _playerWidget = Chewie(controller: _chewieController!);
                _controller!.addListener(() {
                  _handleVideoPlaying();
                });
                setState(() {
                  completeInitContent = true;
                });
              });
        if (value.advertising! != "") {
          _controllerAd =
              VideoPlayerController.networkUrl(Uri.parse(value.advertising!))
                ..initialize().then((_) {
                  _chewieControllerAd = ChewieController(
                      videoPlayerController: _controllerAd!,
                      autoPlay: true,
                      looping: false,
                      startAt: Duration(seconds: 10),
                      showControls: false);
                  _playerWidgetAd = Chewie(controller: _chewieControllerAd!);
                  setState(() {
                    completeInitAd = true;
                  });
                });
        } else {
          _controllerAd = null;
          completeInitAd = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: () {
              Provider.of<MiniPlayerControllerProvider>(context, listen: false)
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
                                child: completeInitContent
                                    ? AspectRatio(
                                        aspectRatio:
                                            _controller!.value.aspectRatio,
                                        child: _playerWidget,
                                      )
                                    : AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Container(
                                          color: Colors.grey.withOpacity(0.4),
                                          child: const Center(
                                            child: GFLoader(
                                                type: GFLoaderType.circle),
                                          ),
                                        ),
                                      ),
                              ),
                              // ad video player
                              completeInitAd && _controllerAd != null
                                  ? ValueListenableBuilder(
                                      valueListenable: _controllerAd!,
                                      builder: (context, value, child) {
                                        return !value.isCompleted
                                            ? Stack(
                                                alignment: AlignmentDirectional
                                                    .bottomStart,
                                                children: [
                                                  SizedBox(
                                                      width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  widget
                                                                      .percent >
                                                              186
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              widget.percent
                                                          : 186,
                                                      child: AspectRatio(
                                                        aspectRatio:
                                                            _controllerAd!.value
                                                                .aspectRatio,
                                                        child: Container(
                                                          color: const Color(
                                                              0xFF141414),
                                                        ),
                                                      )),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _launchUrl(
                                                          detailAnimeEpisode
                                                              .adLink!);
                                                    },
                                                    child: SizedBox(
                                                      width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  widget
                                                                      .percent >
                                                              186
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              widget.percent
                                                          : 186,
                                                      child: _controllerAd!
                                                              .value
                                                              .isInitialized
                                                          ? AspectRatio(
                                                              aspectRatio:
                                                                  _controllerAd!
                                                                      .value
                                                                      .aspectRatio,
                                                              child:
                                                                  _playerWidgetAd,
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 10),
                                                    child: Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (_controllerAd!
                                                                .value
                                                                .isPlaying) {
                                                              _controllerAd!
                                                                  .pause();
                                                            } else {
                                                              _controllerAd!
                                                                  .play();
                                                            }
                                                          },
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.4),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            360)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      4,
                                                                      2,
                                                                      0,
                                                                      0),
                                                              child: Center(
                                                                  child: ShaderMask(
                                                                      shaderCallback: (rect) => LinearGradient(
                                                                            colors:
                                                                                Utils.gradientColors,
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                          ).createShader(rect),
                                                                      child: FaIcon(
                                                                        _controllerAd!.value.isPlaying
                                                                            ? FontAwesomeIcons.pause
                                                                            : FontAwesomeIcons.play,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            18,
                                                                      ))),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        AdTiming(
                                                            content:
                                                                'Quảng cáo: ${(value.position.inSeconds)}.0/${value.duration.inSeconds}.0s'),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            : const SizedBox.shrink();
                                      },
                                    )
                                  : !completeInitAd
                                      ? SizedBox(
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
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Container(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              child: const Center(
                                                child: GFLoader(
                                                    type: GFLoaderType.circle),
                                              ),
                                            ),
                                          ))
                                      : const SizedBox.shrink(),
                            ]),
                            widget.percent == 0
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          186 -
                                          56,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isLoadingAnimeDetail
                                                ? "Đang tải"
                                                : detailAnime.movieName!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            isLoadingEpisodeDetail
                                                ? "Đang tải"
                                                : detailAnimeEpisode
                                                    .episodeName!,
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
                                : const SizedBox.shrink(),
                            widget.percent == 0
                                ? IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Provider.of<VideoProvider>(context,
                                              listen: false)
                                          .setAnime(Animes(), AnimeEpisodes());
                                    },
                                    icon: const Icon(Icons.close))
                                : const SizedBox.shrink()
                          ]),
                        ]),
                    widget.percent == 0 && completeInitContent
                        ? ValueListenableBuilder(
                            valueListenable: _controller!,
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
                        : const SizedBox.shrink(),
                  ]),
            ),
          ),
          isLoadingAnimeDetail == true || isLoadingEpisodeDetail == true
              ? const Expanded(
                  child: Center(
                    child: GFLoader(type: GFLoaderType.circle),
                  ),
                )
              : Expanded(
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (rect) => LinearGradient(
                                        colors: Utils.gradientColors,
                                        begin: Alignment.centerLeft,
                                        stops: const [0, 0.4],
                                        end: Alignment.centerRight)
                                    .createShader(rect),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.youtube,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        detailAnime.movieName!,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                detailAnimeEpisode.episodeName!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Consumer(
                                builder: (BuildContext context, value,
                                    Widget? child) {
                                  final hadLiked =
                                      Provider.of<VideoProvider>(context)
                                          .hadLiked;
                                  final hadSaved =
                                      Provider.of<VideoProvider>(context)
                                          .hadSaved;
                                  return Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (Provider.of<UserProvider>(
                                                            context,
                                                            listen: false)
                                                        .user
                                                        .authentication[
                                                    'sessionToken'] !=
                                                "") {
                                              AnimesApi.updateUserLikeEpisode(
                                                  context,
                                                  widget.videoId,
                                                  Provider.of<UserProvider>(
                                                          context,
                                                          listen: false)
                                                      .user
                                                      .id);
                                              setState(
                                                () {
                                                  Provider.of<VideoProvider>(
                                                          context,
                                                          listen: false)
                                                      .setLiked();
                                                },
                                              );
                                            } else {
                                              _controllerAd!.pause();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Login()));
                                            }
                                          },
                                          child: Column(children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidThumbsUp,
                                              color: hadLiked
                                                  ? Utils.primaryColor
                                                  : Colors.grey,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "Thích",
                                              style: TextStyle(
                                                  color: hadLiked
                                                      ? Utils.primaryColor
                                                      : Colors.grey,
                                                  fontSize: 12),
                                            )
                                          ]),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (Provider.of<UserProvider>(
                                                            context,
                                                            listen: false)
                                                        .user
                                                        .authentication[
                                                    'sessionToken'] !=
                                                "") {
                                              AnimesApi.updateUserSaveEpisode(
                                                  context,
                                                  widget.videoId,
                                                  Provider.of<UserProvider>(
                                                          context,
                                                          listen: false)
                                                      .user
                                                      .id);
                                              setState(
                                                () {
                                                  Provider.of<VideoProvider>(
                                                          context,
                                                          listen: false)
                                                      .setSaved();
                                                },
                                              );
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Login()));
                                            }
                                          },
                                          child: Column(children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidBookmark,
                                              color: hadSaved
                                                  ? Utils.accentColor
                                                  : Colors.grey,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "Lưu phim",
                                              style: TextStyle(
                                                  color: hadSaved
                                                      ? Utils.accentColor
                                                      : Colors.grey,
                                                  fontSize: 12),
                                            )
                                          ]),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComicChapterComment(
                                                          sourceId:
                                                              detailAnimeEpisode
                                                                  .id!,
                                                          type: "episode"),
                                                ));
                                          },
                                          child: const Column(children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidMessage,
                                              color: Colors.grey,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "Bình luận",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            )
                                          ]),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Dành cho độ tuổi: ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Flexible(
                                    child: Text(detailAnime.ageFor!,
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
                                  const Text(
                                    "Thể loại: ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Expanded(
                                    child: Wrap(
                                        spacing: 2,
                                        children: List.generate(
                                          detailAnime.genres!.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              print(detailAnime.genres![index]
                                                  ['genreName']);
                                            },
                                            child: Text(
                                                detailAnime.genres![index]
                                                        ['genreName'] +
                                                    (index ==
                                                            detailAnime.genres!
                                                                    .length -
                                                                1
                                                        ? ""
                                                        : ", "),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Utils.primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600)),
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
                                  const Text(
                                    "Phát sóng: ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Flexible(
                                    child: Text(detailAnime.publishTime!,
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
                                  const Text(
                                    "Nhà phát hành: ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Flexible(
                                    child: Text(detailAnime.publisher!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
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
                      SizedBox(
                        height: 48,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TabBar(
                            controller: _tabController,
                            dividerColor: Colors.grey,
                            dividerHeight: .2,
                            labelColor: Utils.primaryColor,
                            indicatorColor: Utils.primaryColor,
                            tabs: const [
                              Tab(
                                text: "Danh sách tập",
                              ),
                              Tab(
                                text: "Xem thêm",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            // height: detailAnime.episodes!.length * 88,
                            height: _tabIndex == 0
                                ? (detailAnime.episodes!.length * 108)
                                : (12 * 108),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Column(
                                      children: List.generate(
                                          detailAnime.episodes!.length,
                                          (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Provider.of<VideoProvider>(context,
                                                  listen: false)
                                              .setAnime(
                                                  Animes(
                                                    id: widget.animeId,
                                                  ),
                                                  AnimeEpisodes(
                                                      id: detailAnime
                                                              .episodes![index]
                                                          ['_id'],
                                                      episodeName: detailAnime
                                                              .episodes![index]
                                                          ['episodeName']));
                                          Provider.of<MiniPlayerControllerProvider>(
                                                  context,
                                                  listen: false)
                                              .setMiniController(
                                                  PanelState.MAX);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 12, 8),
                                            child: Row(
                                              children: [
                                                Container(
                                                  color: Colors.transparent,
                                                  height: 80,
                                                  child: AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: CachedNetworkImage(
                                                      imageUrl: detailAnime
                                                              .episodes![index]
                                                          ['coverImage'],
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        width: 125,
                                                        color: Colors.blue,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor: Colors
                                                              .grey.shade300,
                                                          highlightColor: Colors
                                                              .grey.shade100,
                                                          child: Container(
                                                              width: 125,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .yellow,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4))),
                                                        ),
                                                      ),
                                                      imageBuilder: (context,
                                                          imageProvider) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .fill)),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                      height: 80,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            detailAnime.episodes![
                                                                    index]
                                                                ['episodeName'],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .clock,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 11,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Text(
                                                                    Utils.convertTotalTime(
                                                                        detailAnime.episodes![index]
                                                                            [
                                                                            'totalTime']),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            11),
                                                                  )
                                                                ],
                                                              ),
                                                              Text(
                                                                "${Utils.formatNumberWithDots(detailAnime.episodes![index]['views'])} lượt xem",
                                                                style: TextStyle(
                                                                    color: Utils
                                                                        .primaryColor,
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                                ),
                                SuggestionByView(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ]));
  }

  @override
  void dispose() async {
    super.dispose();
    if (isLogedIn) {
      await AnimesApi.updateUserHistoryHadSeenEpisode(context, widget.videoId,
          userId, _controller!.value.position.inSeconds.toString());
    }
    _tabController.dispose();
    _controller!.dispose();
    _chewieController!.dispose();
    _controllerAd!.dispose();
    _chewieControllerAd!.dispose();
  }
}
