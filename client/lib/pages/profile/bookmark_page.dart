import 'package:anime_and_comic_entertainment/components/AnimeBookmarkItem.dart';
import 'package:anime_and_comic_entertainment/components/ComicBookmarkItem.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  List<Animes> listAnimeItem = [];
  List<Comics> listComicItem = [];
  bool hasData = true;
  bool isEditing = false;
  List<int> selectedAnimeIndexes = [];
  List<int> selectedComicIndexes = [];

  @override
  void initState() {
    super.initState();
    _fetchBookmarkList();
  }

  Future<void> _fetchBookmarkList() async {
    try {
      final result =
          await UsersApi.getBookmartList(context, '662777d1ba7dff5ac56f1729');
      setState(() {
        listAnimeItem = (result['animes'] as List)
            .map((item) => Animes(
                  id: item['_id'],
                  landspaceImage: item['landspaceImage'],
                  movieName: item['movieName'],
                ))
            .toList();
        listComicItem = (result['comics'] as List)
            .map((item) => Comics(
                  id: item['_id'],
                  landspaceImage: item['landspaceImage'],
                  genres: item['genres'],
                  comicName: item['comicName'],
                ))
            .toList();
      });
    } catch (e) {
      print('Error fetching bookmark list: $e');
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
          backgroundColor: const Color(0xFF141414),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Yêu thích"),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(
                  isEditing ? "Thoát" : "Sửa",
                  style: TextStyle(fontSize: 18, color: Utils.primaryColor),
                ),
              ),
            ],
          ),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Anime",
            ),
            Tab(
              text: "Truyện",
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
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _deleteSelectedItems();
                          },
                          child: Text('Xoá khỏi danh sách'),
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
            SizedBox(height: 30),
            Image.asset('assets/images/empty-box.png'),
            Text(
              'Chưa có bộ anime nào',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Hãy thêm anime vào danh sách yêu thích của bạn',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: listAnimeItem.length,
      itemBuilder: (context, index) {
        return isEditing
            ? AnimeBookmarkItem(
                landspaceImage: listAnimeItem[index].landspaceImage!,
                movieName: listAnimeItem[index].movieName!,
                isBookmarked: true,
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
              )
            : AnimeBookmarkItem(
                landspaceImage: listAnimeItem[index].landspaceImage!,
                movieName: listAnimeItem[index].movieName!,
                isBookmarked: true,
              );
      },
    );
  }

  Widget _buildComicList() {
    if (listComicItem.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset('assets/images/empty-box.png'),
            Text(
              'Chưa có bộ truyện nào',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Hãy thêm truyện vào danh sách yêu thích của bạn',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: listComicItem.length,
      itemBuilder: (context, index) {
        return isEditing
            ? ComicBookmarkItem(
                landspaceImage: listComicItem[index].landspaceImage!,
                comicName: listComicItem[index].comicName!,
                isBookmarked: true,
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
              )
            : ComicBookmarkItem(
                landspaceImage: listComicItem[index].landspaceImage!,
                comicName: listComicItem[index].comicName!,
                isBookmarked: true,
              );
      },
    );
  }

  void _deleteSelectedItems() async {
    const userId = '662777d1ba7dff5ac56f1729'; // Replace with actual user ID
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
