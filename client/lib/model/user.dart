// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  final String? id;
  final String username;
  Map<String, String> authentication;
  final String avatar;
  final int coinPoint;
  final Map<String, dynamic> bookmarkList;
  final Map<String, dynamic> histories;
  final List paymentHistories;
  User({
    this.id,
    required this.username,
    required this.authentication,
    required this.avatar,
    required this.coinPoint,
    required this.bookmarkList,
    required this.histories,
    required this.paymentHistories,
  });
}
