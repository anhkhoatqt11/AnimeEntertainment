import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class TopRankingAnime extends StatefulWidget {
  const TopRankingAnime({super.key});

  @override
  State<TopRankingAnime> createState() => _TopRankingAnimeState();
}

class _TopRankingAnimeState extends State<TopRankingAnime> {
  List<Animes> listRanking = [];
  final List<int> indexList = [1, 2, 3, 4, 5];
  Future<List<Animes>> getRankingTable() async {
    var result = await AnimesApi.getRankingTable(context);
    return result;
  }

  @override
  void initState() {
    super.initState();

    getRankingTable().then((value) => value.forEach((element) {
          setState(() {
            listRanking.add(Animes(
                id: element.id,
                movieName: element.movieName,
                coverImage: element.coverImage,
                landspaceImage: element.landspaceImage));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return (listRanking.isEmpty
        ? ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 191,
                      height: 280,
                      color: Colors.blue,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 191,
                      height: 280,
                      color: Colors.blue,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 191,
                      height: 280,
                      color: Colors.blue,
                    )),
              ),
            ],
          )
        : ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              indexList.length,
              (index) => index == 0
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Container(
                              height: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.blue),
                              child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: CachedNetworkImage(
                                  imageUrl: listRanking[0].coverImage!,
                                  height: 280,
                                  placeholder: (context, url) => Container(
                                    height: 280,
                                    color: Colors.blue,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        height: 280,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                  imageBuilder: (context, imageProvider) {
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
                            Container(
                              height: 280,
                              width: 280 * 2 / 3,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color.fromARGB(0, 0, 0, 0),
                                  const Color(0xFF050B11).withOpacity(0.8)
                                ],
                                stops: const [0.0, 1],
                              )),
                            ),
                            Positioned(
                              left: 3,
                              bottom: -20,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ShaderMask(
                                      shaderCallback: (rect) => LinearGradient(
                                              colors: Utils.top1gradientColors,
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: const [0, 0.6])
                                          .createShader(rect),
                                      child: const Text(
                                        "1",
                                        style: TextStyle(
                                            shadows: [
                                              Shadow(
                                                color: Color(0xFFA958FE),
                                                blurRadius: 0.0,
                                                offset: Offset(2.0, 2.0),
                                              ),
                                            ],
                                            color: Colors.white,
                                            fontSize: 69,
                                            fontWeight: FontWeight.w900),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, bottom: 22),
                                    child: SizedBox(
                                      width: 130,
                                      child: Text(
                                        listRanking[0].movieName!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            leadingDistribution:
                                                TextLeadingDistribution.even,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ])
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Container(
                              width: 240,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16)),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: CachedNetworkImage(
                                  imageUrl: listRanking[index * 2 - 1]
                                      .landspaceImage!,
                                  width: 240,
                                  placeholder: (context, url) => Container(
                                    width: 240,
                                    color: Colors.blue,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 240,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                  imageBuilder: (context, imageProvider) {
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
                            Container(
                              height: 240 * 9 / 16,
                              width: 240,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color.fromARGB(0, 0, 0, 0),
                                  const Color(0xFF050B11).withOpacity(0.8)
                                ],
                                stops: const [0.0, 1],
                              )),
                            ),
                            Positioned(
                                left: 3,
                                bottom: -20,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ShaderMask(
                                        shaderCallback: (rect) =>
                                            LinearGradient(
                                                colors: (index * 2 == 2)
                                                    ? Utils.top2gradientColors
                                                    : Utils.topgradientColors,
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: const [
                                                  0,
                                                  0.6
                                                ]).createShader(rect),
                                        child: Text(
                                          (index * 2).toString(),
                                          style: TextStyle(
                                              shadows: [
                                                Shadow(
                                                  color: (index * 2 == 2)
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  blurRadius: 0.0,
                                                  offset:
                                                      const Offset(2.0, 2.0),
                                                ),
                                              ],
                                              color: Colors.white,
                                              fontSize: 69,
                                              fontWeight: FontWeight.w900),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, bottom: 22),
                                      child: SizedBox(
                                        width: 186,
                                        child: Text(
                                          listRanking[index * 2 - 1].movieName!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              leadingDistribution:
                                                  TextLeadingDistribution.even,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(children: [
                            Container(
                              width: 240,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16)),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      listRanking[index * 2].landspaceImage!,
                                  width: 240,
                                  placeholder: (context, url) => Container(
                                    width: 240,
                                    color: Colors.blue,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 240,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                  imageBuilder: (context, imageProvider) {
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
                            Container(
                              height: 240 * 9 / 16,
                              width: 240,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color.fromARGB(0, 0, 0, 0),
                                  const Color(0xFF050B11).withOpacity(0.8)
                                ],
                                stops: const [0.0, 1],
                              )),
                            ),
                            Positioned(
                                left: 3,
                                bottom: -20,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ShaderMask(
                                        shaderCallback: (rect) =>
                                            LinearGradient(
                                                colors: (index * 2 + 1 == 3)
                                                    ? Utils.top3gradientColors
                                                    : Utils.topgradientColors,
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: const [
                                                  0,
                                                  0.6
                                                ]).createShader(rect),
                                        child: Text(
                                          (index * 2 + 1).toString(),
                                          style: TextStyle(
                                              shadows: [
                                                Shadow(
                                                  color: (index * 2 + 1 == 3)
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                  blurRadius: 0.0,
                                                  offset:
                                                      const Offset(2.0, 2.0),
                                                ),
                                              ],
                                              color: Colors.white,
                                              fontSize: 69,
                                              fontWeight: FontWeight.w900),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, bottom: 22),
                                      child: SizedBox(
                                        width: 186,
                                        child: Text(
                                          listRanking[index * 2].movieName!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              leadingDistribution:
                                                  TextLeadingDistribution.even,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        ],
                      ),
                    ),
            )));
  }
}
