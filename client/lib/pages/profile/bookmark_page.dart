import 'package:anime_and_comic_entertainment/components/AnimeBookmarkItem.dart';
import 'package:anime_and_comic_entertainment/components/ComicBookmarkItem.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
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
                  landspaceImage: item['landspaceImage'],
                  movieName: item['movieName'],
                ))
            .toList();
        listComicItem = (result['comics'] as List)
            .map((item) => Comics(
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
                child: Text(isEditing ? "Xong" : "Sửa"),
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
        floatingActionButton: isEditing
            ? FloatingActionButton(
                onPressed: () {
                  _deleteSelectedItems();
                },
                child: Icon(Icons.delete),
              )
            : null,
      ),
    );
  }

  Widget _buildAnimeList() {
    if (listAnimeItem.isEmpty) {
      return Center(
        child: Text('No bookmarked anime'),
      );
    }
    return ListView.builder(
      itemCount: listAnimeItem.length,
      itemBuilder: (context, index) {
        return isEditing
            ? CheckboxListTile(
                title: Text(listAnimeItem[index].movieName!),
                value: selectedAnimeIndexes.contains(index),
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
        child: Text('No bookmarked comics'),
      );
    }
    return ListView.builder(
      itemCount: listComicItem.length,
      itemBuilder: (context, index) {
        return isEditing
            ? CheckboxListTile(
                title: Text(listComicItem[index].comicName!),
                value: selectedComicIndexes.contains(index),
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

  void _deleteSelectedItems() {
    setState(() {
      // Delete selected anime items
      for (var index in selectedAnimeIndexes) {
        listAnimeItem.removeAt(index);
      }
      // Delete selected comic items
      for (var index in selectedComicIndexes) {
        listComicItem.removeAt(index);
      }
      // Clear selected indexes
      selectedAnimeIndexes.clear();
      selectedComicIndexes.clear();
    });
  }
}
