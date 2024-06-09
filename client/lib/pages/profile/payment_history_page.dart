import 'package:anime_and_comic_entertainment/components/payment/PaymentHistoryItem.dart';
import 'package:anime_and_comic_entertainment/model/paymenthistories.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/payment_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';
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
      var userID = Provider.of<UserProvider>(context, listen: false).user.id;
      final result = await PaymentApi.getUserPaymentHistories(context, userID);
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GFIconButton(
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            type: GFButtonType.transparent,
          ),
          centerTitle: true,
          title: const Text(
            "Lịch sử giao dịch",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          )),
      body: Center(
        child: listPaymentHistory.isEmpty
            ? const Center(
                child: GFLoader(type: GFLoaderType.circle),
              )
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
