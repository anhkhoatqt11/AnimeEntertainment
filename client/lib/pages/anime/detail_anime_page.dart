import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_genre_result_page.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailAnimePage extends StatefulWidget {
  final String? animeId;
  const DetailAnimePage({super.key, required this.animeId});

  @override
  State<DetailAnimePage> createState() => _DetailAnimePageState();
}

class _DetailAnimePageState extends State<DetailAnimePage> {
  late ScrollController _scrollController;
  late bool isLoading = true;
  double _scrollControllerOffset = 0.0;
  bool isExpanded = false;
  String textExpander = "Xem thêm";
  late Animes detailAnime = Animes();
  List<dynamic> listGenre = [];
  Future<Animes> getAnimeDetailById() async {
    var result = await AnimesApi.getAnimeDetailById(context, widget.animeId);
    return result;
  }

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseApi().listenEvent(context);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    getAnimeDetailById().then((value) => setState(() {
          detailAnime = value;
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return detailAnime.coverImage == null
        ? Scaffold(
            backgroundColor: const Color(0xFF141414),
            appBar: GFAppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: GFIconButton(
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  Provider.of<NavigatorProvider>(context, listen: false)
                      .setShow(true);
                  Navigator.of(context).pop();
                },
                type: GFButtonType.transparent,
              ),
            ),
            body: const Center(
              child: GFLoader(type: GFLoaderType.circle),
            ),
          )
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: GFAppBar(
              elevation: 0,
              backgroundColor: Colors.black.withOpacity(
                  (_scrollControllerOffset / 350).clamp(0, 1).toDouble()),
              leading: GFIconButton(
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  Provider.of<NavigatorProvider>(context, listen: false)
                      .setShow(true);
                  Navigator.of(context).pop();
                },
                type: GFButtonType.transparent,
              ),
            ),
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.network(
                  detailAnime.coverImage!,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                      children: [
                        Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              80,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color.fromARGB(0, 0, 0, 0),
                                          const Color(0xFF050B11)
                                              .withOpacity(0.9)
                                        ],
                                        stops: const [0.0, 0.86],
                                      )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<VideoProvider>(context,
                                                listen: false)
                                            .setAnime(
                                                Animes(
                                                  id: widget.animeId,
                                                ),
                                                AnimeEpisodes(
                                                    id: detailAnime.episodes![0]
                                                        ['_id'],
                                                    episodeName:
                                                        detailAnime.episodes![0]
                                                            ['episodeName']));
                                        Provider.of<MiniPlayerControllerProvider>(
                                                context,
                                                listen: false)
                                            .setMiniController(PanelState.MAX);
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(360)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              6, 2, 0, 0),
                                          child: Center(
                                              child: ShaderMask(
                                                  shaderCallback: (rect) =>
                                                      LinearGradient(
                                                        colors: Utils
                                                            .gradientColors,
                                                        begin:
                                                            Alignment.topCenter,
                                                      ).createShader(rect),
                                                  child: const FaIcon(
                                                    FontAwesomeIcons.play,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ))),
                                        ),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        detailAnime.movieName!,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 0.0,
                                        children: [
                                          SizedBox(
                                            width: 110,
                                            child: Column(children: [
                                              const FaIcon(
                                                FontAwesomeIcons.solidThumbsUp,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Wrap(
                                                children: [
                                                  ShaderMask(
                                                    shaderCallback: (rect) =>
                                                        LinearGradient(
                                                      colors:
                                                          Utils.gradientColors,
                                                      begin:
                                                          Alignment.topCenter,
                                                    ).createShader(rect),
                                                    child: Text(
                                                      detailAnime.totalLike
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  const Text(
                                                    " lượt thích",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13),
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            width: 110,
                                            child: Column(children: [
                                              const FaIcon(
                                                FontAwesomeIcons.solidEye,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Wrap(
                                                children: [
                                                  ShaderMask(
                                                    shaderCallback: (rect) =>
                                                        LinearGradient(
                                                      colors:
                                                          Utils.gradientColors,
                                                      begin:
                                                          Alignment.topCenter,
                                                    ).createShader(rect),
                                                    child: Text(
                                                      Utils
                                                          .formatNumberWithDots(
                                                              detailAnime
                                                                  .totalView!),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  const Text(
                                                    " lượt xem",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13),
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                          SizedBox(
                                            width: 110,
                                            child: Column(children: [
                                              const FaIcon(
                                                FontAwesomeIcons.clipboardList,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Wrap(
                                                children: [
                                                  ShaderMask(
                                                    shaderCallback: (rect) =>
                                                        LinearGradient(
                                                      colors:
                                                          Utils.gradientColors,
                                                      begin:
                                                          Alignment.topCenter,
                                                    ).createShader(rect),
                                                    child: Text(
                                                      detailAnime
                                                          .episodes!.length
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  const Text(
                                                    " tập",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13),
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Wrap(
                                          spacing: 8.0,
                                          children: List.generate(
                                            detailAnime.genres!.length,
                                            (index) => GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchGenreResultPage(
                                                      genreId: detailAnime
                                                              .genres![index]
                                                          ['_id'],
                                                      genreName: detailAnime
                                                              .genres![index]
                                                          ['genreName'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Chip(
                                                label: Text(
                                                  detailAnime.genres![index]
                                                      ['genreName'],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                backgroundColor:
                                                    const Color(0xFF282727),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32)),
                                              ),
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Dành cho độ tuổi: ",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Flexible(
                                            child: Text(detailAnime.ageFor!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Utils.primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600)),
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
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Flexible(
                                            child: Text(
                                                detailAnime.publishTime!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontWeight:
                                                        FontWeight.w600)),
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
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Flexible(
                                            child: Text(detailAnime.publisher!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ],
                    ),
                    Container(
                      color: const Color(0xFF050B11).withOpacity(0.9),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isExpanded
                                ? Text(
                                    detailAnime.description!,
                                    style: const TextStyle(color: Colors.white),
                                  )
                                : Container(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                  textExpander =
                                      isExpanded ? "Rút gọn" : "Xem thêm";
                                });
                              },
                              child: Text(
                                textExpander,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w500,
                                  decorationThickness: 2,
                                  decorationColor: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                                children: List.generate(
                                    detailAnime.episodes!.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  Provider.of<VideoProvider>(context,
                                          listen: false)
                                      .setAnime(
                                          Animes(
                                            id: widget.animeId,
                                          ),
                                          AnimeEpisodes(
                                              id: detailAnime.episodes![index]
                                                  ['_id'],
                                              episodeName:
                                                  detailAnime.episodes![index]
                                                      ['episodeName']));
                                  Provider.of<MiniPlayerControllerProvider>(
                                          context,
                                          listen: false)
                                      .setMiniController(PanelState.MAX);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(8)),
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
                                                imageUrl:
                                                    detailAnime.episodes![index]
                                                        ['coverImage'],
                                                placeholder: (context, url) =>
                                                    Container(
                                                  width: 125,
                                                  color: Colors.blue,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade300,
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
                                                            BorderRadius
                                                                .circular(4),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
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
                                            child: SizedBox(
                                                height: 80,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      detailAnime
                                                              .episodes![index]
                                                          ['episodeName'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
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
                                                            const FaIcon(
                                                              FontAwesomeIcons
                                                                  .clock,
                                                              color:
                                                                  Colors.grey,
                                                              size: 11,
                                                            ),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              Utils.convertTotalTime(
                                                                  detailAnime.episodes![
                                                                          index]
                                                                      [
                                                                      'totalTime']),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 11),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          "${Utils.formatNumberWithDots(detailAnime.episodes![index]['views'])} lượt xem",
                                                          style: TextStyle(
                                                              color: Utils
                                                                  .primaryColor,
                                                              fontSize: 11,
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
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
