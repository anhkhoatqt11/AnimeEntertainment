import 'package:anime_and_comic_entertainment/pages/home/search_result_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
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
        elevation: 0,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Tìm kiếm phim, anime, comic, diễn viên, ...",
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
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
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tìm Kiếm Gần Đây",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    _clearAllSearchHistory();
                  },
                  child: Text(
                    "Xoá hết",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _searchHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
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
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                '${_searchHistory[index]}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              _removeSearchQuery(_searchHistory[index]);
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
