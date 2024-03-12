import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  final String? id;
  final String? username;
  final String? email;
  Map<String, String> authentication;
  final String? avatar;
  final int? coinPoint;
  final Object bookmarkList;
  final Object histories;
  final List paymentHistories;
  User({
    this.id,
    this.username,
    this.email,
    required this.authentication,
    this.avatar,
    this.coinPoint,
    required this.bookmarkList,
    required this.histories,
    required this.paymentHistories,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'username': username,
  //     'email': email,
  //     'authentication': authentication,
  //     'avatar': avatar,
  //     'coinPoint': coinPoint,
  //     'bookmarkList': bookmarkList,
  //     'histories': histories,
  //     'paymentHistories': paymentHistories,
  //   };
  // }

  // factory User.fromMap(Map<String, dynamic> map) {
  //   return User(
  //       id: map['id'] != null ? map['id'] as String : null,
  //       username: map['username'] != null ? map['username'] as String : null,
  //       email: map['email'] != null ? map['email'] as String : null,
  //       authentication:
  //           map['authentication'] != null ? map['authentication'] : null,
  //       avatar: map['avatar'] != null ? map['avatar'] as String : null,
  //       coinPoint: map['coinPoint'] != null ? map['coinPoint'] as int : null,
  //       bookmarkList: map['bookmarkList'] != null ? map['bookmarkList'] : null,
  //       histories: map['histories'] != null ? map['histories'] : null,
  //       paymentHistories: List.from(
  //         (map['paymentHistories'] as List),
  //       ));
  // }

  // String toJson() => json.encode(toMap());

  // factory User.fromJson(String source) =>
  //     User.fromMap(json.decode(source) as Map<String, dynamic>);
}
