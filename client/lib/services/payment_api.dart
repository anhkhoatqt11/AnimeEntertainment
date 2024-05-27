import 'dart:convert';
import 'package:anime_and_comic_entertainment/model/paymenthistories.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:provider/provider.dart';

class PaymentApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/payment/";

  static Future<List<PaymentHistories>> getUserPaymentHistories(
      BuildContext context, String userId) async {
    var url = Uri.parse("${baseUrl}getPaymentHistoriesByUserId?userId=$userId");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);
        List<PaymentHistories> paymentHistories = [];
        result.forEach((element) {
          paymentHistories.add(PaymentHistories(
            id: element['id'],
            userId: element['userId'],
            orderDate: DateTime.parse(element['orderDate']),
            paymentMethod: element['paymentMethod'],
            status: element['status'],
            price: element['price'],
            packageId: element['packageId'],
          ));
        });
        return paymentHistories;
      } else {
        return []; // Return an empty list if there's no data
      }
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (!Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
      // Return an empty list in case of an error
      return [];
    }
  }
}
