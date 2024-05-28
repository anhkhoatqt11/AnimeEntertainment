import 'package:anime_and_comic_entertainment/components/ui/CoinButton.dart';
import 'package:anime_and_comic_entertainment/pages/auth/get_otp.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/pages/profile/about_us_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/avatar_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/bookmark_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/payment_history_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertChoiceDialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final Uri _url = Uri.parse('https://anime-entertainment-payment.vercel.app/');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -80,
                child: ShaderMask(
                  shaderCallback: (rect) => LinearGradient(
                    colors: Utils.gradientColors,
                    begin: Alignment.bottomCenter,
                  ).createShader(rect),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.06,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white),
                  ),
                ),
              ),
              Consumer(builder: (context, watch, _) {
                final user = Provider.of<UserProvider>(context).user;
                return Positioned(
                  top: 100,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 540,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 40,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    user.authentication['sessionToken'] == ""
                                        ? 400
                                        : 440,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xFF242424))),
                          ),
                          user.authentication['sessionToken'] == ""
                              ? Positioned(
                                  top: 60,
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height: 380,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0),
                                        child: Column(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 94 / 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Image.asset(
                                                  "assets/images/loginbanner.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: GFButton(
                                                    onPressed: () {
                                                      Provider.of<NavigatorProvider>(
                                                              context,
                                                              listen: false)
                                                          .setShow(false);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const GetOTPPage(
                                                                    index: 1,
                                                                  )));
                                                    },
                                                    color: Utils.primaryColor,
                                                    text: "Đăng ký",
                                                    type: GFButtonType.outline,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: GFButton(
                                                    onPressed: () {
                                                      Provider.of<NavigatorProvider>(
                                                              context,
                                                              listen: false)
                                                          .setShow(false);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Login()));
                                                    },
                                                    color: Utils.primaryColor,
                                                    text: "Đăng nhập",
                                                    type: GFButtonType.solid,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                )
                              : Positioned(
                                  top: -60,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 540,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 60),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Stack(
                                              children: [
                                                GFImageOverlay(
                                                  height: 80,
                                                  width: 80,
                                                  border: Border.all(
                                                      color: Utils.primaryColor,
                                                      width: 2),
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Colors.transparent,
                                                          BlendMode.color),
                                                  image:
                                                      NetworkImage(user.avatar),
                                                  boxFit: BoxFit.cover,
                                                ),
                                                Positioned(
                                                  bottom: 4,
                                                  right: 4,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<NavigatorProvider>(
                                                              context,
                                                              listen: false)
                                                          .setShow(false);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const AvatarPage()));
                                                    },
                                                    child: const FaIcon(
                                                      FontAwesomeIcons
                                                          .circlePlus,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                user.username,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const FaIcon(
                                                FontAwesomeIcons
                                                    .solidPenToSquare,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "UserId:",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 11),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      user.id,
                                                      style: TextStyle(
                                                          color: Utils
                                                              .primaryColor,
                                                          fontSize: 11),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "SKY COINS CỦA TÔI",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 13),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/skycoin.png",
                                                              width: 16,
                                                              height: 16,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.8 -
                                                                  190,
                                                              child: Text(
                                                                user.coinPoint ==
                                                                        0
                                                                    ? "Bạn chưa có Skycoins"
                                                                    : "Hiện có ${Utils.formatNumberWithDots(user.coinPoint)} Skycoins",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    CoinButton(
                                                      action: () {
                                                        _launchUrl;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: .5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 4.0, bottom: 4.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<NavigatorProvider>(
                                                              context,
                                                              listen: false)
                                                          .setShow(false);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const PaymentHistory()));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 20,
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .layerGroup,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Lịch sử giao dịch',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: .5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 4.0, bottom: 4.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<NavigatorProvider>(
                                                              context,
                                                              listen: false)
                                                          .setShow(false);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const BookMarkPage()));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 20,
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .solidSquarePlus,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Yêu thích',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: .5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 4.0, bottom: 4.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<NavigatorProvider>(
                                                              context,
                                                              listen: false)
                                                          .setShow(false);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const AboutUsPage()));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 20,
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .building,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Về chúng tôi',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: .5,
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            bottom: 4.0),
                                                    child: AspectRatio(
                                                      aspectRatio: 4 / 1,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Image.asset(
                                                          "assets/images/donatebanner.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0,
                                                          bottom: 4.0),
                                                  child: GFButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              CustomAlertChoiceDialog(
                                                                content:
                                                                    "Việc đăng xuất sẽ hạn chế một số tính năng của ứng dụng",
                                                                title:
                                                                    "Đăng xuất",
                                                                action: () {
                                                                  AuthApi.signOut(
                                                                      context);
                                                                },
                                                              ));
                                                    },
                                                    text: "Đăng xuất",
                                                    type: GFButtonType.outline,
                                                    fullWidthButton: true,
                                                    color: Utils.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      )),
                );
              }),
            ],
          ),
        ));
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
            child: ElevatedButton(
                onPressed: () {
                  AuthApi.signOut(context);
                },
                child: Text('LOGOUT')),
          )
        : Container(
            child: ElevatedButton(
                onPressed: () async {
                  Provider.of<NavigatorProvider>(context, listen: false)
                      .setShow(false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Text('Log in')),
          );
  }
}

// LoginOrProfileComponent(),
//                 ElevatedButton(
//                     onPressed: () async {
//                       await AuthApi.register(context, '1234557890', '123');
//                     },
//                     child: Text("Sign up")),
//                 ElevatedButton(onPressed: () {}, child: Text("forward")),
//                 ElevatedButton(onPressed: () {}, child: Text("print"))
