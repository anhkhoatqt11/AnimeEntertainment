import 'package:anime_and_comic_entertainment/model/genre.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_genre_result_page.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_result_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchHistory = [];
  late bool isLoading = true;
  List<dynamic> listGenre = [];
  Future<List<Genre>> getGenres() async {
    var result = await AnimesApi.getGenres(context);
    return result;
  }

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
    getGenres().then((value) => setState(() {
          print(value);
          listGenre = value;
          isLoading = false;
        }));
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory.clear();
      _searchHistory.addAll(prefs.getStringList('searchHistory') ?? []);
    });
  }

  Future<void> _saveSearchHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_searchHistory.contains(query)) {
      final updatedHistory = List<String>.from(_searchHistory)
        ..insert(0, query);
      await prefs.setStringList('searchHistory', updatedHistory);
      setState(() {
        _searchHistory.clear();
        _searchHistory.addAll(updatedHistory);
      });
    }
  }

  void _removeSearchQuery(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedHistory = List<String>.from(_searchHistory)..remove(query);
    await prefs.setStringList('searchHistory', updatedHistory);
    setState(() {
      _searchHistory.clear();
      _searchHistory.addAll(updatedHistory);
    });
  }

  void _clearAllSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('searchHistory');
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
        backgroundColor: const Color(0xFF141414),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            GFIconButton(
              size: GFSize.SMALL,
              splashColor: Colors.transparent,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () {
                Provider.of<NavigatorProvider>(context, listen: false)
                    .setShow(true);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              type: GFButtonType.transparent,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 20,
                  ),
                  hintText: "Tìm kiếm phim, anime, comic, diễn viên, ...",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    _saveSearchHistory(query);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultPage(
                          searchWord: query,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tìm Kiếm Gần Đây",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    _clearAllSearchHistory();
                  },
                  child: const Text(
                    "Xoá hết",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: _searchHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          String query = _searchHistory[index];
                          _saveSearchHistory(query);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultPage(
                                searchWord: query,
                              ),
                            ),
                          );
                        },
                        child: _buildHistoryItem(index),
                      ),
                      !isLoading && index == _searchHistory.length - 1
                          ? Wrap(
                              spacing: 8.0,
                              children: List.generate(
                                listGenre.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SearchGenreResultPage(
                                          genreId: listGenre[index].id,
                                          genreName: listGenre[index].genreName,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Chip(
                                    label: Text(
                                      listGenre[index].genreName,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    backgroundColor: const Color(0xFF282727),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                  ),
                                ),
                              ))
                          : const SizedBox.shrink()
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(int index) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _searchHistory[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  _removeSearchQuery(_searchHistory[index]);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            thickness: .5,
          ),
        ],
      ),
    );
  }
}
