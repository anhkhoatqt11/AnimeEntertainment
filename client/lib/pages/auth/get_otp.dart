import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/auth/otp_verify_page.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class GetOTPPage extends StatefulWidget {
  const GetOTPPage({super.key});

  @override
  State<GetOTPPage> createState() => _GetOTPPageState();
}

class _GetOTPPageState extends State<GetOTPPage> {
  @override
  Widget build(BuildContext context) {
    String mobileNo = "";
    bool isAPICallProcess = false;
    bool passwordVisible = false;
    final myControllerPhone = TextEditingController();
    final myControllerPass = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    // Store the selected phone number and ISO code
    PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');
    @override
    void initState() {
      super.initState();
      passwordVisible = true;
    }

    @override
    void dispose() {
      myControllerPhone.dispose();
      myControllerPass.dispose();
      super.dispose();
    }

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
              'assets/images/logoImage.png',
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Quên mật khẩu",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Nhập số điện thoại đã đăng ký để lấy lại mật khẩu",
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
                        textStyle: TextStyle(color: Colors.white),
                        countrySelectorScrollControlled: false,
                        onInputChanged: (PhoneNumber number) {
                          _phoneNumber = number;
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        errorMessage: "Số điện thoại không hợp lệ",
                        autoValidateMode: AutovalidateMode.disabled,
                        ignoreBlank: false,
                        selectorConfig: SelectorConfig(
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
                      SizedBox(
                        height: 20,
                      ),
                      GradientButton(
                        content: 'Xác nhận',
                        action: () {
                          _formKey.currentState?.validate();
                        },
                        height: 50,
                        width: 200,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ]),
    );
    // return Container(
    //   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    //     Image.network(
    //       "sss",
    //       height: 180,
    //       fit: BoxFit.contain,
    //     ),
    //     Text('Login with mobile phone number'),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Enter phone number"),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Flexible(
    //               child: Container(
    //             height: 47,
    //             width: 50,
    //             margin: const EdgeInsets.fromLTRB(0, 10, 3, 30),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(4),
    //                 border: Border.all(color: Colors.grey)),
    //             child: Center(
    //                 child: Text(
    //               "+91",
    //               style: TextStyle(
    //                   color: Colors.black, fontWeight: FontWeight.bold),
    //             )),
    //           )),
    //           Flexible(
    //             flex: 5,
    //             child: TextFormField(
    //               maxLines: 1,
    //               maxLength: 10,
    //               decoration: const InputDecoration(
    //                 contentPadding: EdgeInsets.all(6),
    //                 hintText: "Mobile phone",
    //                 enabledBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(color: Colors.grey, width: 1)),
    //                 border: OutlineInputBorder(
    //                     borderSide: BorderSide(color: Colors.grey, width: 1)),
    //                 focusedBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(color: Colors.black, width: 1)),
    //               ),
    //               keyboardType: TextInputType.number,
    //               onChanged: (String value) {
    //                 if (value.length > 9) {
    //                   mobileNo = value;
    //                 }
    //               },
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //     Center(
    //         child: ElevatedButton(
    //       child: Text("Submit"),
    //       onPressed: () async {
    //         if (mobileNo.length > 9) {
    //           setState(() {
    //             isAPICallProcess = true;
    //           });
    //         }

    //         var result = await AuthApi.getOTP(mobileNo);
    //         setState(() {
    //           isAPICallProcess = false;
    //         });
    //         print(result['data']);
    //         if (result != null) {
    //           Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => OTPVerifyPage(
    //                       otpHash: result['data'], mobileNo: mobileNo)),
    //               (route) => false);
    //         }
    //       },
    //     ))
    //   ]),
    // );
  }
}
