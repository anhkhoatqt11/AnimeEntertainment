import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:pinput/pinput.dart';

class OTPVerifyPage extends StatefulWidget {
  final String? mobileNo;
  final String? otpHash;

  const OTPVerifyPage({this.mobileNo, this.otpHash});

  @override
  State<OTPVerifyPage> createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  String _otpCode = "";
  final int _otpCodeLength = 4;
  bool isAPICallProcess = false;
  late FocusNode myFocusNode;

  bool passwordVisible = false;
  final myControllerPhone = TextEditingController();
  final myControllerPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    // return Container(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Image.network(
    //         "",
    //         height: 100,
    //         fit: BoxFit.contain,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 20),
    //         child: Text(
    //           "OTP Verification",
    //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Center(
    //         child: Text(
    //           "Enter OTP code sent to your mobile",
    //           textAlign: TextAlign.center,
    //           style: TextStyle(fontSize: 14),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),

    //       ElevatedButton(onPressed: () {}, child: Text("Verify"))
    //     ],
    //   ),
    // );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GFAppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GFIconButton(
          splashColor: Colors.transparent,
          icon: Icon(
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
            SizedBox(
              height: 10,
            ),
            Text(
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
                      validator: (s) {
                        return s == '2222' ? null : 'Pin is incorrect';
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GradientButton(
                      content: 'Tiếp tục',
                      action: () {
                        // _formKey.currentState?.validate();
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

  @override
  void dispose() {
    myFocusNode.dispose();
    myControllerPhone.dispose();
    myControllerPass.dispose();
    super.dispose();
  }
}
