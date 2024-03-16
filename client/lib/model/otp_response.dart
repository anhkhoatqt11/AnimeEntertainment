import 'dart:convert';

OTPResponseModel otpResponseModel(String str) =>
    OTPResponseModel.fromJson(json.decode(str));

class OTPResponseModel {
  OTPResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final String? data;

  OTPResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }
}
