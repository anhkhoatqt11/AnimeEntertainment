import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentHistoryItem extends StatefulWidget {
  final String? orderDate;
  final String? paymentMethod;
  final String? status;
  final int? price;
  final String? packageId;

  const PaymentHistoryItem({
    Key? key,
    this.orderDate,
    this.paymentMethod,
    this.status,
    this.price,
    this.packageId,
  }) : super(key: key);

  @override
  State<PaymentHistoryItem> createState() => _PaymentHistoryItemState();
}

class _PaymentHistoryItemState extends State<PaymentHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.orderDate!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            ListTile(
              leading: _buildPaymentMethodIcon(widget.paymentMethod),
              title: Text(
                widget.paymentMethod!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              trailing: Text(
                widget.status!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.price}\đ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build payment method icon
  Widget _buildPaymentMethodIcon(String? paymentMethod) {
    IconData iconData;
    switch (paymentMethod) {
      case 'Credit Card':
        iconData = Icons.credit_card;
        break;
      case 'PayPal':
        iconData = Icons.payment;
        break;
      default:
        iconData = Icons.payment;
    }
    return Icon(iconData);
  }
}
