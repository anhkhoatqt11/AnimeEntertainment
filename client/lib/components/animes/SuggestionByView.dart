import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:shimmer/shimmer.dart';

class SuggestionByView extends StatefulWidget {
  const SuggestionByView({super.key});

  @override
  State<SuggestionByView> createState() => _SuggestionByViewState();
}

class _SuggestionByViewState extends State<SuggestionByView> {
  List<AnimeEpisodes> listEpisodeItem = [];

  Future<List<AnimeEpisodes>> getSomeTopViewEpisodes() async {
    var result = await AnimesApi.getSomeTopViewEpisodes(context);
    return result;
  }

  @override
  void initState() {
    super.initState();

    getSomeTopViewEpisodes().then((value) => value.forEach((element) {
          setState(() {
            listEpisodeItem.add(AnimeEpisodes(
                id: element.id,
                coverImage: element.coverImage,
                totalTime: element.totalTime,
                episodeName: element.episodeName,
                views: element.views));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return listEpisodeItem.isEmpty
        ? const Center(
            child: GFLoader(type: GFLoaderType.circle),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
                children: List.generate(listEpisodeItem.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                    child: Row(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 80,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CachedNetworkImage(
                              imageUrl: listEpisodeItem[index].coverImage!,
                              placeholder: (context, url) => Container(
                                width: 125,
                                color: Colors.blue,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 125,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ),
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
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
                          child: SizedBox(
                              height: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listEpisodeItem[index].episodeName!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.clock,
                                            color: Colors.grey,
                                            size: 11,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            Utils.convertTotalTime(
                                                listEpisodeItem[index]
                                                    .totalTime!),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "${Utils.formatNumberWithDots(listEpisodeItem[index].views!)} lượt xem",
                                        style: TextStyle(
                                            color: Utils.primaryColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
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
              );
            })),
          );
  }
}
