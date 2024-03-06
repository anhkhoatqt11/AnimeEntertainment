import 'package:anime_and_comic_entertainment/services/stripe_services.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  StripePaymentService _paymentService = StripePaymentService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black87,
        child: Column(children: [
          ElevatedButton(
              onPressed: () {
                _paymentService.makePayment(context, 200.00);
              },
              child: Text('BUY NOW')),
        ]),
      ),
    );
  }
}
