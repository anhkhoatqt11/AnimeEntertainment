// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  String id;
  String username;
  Map<String, String> authentication;
  String avatar;
  int coinPoint;
  final Map<String, dynamic> bookmarkList;
  final Map<String, dynamic> histories;
  final List paymentHistories;
  int notificationSentCount = 0;
  Map<String, dynamic> questLog;
  User(
      {required this.id,
      required this.username,
      required this.authentication,
      required this.avatar,
      required this.coinPoint,
      required this.notificationSentCount,
      required this.bookmarkList,
      required this.histories,
      required this.paymentHistories,
      required this.questLog});
}
