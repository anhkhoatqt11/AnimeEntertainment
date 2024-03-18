// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/auth/get_otp.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:getwidget/getwidget.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  final myControllerPass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
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
              "Sign-in",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Đăng nhập để tiếp tục trải nghiệm nào",
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
                        onInputValidated: (bool value) {},
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
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: myControllerPass,
                          obscureText: passwordVisible,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Mật khẩu",
                            hintStyle: TextStyle(color: Colors.grey[400]),

                            focusColor: Colors.white,

                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            // alignLabelWithHint: false,
                            // filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập mật khẩu";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GradientButton(
                        disabled: false,
                        content: 'Đăng nhập',
                        action: () async {
                          _formKey.currentState?.validate();
                          if (_formKey.currentState!.validate()) {
                            if (myControllerPass.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Vui lòng nhập mật khẩu')),
                              );
                              return;
                            }
                            await AuthApi.login(
                                context,
                                _phoneNumber.phoneNumber,
                                myControllerPass.text);
                          }
                        },
                        height: 50,
                        width: 200,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetOTPPage(
                                      index: 0,
                                    )),
                          );
                        },
                        child: Text(
                          "Quên mật khẩu",
                          style: TextStyle(
                              color: Utils.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
        Positioned(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              "Chưa có tài khoản?",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetOTPPage(
                              index: 1,
                            )));
              },
              child: Text(
                "Đăng ký ngay",
                style: TextStyle(
                    color: Utils.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            )
          ]),
          bottom: 20,
        )
      ]),
    );
  }
}

class LoginOrProfileComponent extends StatefulWidget {
  const LoginOrProfileComponent({super.key});

  @override
  State<LoginOrProfileComponent> createState() =>
      _LoginOrProfileComponentState();
}

class _LoginOrProfileComponentState extends State<LoginOrProfileComponent> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context)
                .user
                .authentication['sessionToken'] !=
            ""
        ? Container(
            child: Text("Logout"),
          )
        : Container(
            child: ElevatedButton(
                onPressed: () async {
                  await AuthApi.login(context, "antonio@gmail.com", "123");
                },
                child: Text('Log in')),
          );
  }
}
