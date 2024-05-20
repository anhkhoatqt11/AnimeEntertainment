import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_comment.dart';
import 'package:anime_and_comic_entertainment/providers/comic_detail_provider.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors

class ComicChapterDetail extends StatefulWidget {
  final Comics comic;
  final int index;

  const ComicChapterDetail(
      {super.key, required this.comic, required this.index});

  @override
  State<ComicChapterDetail> createState() => _ComicChapterDetailState();
}

class _ComicChapterDetailState extends State<ComicChapterDetail> {
  final ScrollController _scrollController = ScrollController();
  late bool viewDone = false;
  late bool isLogedIn = false;
  late String userId = "";
  late double percentRead = 0;

  void checkUserHasLikeOrSaveAndWatchChapter() async {
    userId = Provider.of<UserProvider>(context, listen: false).user.id;
    if (userId == "") return;
    isLogedIn = true;
    Provider.of<ComicChapterProvider>(context, listen: false)
        .setLikeSave(userId, context);
  }

  @override
  void initState() {
    super.initState();
    FirebaseApi().listenEvent(context);
    _scrollController.addListener(_scrollListener);
    checkUserHasLikeOrSaveAndWatchChapter();
  }

  Future<void> _scrollListener() async {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double currentScrollPosition = _scrollController.position.pixels;
    double scrollPercentage = (currentScrollPosition / maxScrollExtent) * 100;

    setState(() {
      percentRead = scrollPercentage;
    });

    if (scrollPercentage >= 50) {
      if (viewDone) return;

      viewDone = true;
      ComicsApi.updateChapterView(
          context, widget.comic.chapterList![widget.index]['_id']);
      if (Provider.of<UserProvider>(context, listen: false)
              .user
              .authentication['sessionToken'] !=
          "") {
        Provider.of<UserProvider>(context, listen: false).setReadingTime(1);
        await DailyQuestsApi.updateQuestLog(context, "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Comics comic = widget.comic;
    int chapterIndex = widget.index;
    int contentLength = comic.chapterList![chapterIndex]['content'].length + 1;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<NavigatorProvider>(context, listen: false)
                .setShow(true);
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: Text(
          comic.chapterList![chapterIndex]['chapterName'],
          style: TextStyle(fontSize: 16),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF141414),
        actions: <Widget>[
          Consumer(builder: (BuildContext context, value, Widget? child) {
            final hadLiked =
                Provider.of<ComicChapterProvider>(context).hadLiked;
            final hadSaved =
                Provider.of<ComicChapterProvider>(context).hadSaved;
            return Row(
              children: [
                IconButton(
                    onPressed: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .authentication['sessionToken'] !=
                          "") {
                        ComicsApi.updateUserLikeChapter(
                            context,
                            comic.chapterList![chapterIndex]['_id'],
                            Provider.of<UserProvider>(context, listen: false)
                                .user
                                .id);
                        setState(
                          () {
                            Provider.of<ComicChapterProvider>(context,
                                    listen: false)
                                .setLiked();
                          },
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.thumbsUp,
                      color: hadLiked ? Utils.primaryColor : Colors.white,
                      size: 18,
                    )),
                IconButton(
                    onPressed: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .authentication['sessionToken'] !=
                          "") {
                        ComicsApi.updateUserSaveChapter(
                            context,
                            comic.chapterList![chapterIndex]['_id'],
                            Provider.of<UserProvider>(context, listen: false)
                                .user
                                .id);
                        setState(
                          () {
                            Provider.of<ComicChapterProvider>(context,
                                    listen: false)
                                .setSaved();
                          },
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.squarePlus,
                      color: hadSaved ? Utils.primaryColor : Colors.white,
                      size: 18,
                    ))
              ],
            );
          })
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: percentRead / 100,
            valueColor: AlwaysStoppedAnimation<Color>(Utils.primaryColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 92,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: contentLength,
              itemBuilder: (context, index) => index == contentLength - 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent),
                            child: IconButton(
                                onPressed: () {
                                  if (chapterIndex == 0) return;
                                  Navigator.of(context).pop(true);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ComicChapterDetail(
                                        comic: comic,
                                        index: chapterIndex - 1,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Row(
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: FaIcon(
                                          FontAwesomeIcons.backwardStep,
                                          color: Colors.white,
                                          size: 16,
                                        )),
                                    Text(
                                      "Trước",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )
                                  ],
                                ))),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComicChapterComment(
                                    chapterId: widget.comic
                                        .chapterList![widget.index]['_id'],
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent),
                            child: FaIcon(
                              FontAwesomeIcons.solidMessage,
                              color: Colors.white,
                              size: 18,
                            )),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent),
                            child: IconButton(
                                onPressed: () {
                                  if (chapterIndex ==
                                      comic.chapterList!.length - 1) return;
                                  Navigator.of(context).pop(true);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ComicChapterDetail(
                                          comic: comic,
                                          index: chapterIndex + 1,
                                        ),
                                      ));
                                },
                                icon: const Row(
                                  children: [
                                    Text(
                                      "Sau",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: FaIcon(
                                          FontAwesomeIcons.forwardStep,
                                          color: Colors.white,
                                          size: 16,
                                        ))
                                  ],
                                )))
                      ],
                    )
                  : FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loadingcomicimage.png',
                      image: comic.chapterList![chapterIndex]['content'][index],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    if (isLogedIn) {
      await ComicsApi.updateUserHistoryHadSeenChapter(
          context, widget.comic.chapterList![widget.index]['_id'], userId);
    }
  }
}
