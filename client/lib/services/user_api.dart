import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://localhost:5000/api/users/";

  static addUser(Map pdata) async {
    var url = Uri.parse("${baseUrl}createUser");
    try {
      final res = await http.post(
        url,
        body: pdata,
      );
      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("Failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getUsers() async {
    List<User> users = [];
    var url = Uri.parse(
      "${baseUrl}getAllUsers",
    );
    try {
      final res = await http.get(url);
      print(jsonDecode(res.body));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) => {
              users.add(User(
                  id: value['id'].toString(),
                  name: value['name'],
                  total: value['total'],
                  payed: value['payed'],
                  debt: value['debt']))
            });
        return users;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getUser(id) async {
    var url = Uri.parse(
      "${baseUrl}getUser/$id",
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

  static updateUser(id, body) async {
    var url = Uri.parse("${baseUrl}updateUser/$id");
    try {
      final res = await http.patch(url, body: body);
      if (res.statusCode == 200) {
        print(jsonDecode(res.body));
      } else {
        print("Failed to update");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static deleteProduct(id) async {
    var url = Uri.parse("${baseUrl}deleteUser/$id");
    try {
      final res = await http.delete(url);
      if (res.statusCode == 200) {
        print(jsonDecode(res.body));
      } else {
        print("Failed to delete");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
