import 'package:anime_and_comic_entertainment/components/HotSeries.dart';
import 'package:anime_and_comic_entertainment/components/MainBanner.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:shimmer/shimmer.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  List<Animes> listAnimes = [];
  Future<List<Animes>> getAllAnimes() async {
    var result = await AnimesApi.getAllAnimes(context);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getAllAnimes().then((value) => value.forEach((element) {
          print(element.genres);
          setState(() {
            listAnimes.add(Animes(
                id: element.id,
                coverImage: element.coverImage,
                movieName: element.movieName,
                genres: element.genres));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
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
              Navigator.of(context).pop();
            },
            type: GFButtonType.transparent,
          ),
        ),
        backgroundColor: Color(0xFF141414),
        body: listAnimes.isEmpty
            ? ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 125,
                          height: 187,
                          color: Colors.blue,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 125,
                          height: 187,
                          color: Colors.blue,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 125,
                          height: 187,
                          color: Colors.blue,
                        )),
                  ),
                ],
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listAnimes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: ComicItem(
                        urlImage: listAnimes[index].coverImage,
                        nameItem: listAnimes[index].movieName,
                        genres: listAnimes[index].genres),
                  );
                }));
  }
}
