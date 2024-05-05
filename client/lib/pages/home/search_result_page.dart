import 'package:anime_and_comic_entertainment/components/animes/AnimeItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
          backgroundColor: const Color(0xFF141414),
          elevation: 0,
          title: const TextField(
            decoration: InputDecoration(
              // hintText: "Tìm kiếm phim, anime, comic, diễn viên, ...",
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Tất cả",
              ),
              Tab(
                text: "Video",
              ),
              Tab(
                text: "Truyện",
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: TabBarView(children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "VIDEO (XXX KẾT QUẢ)",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                AnimeItem(
                    urlImage:
                        'https://static2.vieon.vn/vieplay-image/carousel_web_v4/2021/05/11/tnu18hc7_1920x1080vuadaubepsouma-phan1.jpg',
                    nameItem: 'Vua đầu bếp Souma'),
                AnimeItem(
                    urlImage:
                        'https://static2.vieon.vn/vieplay-image/carousel_web_v4/2021/05/11/tnu18hc7_1920x1080vuadaubepsouma-phan1.jpg',
                    nameItem: 'Vua đầu bếp Souma'),
              ],
            ),
            Column(
              children: [
                Text("Video"),
              ],
            ),
            Column(
              children: [
                Text("Truyện"),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
