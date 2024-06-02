import 'package:anime_and_comic_entertainment/components/AnimeBookmarkItem.dart';
import 'package:anime_and_comic_entertainment/components/ComicBookmarkItem.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertChoiceDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/comicchapters.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  List<AnimeEpisodes> listAnimeItem = [];
  List<ComicChapter> listComicItem = [];
  bool hasData = true;
  bool isEditing = false;
  List<int> selectedAnimeIndexes = [];
  List<int> selectedComicIndexes = [];
  late String userId = "";

  @override
  void initState() {
    super.initState();
    _fetchBookmarkList();
  }

  Future<void> _fetchBookmarkList() async {
    try {
      userId = Provider.of<UserProvider>(context, listen: false).user.id;
      if (userId == "") return;
      final result = await UsersApi.getBookmartList(context, userId);
      setState(() {
        result[0]['animes'].forEach((item) {
          listAnimeItem.add(AnimeEpisodes(
              id: item['_id'],
              coverImage: item['coverImage'],
              episodeName: item['episodeName'],
              movieOwner: item['owner'][0]['movieName'],
              movieOwnerId: item['owner'][0]['_id'],
              genreNames: item['owner'][0]['genreNames']));
        });
        result[0]['comics'].forEach((item) {
          listComicItem.add(ComicChapter(
              id: item['_id'],
              coverImage: item['coverImage'],
              chapterName: item['chapterName'],
              comicOwner: item['owner'][0]['comicName'],
              genreNames: item['owner'][0]['genreNames'],
              index: item['owner'][0]['index'],
              comicOwnerId: item['owner'][0]['_id'],
              comicChapterList: item['owner'][0]['chapterListDetail']));
        });
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF141414),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GFIconButton(
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
              const Text(
                "Yêu thích",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(
                  isEditing ? "Thoát" : "Sửa",
                  style: TextStyle(fontSize: 16, color: Utils.primaryColor),
                ),
              ),
            ],
          ),
          bottom: TabBar(
              dividerColor: Colors.transparent,
              labelColor: Utils.primaryColor,
              indicatorColor: Utils.primaryColor,
              tabs: const [
                Tab(
                  text: "      Anime      ",
                ),
                Tab(
                  text: "      Truyện      ",
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            _buildAnimeList(),
            _buildComicList(),
          ],
        ),
        bottomNavigationBar: isEditing
            ? BottomAppBar(
                color: Colors.transparent,
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GradientButton(
                          action: () {
                            _deleteSelectedItems();
                          },
                          content: 'Xoá khỏi danh sách',
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          disabled: false,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildAnimeList() {
    if (listAnimeItem.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/images/empty-box.png'),
            const Text(
              'Chưa có bộ anime nào',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Hãy thêm anime vào danh sách yêu thích của bạn',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: listAnimeItem.length,
        itemBuilder: (context, index) {
          return isEditing
              ? AnimeBookmarkItem(
                  animeId: listAnimeItem[index].movieOwnerId!,
                  coverImage: listAnimeItem[index].coverImage!,
                  movieName: listAnimeItem[index].movieOwner!,
                  isBookmarked: true,
                  genreNames: listAnimeItem[index].genreNames!,
                  isChecked: selectedAnimeIndexes.contains(index),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        selectedAnimeIndexes.add(index);
                      } else {
                        selectedAnimeIndexes.remove(index);
                      }
                    });
                  },
                  animeepisodeId: listAnimeItem[index].id!,
                  episodeName: listAnimeItem[index].episodeName!,
                )
              : AnimeBookmarkItem(
                  animeId: listAnimeItem[index].movieOwnerId!,
                  coverImage: listAnimeItem[index].coverImage!,
                  movieName: listAnimeItem[index].movieOwner!,
                  isBookmarked: true,
                  genreNames: listAnimeItem[index].genreNames!,
                  animeepisodeId: listAnimeItem[index].id!,
                  episodeName: listAnimeItem[index].episodeName!,
                );
        },
      ),
    );
  }

  Widget _buildComicList() {
    if (listComicItem.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/images/empty-box.png'),
            const Text(
              'Chưa có bộ truyện nào',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Hãy thêm truyện vào danh sách yêu thích của bạn',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: listComicItem.length,
        itemBuilder: (context, index) {
          return isEditing
              ? ComicBookmarkItem(
                  comicId: listComicItem[index].comicOwnerId!,
                  coverImage: listComicItem[index].coverImage!,
                  comicName: listComicItem[index].comicOwner!,
                  isBookmarked: true,
                  genreNames: listComicItem[index].genreNames!,
                  isChecked: selectedComicIndexes.contains(index),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        selectedComicIndexes.add(index);
                      } else {
                        selectedComicIndexes.remove(index);
                      }
                    });
                  },
                  comicChapterId: listComicItem[index].id!,
                  comicChapterName: listComicItem[index].chapterName!,
                  index: listComicItem[index].index!,
                  comicVar: Comics(
                      chapterList: listComicItem[index].comicChapterList!),
                )
              : ComicBookmarkItem(
                  comicId: listComicItem[index].comicOwnerId!,
                  coverImage: listComicItem[index].coverImage!,
                  comicName: listComicItem[index].comicOwner!,
                  isBookmarked: true,
                  genreNames: listComicItem[index].genreNames!,
                  comicChapterId: listComicItem[index].id!,
                  comicChapterName: listComicItem[index].chapterName!,
                  index: listComicItem[index].index!,
                  comicVar: Comics(
                      chapterList: listComicItem[index].comicChapterList!));
        },
      ),
    );
  }

  void _deleteSelectedItems() async {
    userId = Provider.of<UserProvider>(context, listen: false).user.id;
    if (userId == "") return;
    final bookmarksToRemove = <String>[];

    // Create copies of the lists to avoid modification during iteration
    final animeCopy = List.from(listAnimeItem);
    final comicCopy = List.from(listComicItem);

    setState(() {
      // Delete selected anime items
      for (var index in selectedAnimeIndexes) {
        final anime = animeCopy[index];
        if (anime != null && anime.id != null) {
          bookmarksToRemove.add(anime.id!);
        }
      }
      // Remove selected anime items from the original list
      listAnimeItem.removeWhere((anime) =>
          anime != null &&
          selectedAnimeIndexes.contains(animeCopy.indexOf(anime)));

      // Delete selected comic items
      for (var index in selectedComicIndexes) {
        final comic = comicCopy[index];
        if (comic != null && comic.id != null) {
          bookmarksToRemove.add(comic.id!);
        }
      }
      // Remove selected comic items from the original list
      listComicItem.removeWhere((comic) =>
          comic != null &&
          selectedComicIndexes.contains(comicCopy.indexOf(comic)));

      // Clear selected indexes
      selectedAnimeIndexes.clear();
      selectedComicIndexes.clear();
    });

    try {
      await UsersApi.removeBookmark(context, userId, bookmarksToRemove);
    } catch (e) {
      print('Error removing bookmarks: $e');
      // Handle error
    }
  }
}
