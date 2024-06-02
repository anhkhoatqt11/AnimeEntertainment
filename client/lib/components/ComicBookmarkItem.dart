import 'package:anime_and_comic_entertainment/components/ui/GenresBranch.dart';
import 'package:anime_and_comic_entertainment/model/comicchapters.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:anime_and_comic_entertainment/providers/comic_detail_provider.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';

class ComicBookmarkItem extends StatelessWidget {
  final String comicChapterId;
  final String comicChapterName;
  final String coverImage;
  final String comicName;
  final bool isBookmarked;
  final bool isChecked;
  final List genreNames;
  final int index;
  final Comics comicVar;
  final ValueChanged<bool?>? onChanged;

  const ComicBookmarkItem({
    Key? key,
    required this.comicChapterId,
    required this.comicChapterName,
    required this.coverImage,
    required this.comicName,
    required this.isBookmarked,
    required this.genreNames,
    required this.index,
    required this.comicVar,
    this.isChecked = false,
    this.onChanged,
    required String comicId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              if (onChanged != null) // Show checkbox only when editing
                Checkbox(
                  value: isChecked,
                  onChanged: onChanged,
                  checkColor: Colors.white,
                  activeColor: Utils.primaryColor,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (onChanged == null) {
                        Provider.of<NavigatorProvider>(context, listen: false)
                            .setShow(false);
                        Provider.of<ComicChapterProvider>(context,
                                listen: false)
                            .setComic(Comics(id: comicVar.id),
                                ComicChapter(id: comicVar.chapterList![index]));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComicChapterDetail(
                              comic: comicVar,
                              index: index,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      color: const Color(0xFF141414),
                      height: 120,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: coverImage,
                              width: 100,
                              height: 100,
                              placeholder: (context, url) => Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    comicName,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (onChanged == null)
                                    GenresBranch(genreList: genreNames),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    comicChapterName,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
