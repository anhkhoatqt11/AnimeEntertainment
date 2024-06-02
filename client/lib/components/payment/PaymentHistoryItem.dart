import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  @override
  Widget build(BuildContext context) {
    DateTime date = DateFormat('yyyy-MM-dd hh:mm:ss').parse(widget.orderDate!);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy hh:mm:ss');
    String orderDate = dateFormat.format(date);
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.payment_rounded,
                      color: Utils.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Text(
                        widget.paymentMethod == "BuyComicChapter" ||
                                widget.paymentMethod == "Donation"
                            ? 'Giao dịch sử dụng SkyCoin'
                            : 'Giao dịch nạp SkyCoin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                Row(
                  children: [
                    FaIcon(
                      widget.status == "completed"
                          ? FontAwesomeIcons.circleCheck
                          : widget.status == "pending"
                              ? FontAwesomeIcons.hourglassHalf
                              : FontAwesomeIcons.circleXmark,
                      color: _getStatusColor(widget.status),
                      size: 14,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      _buildPaymentStatus(widget.status!),
                      style: TextStyle(
                        color: _getStatusColor(widget.status),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: _buildPaymentMethodIcon(widget.paymentMethod),
              title: Text(
                widget.paymentMethod! == "BuyComicChapter"
                    ? "Mua chương truyện"
                    : widget.paymentMethod == "Donation"
                        ? "Đóng góp quỹ"
                        : widget.paymentMethod!,
                style: TextStyle(
                  color: Utils.accentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                widget.paymentMethod == "BuyComicChapter" ||
                        widget.paymentMethod == "Donation"
                    ? 'Thanh toán: ${widget.price} SkyCoin'
                    : 'Thanh toán: ${formatCurrency(widget.price)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.clock,
                  color: Colors.grey[500],
                  size: 12,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  orderDate,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[600],
              thickness: .5,
            )
          ],
        ),
      ),
    );
  }

// Helper method to build payment method icon
  Widget _buildPaymentMethodIcon(String? paymentMethod) {
    IconData iconData;
    switch (paymentMethod) {
      case 'VNPay':
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            "assets/images/vnpay.jpg",
            width: 50,
            height: 50,
          ),
        );
      case 'ZaloPay':
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            "assets/images/zalopay.png",
            width: 50,
            height: 50,
          ),
        );
      default:
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            "assets/images/skycoin.png",
            width: 50,
            height: 50,
          ),
        );
    }
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
        return Colors.white;
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
