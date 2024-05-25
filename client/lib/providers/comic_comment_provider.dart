import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComicCommentProvider extends ChangeNotifier {
  bool _isValidContent = true;
  bool get isValidContent => _isValidContent;
  DateTime _commentAccessDate = DateTime(1980);
  DateTime get commentAccessDate => _commentAccessDate;
  String get formattedDate =>
      DateFormat('dd/MM/yyyy HH:mm:ss').format(_commentAccessDate);

  Future<void> checkValidContent(String content) async {
    var result = await ComicsApi.checkValidCommentContent(content);
    _isValidContent = result.toString().contains('true');
    notifyListeners();
  }

  Future<void> checkUserBanned(BuildContext context, String userId) async {
    var res = await ComicsApi.checkUserBan(context, userId);

    if (res.toString().contains('2020')) {
      _commentAccessDate = DateTime.now();
      notifyListeners();
      return;
    }

    _commentAccessDate = DateTime.parse(res);
    notifyListeners();
  }

  Future<void> banUser(BuildContext context, String userId) async {
    await ComicsApi.banUser(context, userId);
    notifyListeners();
  }

  Future<void> addRootComment(
      BuildContext context, chapterId, userId, String content) async {
    if (content.isEmpty) return;
    await ComicsApi.addRootChapterComment(context, chapterId, userId, content);
    notifyListeners();
  }

  Future<void> addChildComment(
      BuildContext context, chapterId, commentId, userId, content) async {
    if (content.isEmpty) return;
    await ComicsApi.addChildChapterComment(
        context, chapterId, commentId, userId, content);
    notifyListeners();
  }
}
