// ignore_for_file: use_build_context_synchronously

import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/auth/password_page.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:pinput/pinput.dart';

class OTPVerifyPage extends StatefulWidget {
  final String? mobileNo;
  final String? otpHash;
  final int? index;

  const OTPVerifyPage({this.mobileNo, this.otpHash, this.index});

  @override
  State<OTPVerifyPage> createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  String _otpCode = "";

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Utils.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

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
              'assets/images/otpicon.png',
              height: 150,
              width: 150,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Xác nhận OTP",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Vui lòng nhập mã OTP đã được gửi tới điện thoại của bạn",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 8),
                child: Column(
                  children: [
                    Pinput(
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => _otpCode = pin,
                      onChanged: (pin) => _otpCode = pin,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GradientButton(
                      disabled: false,
                      content: 'Tiếp tục',
                      action: () async {
                        var result = await AuthApi.verify(
                            context, widget.mobileNo, widget.otpHash, _otpCode);
                        if (result['data'] == 'Success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PasswordPage(
                                      mobileNo: widget.mobileNo,
                                      index: widget.index,
                                    )),
                          );
                          return;
                        } else {
                          _otpCode = "";
                          showDialog(
                              context: context,
                              builder: (_) => CustomAlertDialog(
                                    content: result['data'],
                                    title: "Thông báo",
                                    action: () {},
                                  ));
                        }
                      },
                      height: 50,
                      width: 200,
                    ),
                  ],
                )),
          ],
        ),
      ]),
    );
  }
}
