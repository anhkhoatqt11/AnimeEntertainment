import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  bool _expanded = false;


  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat('yyyy-MM-dd hh:mm:ss').parse(widget.orderDate!);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy hh:mm:ss');
    String orderDate = dateFormat.format(date);
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/skycoin.png",
                    width: 28,
                    height: 28,
                  ),
                  const SizedBox(width: 10),
                  Text("Giao dịch nạp SkyCoin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: _buildPaymentMethodIcon(widget.paymentMethod),
                title: Text(
                  widget.paymentMethod!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: Text(
                  _buildPaymentStatus(widget.status!),
                  style: TextStyle(
                    color: _getStatusColor(widget.status),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_expanded) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền: ${formatCurrency(widget.price)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'ID:${widget.packageId!}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          'Ngày thực hiện: ${orderDate}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

// Helper method to build payment method icon
  Widget _buildPaymentMethodIcon(String? paymentMethod) {
    IconData iconData;
    switch (paymentMethod) {
      case 'VNPay':
        return Image.asset(
          "assets/images/VNPayLogo.png",
          width: 28,
          height: 28,
        );
      case 'ZaloPay':
        return Image.asset(
          "assets/images/ZaloPayLogo.png",
          width: 28,
          height: 28,
        );
      default:
        iconData = Icons.payment;
    }
    return Icon(iconData, color: Colors.white);
  }

  // Helper method to determine status color
  Color _getStatusColor(String? status) {
    switch (status) {
      case 'completed':
        return Utils.greenColor;
      case 'pending':
        return Utils.blueColor;
      case 'Failed':
        return Colors.red;
      default:
        return Colors.white!;
    }
  }

  String _buildPaymentStatus(String? status) {
    switch (status) {
      case 'completed':
        return 'Thành công';
      case 'pending':
        return 'Đang xử lý';
      case 'Failed':
        return 'Thất bại';
      default:
        return 'Không xác định';
    }
  }

  formatCurrency(int? price) {
    final formatter = NumberFormat("#,### VND", "vi_VN");
    return formatter.format(price);
  }
}
