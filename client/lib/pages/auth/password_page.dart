// ignore_for_file: use_build_context_synchronously

import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/auth/get_otp.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class PasswordPage extends StatefulWidget {
  final String? mobileNo;
  final int? index;

  const PasswordPage({this.mobileNo, this.index});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  bool passwordVisible = false;
  bool passwordConfirmVisible = false;
  final myControllerPass = TextEditingController();
  final myControllerPassConfirm = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordConfirmVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              'assets/images/verifyicon.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Hoàn thành",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Nhập mật khẩu cho tài khoản của bạn",
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
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: myControllerPass,
                          obscureText: passwordVisible,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: myControllerPassConfirm,
                          obscureText: passwordConfirmVisible,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            hintText: "Xác nhận mật khẩu",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            focusColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: Icon(passwordConfirmVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordConfirmVisible =
                                        !passwordConfirmVisible;
                                  },
                                );
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng xác nhận mật khẩu";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Mật khẩu phải có tối thiểu 6 kí tự và \n • 1 kí tự in hoa \n • 1 kí tự số \n • 1 kí tự đặc biệt",
                          style:
                              TextStyle(color: Colors.grey[300], fontSize: 12),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GradientButton(
                        disabled: false,
                        content: 'Xác nhận',
                        action: () async {
                          if (_formKey.currentState!.validate()) {
                            if (Utils.validatePassword(myControllerPass.text)
                                .isEmpty) {
                              if (myControllerPass.text !=
                                  myControllerPassConfirm.text) {
                                showDialog(
                                    context: context,
                                    builder: (_) => CustomAlertDialog(
                                          content:
                                              "Mật khẩu xác nhận không khớp. Vui lòng kiểm tra lại.",
                                          title: "Thông báo",
                                          action: () {},
                                        ));
                              } else {
                                var result = widget.index == 0
                                    ? await AuthApi.updatePassword(context,
                                        widget.mobileNo, myControllerPass.text)
                                    : await AuthApi.register(context,
                                        widget.mobileNo, myControllerPass.text);
                                if (result == false) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => CustomAlertDialog(
                                            content: widget.index == 0
                                                ? "Quá trình phát sinh lỗi, vui lòng kiểm tra lại"
                                                : "Tài khoản đã tồn tại, vui lòng đăng ký tài khoản khác",
                                            title: 'Thông báo',
                                            action: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Login()),
                                              );
                                            },
                                          ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => CustomAlertDialog(
                                            content:
                                                "Hoàn tất quá trình, vui lòng đăng nhập lại",
                                            title: 'Thông báo',
                                            action: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const GetOTPPage(
                                                          index: 0,
                                                        )),
                                              );
                                            },
                                          ));
                                }
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => CustomAlertDialog(
                                        content: Utils.validatePassword(
                                            myControllerPass.text),
                                        title: "Thông báo",
                                        action: () {},
                                      ));
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
      ]),
    );
  }

  @override
  void dispose() {
    myControllerPassConfirm.dispose();
    myControllerPass.dispose();
    super.dispose();
  }
}
