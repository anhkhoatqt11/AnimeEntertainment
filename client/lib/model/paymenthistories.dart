class PaymentHistories {
  final String? id;
  final String? userId;
  final DateTime? orderDate;
  final String? paymentMethod;
  final String? status;
  final int? price;
  final String? packageId;

  PaymentHistories(
      {this.id,
      this.userId,
      this.orderDate,
      this.paymentMethod,
      this.status,
      this.price,
      this.packageId});
}
