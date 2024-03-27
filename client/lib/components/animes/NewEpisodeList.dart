import 'package:anime_and_comic_entertainment/components/animes/BigEpisodeItem.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewEpisodeList extends StatefulWidget {
  const NewEpisodeList({super.key});

  @override
  State<NewEpisodeList> createState() => _NewEpisodeListState();
}

class _NewEpisodeListState extends State<NewEpisodeList> {
  List<AnimeEpisodes> listEpisode = [];
  Future<List<AnimeEpisodes>> getNewEpisodeAnime() async {
    var result = await AnimesApi.getNewEpisodeAnime(context);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getNewEpisodeAnime().then((value) => value.forEach((element) {
          setState(() {
            listEpisode.add(AnimeEpisodes(
                id: element.id,
                coverImage: element.coverImage,
                movieOwner: element.movieOwner,
                episodeName: element.episodeName));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return listEpisode.isEmpty
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
                      height: 108,
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
                      height: 108,
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
                      height: 108,
                      color: Colors.blue,
                    )),
              ),
            ],
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listEpisode.length,
            itemBuilder: (context, index) {
              return BigEpisodeItem(
                urlImage: listEpisode[index].coverImage,
                nameItem: listEpisode[index].movieOwner,
                episodeName: listEpisode[index].episodeName,
              );
            });
  }
}
