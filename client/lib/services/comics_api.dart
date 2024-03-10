import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComicsApi {
  static const baseUrl = "http://192.168.27.2:5000/api/comics/";

  static getComic(id) async {
    var url = Uri.parse(
      "${baseUrl}getComic/$id",
    );
    try {
      final res = await http.get(url);
      print(jsonDecode(res.body));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getComics() async {
    List<Comics> comics = [];
    var url = Uri.parse(
      "${baseUrl}getAllComics",
    );
    try {
      final res = await http.get(url);
      print(jsonDecode(res.body));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) => {
              comics.add(Comics(
                coverImage: value['coverImage'],
                comicName: value['comicName'],
                author: value['author'],
                artist: value['artist'],
                genres: value['genres'],
                ageFor: value['ageFor'],
                publisher: value['publisher'],
                description: value['description'],
                newChapterTime: value['newChapterTime'],
                chapterList: value['chapterList'],
              ))
            });
        return comics;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getChapterComic(id) async {
    var url = Uri.parse(
      "${baseUrl}getChapterComic/$id",
    );
    try {
      final res = await http.get(url);
      print(jsonDecode(res.body));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
