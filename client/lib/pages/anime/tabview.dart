import 'package:anime_and_comic_entertainment/components/animes/CommentComponent.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> listEpisode = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Color(0xFF141414),
          body: ListView(
            children: [
              Container(
                width: 100,
                height: 100,
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
                                      placeholder: (context, url) => Container(
                                        width: 125,
                                        color: Colors.blue,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            width: 125,
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
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                        begin:
                                                            Alignment.topCenter,
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
          )),
    );
  }
}
