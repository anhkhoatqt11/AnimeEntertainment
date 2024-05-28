import 'package:anime_and_comic_entertainment/components/payment/PaymentHistoryItem.dart';
import 'package:anime_and_comic_entertainment/model/paymenthistories.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/payment_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:provider/provider.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  List<PaymentHistories> listPaymentHistory = [];
  bool hasData = true;
  late String userId = "";

  @override
  void initState() {
    super.initState();
    fetchPaymentHistory();
  }

  Future<void> fetchPaymentHistory() async {
    try {
      final result = await PaymentApi.getUserPaymentHistories(context, "662777d1ba7dff5ac56f1729");
      setState(() {
        listPaymentHistory = (result as List)
            .map((item) => PaymentHistories(
                  id: item.id,
                  userId: item.userId,
                  orderDate: item.orderDate,
                  paymentMethod: item.paymentMethod,
                  status: item.status,
                  price: item.price,
                  packageId: item.packageId,
                ))
            .toList();
      });
    } catch (e) {
      print('Error fetching payment history list: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
        backgroundColor: const Color(0xFF141414),
        elevation: 0,
        title: Center(
          child: Text(
            "Lịch sử giao dịch",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Center(
        child: listPaymentHistory.isEmpty
            ? CircularProgressIndicator() // Show a loading indicator while fetching data
            : ListView.builder(
                itemCount: listPaymentHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return PaymentHistoryItem(
                    orderDate: listPaymentHistory[index].orderDate.toString(),
                    paymentMethod: listPaymentHistory[index].paymentMethod,
                    status: listPaymentHistory[index].status,
                    price: listPaymentHistory[index].price,
                    packageId: listPaymentHistory[index].packageId,
                  );
                },
              ),
      ),
    );
  }
}
