import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:shimmer/shimmer.dart';

class TopRankingComic extends StatefulWidget {
  const TopRankingComic({super.key});

  @override
  State<TopRankingComic> createState() => _TopRankingComicState();
}

class _TopRankingComicState extends State<TopRankingComic> {
  final List<int> listPage = [1, 2, 3, 4];
  List<Comics> listRanking = [];
  Future<List<Comics>> getRankingTable() async {
    var result = await ComicsApi.getRankingTable(context);
    return result;
  }

  @override
  void initState() {
    super.initState();

    getRankingTable().then((value) => value.forEach((element) {
          setState(() {
            listRanking.add(Comics(
                id: element.id,
                comicName: element.comicName,
                coverImage: element.coverImage,
                landspaceImage: element.landspaceImage,
                genres: element.genres));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return listRanking.isEmpty
        ? SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4)),
                  )),
            ),
          )
        : Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: const SizedBox.shrink(),
              ),
              Positioned(
                left: -96,
                child: Container(
                  color: Colors.transparent,
                  height: 400,
                  width: MediaQuery.of(context).size.width + 96,
                  child: GFCarousel(
                    hasPagination: true,
                    enableInfiniteScroll: true,
                    activeIndicator: Utils.primaryColor,
                    viewportFraction: 0.6,
                    height: 500,
                    aspectRatio: 1 / 2,
                    items: listPage.map(
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Container(
                              margin: const EdgeInsets.all(4),
                              height: 400,
                              child: Container(
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 49, 49, 49),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 0),
                                      child: Container(
                                        width: 1000,
                                        height: 60,
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                child: ShaderMask(
                                                    shaderCallback: (rect) =>
                                                        LinearGradient(
                                                            colors: index == 1
                                                                ? Utils
                                                                    .top1gradientColors
                                                                : Utils.topgradientColors,
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            stops: const [
                                                              0,
                                                              0.4
                                                            ]).createShader(
                                                            rect),
                                                    child: Text(
                                                      index == 1
                                                          ? "#1"
                                                          : "${(index - 1) * 5 + 1}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    )),
                                              ),
                                            ),
                                            CachedNetworkImage(
                                              imageUrl:
                                                  listRanking[(index - 1) * 5]
                                                      .coverImage!,
                                              width: 50,
                                              height: 50,
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.grey.shade400,
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                );
                                              },
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        14, 2, 0, 2),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listRanking[
                                                              (index - 1) * 5]
                                                          .comicName!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      convertGenreArrayToString(
                                                          listRanking[
                                                                  (index - 1) *
                                                                      5]
                                                              .genres!),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Container(
                                        width: 1000,
                                        height: 60,
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                child: ShaderMask(
                                                    shaderCallback: (rect) =>
                                                        LinearGradient(
                                                            colors: index == 1
                                                                ? Utils
                                                                    .top2gradientColors
                                                                : Utils.topgradientColors,
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            stops: const [
                                                              0,
                                                              0.4
                                                            ]).createShader(
                                                            rect),
                                                    child: Text(
                                                      index == 1
                                                          ? "#2"
                                                          : "${(index - 1) * 5 + 2}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    )),
                                              ),
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: listRanking[
                                                      (index - 1) * 5 + 1]
                                                  .coverImage!,
                                              width: 50,
                                              height: 50,
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.grey.shade400,
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                );
                                              },
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        14, 2, 0, 2),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listRanking[
                                                              (index - 1) * 5 +
                                                                  1]
                                                          .comicName!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      convertGenreArrayToString(
                                                          listRanking[
                                                                  (index - 1) *
                                                                          5 +
                                                                      1]
                                                              .genres!),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Container(
                                        width: 1000,
                                        height: 60,
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                child: ShaderMask(
                                                    shaderCallback: (rect) =>
                                                        LinearGradient(
                                                            colors: index == 1
                                                                ? Utils
                                                                    .top3gradientColors
                                                                : Utils.topgradientColors,
                                                            begin: Alignment.topCenter,
                                                            end: Alignment.bottomCenter,
                                                            stops: const [
                                                              0,
                                                              0.4
                                                            ]).createShader(
                                                            rect),
                                                    child: Text(
                                                      index == 1
                                                          ? "#3"
                                                          : "${(index - 1) * 5 + 3}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    )),
                                              ),
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: listRanking[
                                                      (index - 1) * 5 + 2]
                                                  .coverImage!,
                                              width: 50,
                                              height: 50,
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.grey.shade400,
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                );
                                              },
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        14, 2, 0, 2),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listRanking[
                                                              (index - 1) * 5 +
                                                                  2]
                                                          .comicName!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      convertGenreArrayToString(
                                                          listRanking[
                                                                  (index - 1) *
                                                                          5 +
                                                                      2]
                                                              .genres!),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Container(
                                        width: 1000,
                                        height: 60,
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                child: ShaderMask(
                                                    shaderCallback: (rect) => LinearGradient(
                                                            colors: Utils
                                                                .topgradientColors,
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            stops: const [
                                                              0,
                                                              0.4
                                                            ]).createShader(
                                                            rect),
                                                    child: Text(
                                                      "${(index - 1) * 5 + 4}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    )),
                                              ),
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: listRanking[
                                                      (index - 1) * 5 + 3]
                                                  .coverImage!,
                                              width: 50,
                                              height: 50,
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.grey.shade400,
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                );
                                              },
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        14, 2, 0, 2),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listRanking[
                                                              (index - 1) * 5 +
                                                                  3]
                                                          .comicName!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      convertGenreArrayToString(
                                                          listRanking[
                                                                  (index - 1) *
                                                                          5 +
                                                                      3]
                                                              .genres!),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, bottom: 0),
                                      child: Container(
                                        width: 1000,
                                        height: 60,
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                child: ShaderMask(
                                                    shaderCallback: (rect) => LinearGradient(
                                                            colors: Utils
                                                                .topgradientColors,
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            stops: const [
                                                              0,
                                                              0.4
                                                            ]).createShader(
                                                            rect),
                                                    child: Text(
                                                      "${(index - 1) * 5 + 5}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    )),
                                              ),
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: listRanking[
                                                      (index - 1) * 5 + 4]
                                                  .coverImage!,
                                              width: 50,
                                              height: 50,
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.grey.shade400,
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                  ),
                                                ),
                                              ),
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                );
                                              },
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        14, 2, 0, 2),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listRanking[
                                                              (index - 1) * 5 +
                                                                  4]
                                                          .comicName!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      convertGenreArrayToString(
                                                          listRanking[
                                                                  (index - 1) *
                                                                          5 +
                                                                      4]
                                                              .genres!),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                    ).toList(),
                  ),
                ),
              )
            ],
          );
  }
}

String convertGenreArrayToString(List list) {
  String genreList = "";
  for (var element in list) {
    genreList += (element['genreName']) + " / ";
  }
  return genreList.substring(0, genreList.length - 2);
}
