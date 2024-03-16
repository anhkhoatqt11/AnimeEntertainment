// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:getwidget/getwidget.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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

  @override
  Widget build(BuildContext context) {
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
              "Sign-up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Đăng ký tài khoản mới",
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
                      Divider(
                        thickness: .51,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GradientButton(
                        content: 'Đăng ký',
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
        Positioned(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              "Đã có tài khoản?",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
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
          bottom: 20,
        )
      ]
          // width: double.infinity,
          // height: double.infinity,
          // color: Colors.blue,
          // child: Column(children: [
          //   ElevatedButton(
          //       onPressed: () async {
          //         await AuthApi.getLogin(context);
          //       },
          //       child: Text(textting)),
          //   ElevatedButton(
          //       onPressed: () async {
          //         var result = await AuthApi.login(context, "0123456789", "123");
          //         setState(() {
          //           textting = "hehe";
          //         });
          //       },
          //       child: Text('Sign in'))
          // ]),
          ),
    );
  }
}
