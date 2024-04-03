// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/main.dart';
import 'package:anime_and_comic_entertainment/pages/home/home_page.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/pages/test.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/auth/";

  static login(BuildContext context, String? phone, String? password) async {
    var url = Uri.parse(
      "${baseUrl}login",
    );
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    final navigator = Navigator.of(context);
    var body = {"phone": phone, "password": password};
    try {
      final res = await http.post(url, body: body);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userProvider.setUserToken(data['authentication']['sessionToken']);
        userProvider.setUserId(data['_id']);
        await prefs.setString(
            'auth-session-token', data['authentication']['sessionToken']);
        navigator.popUntil((route) => route.isFirst);
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomAlertDialog(
                content: "Thông tin tài khoản không tồn tại",
                title: 'Thông báo',
                action: () {}));
        return null;
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
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
        userProvider.setUserId(jsonDecode(res.body)['id']);
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static register(BuildContext context, String? phone, String? password) async {
    var url = Uri.parse(
      "${baseUrl}register",
    );
    try {
      final res = await http.post(
        url,
        body: {"phone": phone, "password": password},
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth-session-token', '');
    // ignore: use_build_context_synchronously
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUserToken("");
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          title: 'Skylark',
        ),
      ),
      (route) => false,
    );
  }

  static getOTP(BuildContext context, String? mobileNo) async {
    var url = Uri.parse(
      "${baseUrl}getOTP",
    );
    try {
      final res = await http.post(
        url,
        body: {"phone": mobileNo},
      );
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return null;
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static verify(
      BuildContext context, String? mobileNo, String? otpHash, otpCode) async {
    var url = Uri.parse(
      "${baseUrl}verifyOTP",
    );
    try {
      final res = await http.post(
        url,
        body: {"phone": mobileNo, "otp": otpCode, "hash": otpHash},
      );
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return null;
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static checkAccount(BuildContext context, String? phone) async {
    var url = Uri.parse(
      "${baseUrl}findAccount",
    );
    try {
      var body = {"phone": phone};
      final res = await http.post(url, body: body);
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static updatePassword(
      BuildContext context, String? phone, String? password) async {
    var url = Uri.parse(
      "${baseUrl}updatePassword",
    );
    try {
      final res = await http.post(
        url,
        body: {"phone": phone, "password": password},
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }
}
