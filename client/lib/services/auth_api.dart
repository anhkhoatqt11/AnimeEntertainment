import 'dart:convert';

import 'package:anime_and_comic_entertainment/main.dart';
import 'package:anime_and_comic_entertainment/model/user.dart';
import 'package:anime_and_comic_entertainment/pages/home.dart';
import 'package:anime_and_comic_entertainment/pages/login.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static const baseUrl = "http://192.168.56.1:5000/api/auth/";

  static login(BuildContext context, String username, String password) async {
    var url = Uri.parse(
      "${baseUrl}login",
    );
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    var body = {"email": username, "password": password};
    try {
      final res = await http.post(url, body: body);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // userProvider.setUser(res.body);
        await prefs.setString(
            'auth-session-token', data['authentication']['sessionToken']);

        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              title: 'Skylark',
            ),
          ),
          (route) => false,
        );
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getLogin(
    BuildContext context,
  ) async {
    var url = Uri.parse(
      "${baseUrl}autoLogin",
    );
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth-session-token');
      if (token == "") return;
      var body = {"sessionToken": token};
      final res = await http.post(url, body: body);
      if (jsonDecode(res.body)['loggedIn'] == true) {
        userProvider.setUserToken(token.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth-session-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
      (route) => false,
    );
  }
}
