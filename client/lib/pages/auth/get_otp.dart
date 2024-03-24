// ignore_for_file: use_build_context_synchronously

import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/pages/auth/otp_verify_page.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class GetOTPPage extends StatefulWidget {
  final int index;
  const GetOTPPage({required this.index, super.key});

  @override
  State<GetOTPPage> createState() => _GetOTPPageState();
}

class _GetOTPPageState extends State<GetOTPPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');

    return Scaffold(
      extendBodyBehindAppBar: true,
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
      ),
      body: Stack(alignment: AlignmentDirectional.center, children: [
        Image.asset(
          'assets/images/comiclist.jpg',
          height: double.infinity,
          width: double.infinity,
          repeat: ImageRepeat.repeatY,
        ),
        Opacity(
          opacity: 0.8,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logoImage.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.index == 0 ? "Quên mật khẩu" : "Sign-up",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              widget.index == 0
                  ? "Nhập số điện thoại đã đăng ký để lấy lại mật khẩu"
                  : "Đăng ký tài khoản mới",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 8),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InternationalPhoneNumberInput(
                        cursorColor: Colors.white,
                        inputBorder: InputBorder.none,
                        textStyle: const TextStyle(color: Colors.white),
                        countrySelectorScrollControlled: false,
                        onInputChanged: (PhoneNumber number) {
                          _phoneNumber = number;
                        },
                        onInputValidated: (bool value) {},
                        errorMessage: "Số điện thoại không hợp lệ",
                        autoValidateMode: AutovalidateMode.disabled,
                        ignoreBlank: false,
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          useBottomSheetSafeArea: true,
                        ),
                        selectorTextStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 14),
                        initialValue: _phoneNumber,
                        textFieldController: TextEditingController(),
                        inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Số điện thoại",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 14)),
                        formatInput: false,
                      ),
                      const Divider(
                        height: .5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GradientButton(
                        disabled: false,
                        content: 'Xác nhận',
                        action: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.index == 0) {
                              var exist = await AuthApi.checkAccount(
                                  context, _phoneNumber.phoneNumber);
                              if (!exist) {
                                showDialog(
                                    context: context,
                                    builder: (_) => CustomAlertDialog(
                                          content:
                                              "Số điện thoại này chưa được đăng ký",
                                          title: "Thông báo",
                                          action: () {},
                                        ));
                                return;
                              }
                            }
                            var result = await AuthApi.getOTP(
                                context, _phoneNumber.phoneNumber);
                            if (result != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OTPVerifyPage(
                                          otpHash: result['data'],
                                          mobileNo: _phoneNumber.phoneNumber,
                                          index: widget.index,
                                        )),
                              );
                            }
                          }
                        },
                        height: 50,
                        width: 200,
                      ),
                    ],
                  )),
            )
          ],
        ),
        widget.index == 1
            ? (Positioned(
                bottom: 20,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Đã có tài khoản?",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Đăng nhập ngay",
                          style: TextStyle(
                              color: Utils.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
              ))
            : Container()
      ]),
    );
  }
}
