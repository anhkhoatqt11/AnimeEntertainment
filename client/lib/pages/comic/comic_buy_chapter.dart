import 'package:anime_and_comic_entertainment/components/ui/AlertChoiceDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ComicBuyChapter extends StatefulWidget {
  final Comics comic;
  final int index;

  const ComicBuyChapter({super.key, required this.comic, required this.index});

  @override
  State<ComicBuyChapter> createState() => _ComicBuyChapterState();
}

class _ComicBuyChapterState extends State<ComicBuyChapter> {
  Future<List<dynamic>> getPayHis() async {
    var result = await UsersApi.getPaymentHistories(context);
    return result;
  }

  String text = "";
  bool isLoading = false;
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    if (Provider.of<UserProvider>(context, listen: false)
            .user
            .authentication['sessionToken'] ==
        "") {
      isLoading = true;
      text = "Đăng nhập để mua chương";
      isLogin = false;
    } else {
      isLogin = true;
      getPayHis().then((value) => setState(() {
            isLoading = true;
            if (value
                .contains(widget.comic.chapterList![widget.index]['_id'])) {
              Provider.of<NavigatorProvider>(context, listen: false)
                  .setShow(false);
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComicChapterDetail(
                    comic: widget.comic,
                    index: widget.index,
                  ),
                ),
              );
            } else {
              if (Provider.of<UserProvider>(context, listen: false)
                      .user
                      .coinPoint >=
                  widget.comic.chapterList![widget.index]['unlockPrice']) {
                text = "Thanh toán ngay";
              } else {
                text = "Nạp ngay";
              }
            }
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SafeArea(
            child: Material(
              color: Colors.black.withOpacity(0.3),
              child: Stack(
                children: [
                  Positioned(
                      top:
                          Provider.of<NavigatorProvider>(context, listen: false)
                                  .isShowNavigator
                              ? MediaQuery.of(context).size.height -
                                  360 -
                                  (!isLogin ? -50 : 0)
                              : MediaQuery.of(context).size.height -
                                  355 -
                                  (!isLogin ? -50 : 0),
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: const Color.fromARGB(255, 43, 43, 43),
                        width: MediaQuery.of(context).size.width,
                        height: Provider.of<NavigatorProvider>(context,
                                    listen: false)
                                .isShowNavigator
                            ? 360 - (!isLogin ? -50 : 0)
                            : 355 - (!isLogin ? -50 : 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  height: 30,
                                  width: 15,
                                ),
                                const Text(
                                  'Mở khóa truyện để tiếp tục đọc nhé!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 60,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16.0, 0, 16, 8),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/loadingcomicimage.png',
                                        image: widget.comic
                                                .chapterList![widget.index]
                                            ['coverImage'],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                170,
                                            child: Text(
                                              widget.comic.comicName!,
                                              style: TextStyle(
                                                  color: Utils.primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            widget.comic
                                                    .chapterList![widget.index]
                                                ['chapterName'],
                                            style: const TextStyle(
                                                color: Color(0xFFE9E9E9),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            widget
                                                .comic
                                                .chapterList![widget.index]
                                                    ['unlockPrice']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            "assets/images/skycoin.png",
                                            width: 16,
                                            height: 16,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xFF686868),
                              thickness: .5,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Provider.of<UserProvider>(context, listen: false)
                                        .user
                                        .authentication['sessionToken'] !=
                                    ""
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .account_balance_wallet_outlined,
                                              color: Utils.primaryColor,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Text(
                                              "Bạn hiện đang có:",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              Utils.formatNumberWithDots(
                                                  Provider.of<UserProvider>(
                                                          context)
                                                      .user
                                                      .coinPoint),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Image.asset(
                                              "assets/images/skycoin.png",
                                              width: 16,
                                              height: 16,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 5,
                            ),
                            Provider.of<UserProvider>(context, listen: false)
                                        .user
                                        .authentication['sessionToken'] !=
                                    ""
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: GFButton(
                                          onPressed: () {
                                            _launchUrl();
                                          },
                                          color: Utils.primaryColor,
                                          text: "Nạp thêm",
                                          size: GFSize.LARGE,
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Utils.primaryColor),
                                          type: GFButtonType.outline2x,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: GFButton(
                                          onPressed: () async {
                                            if (Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .user
                                                    .coinPoint >=
                                                widget.comic.chapterList![widget
                                                    .index]['unlockPrice']) {
                                              showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    CustomAlertChoiceDialog(
                                                  yesContent: "Đồng ý",
                                                  noContent: "Hủy",
                                                  content:
                                                      "Bạn có chắc chắn muốn mua chương truyện này?!",
                                                  title: "Thông báo",
                                                  action: () async {
                                                    await UsersApi.paySkycoin(
                                                      context,
                                                      widget.comic.chapterList![
                                                              widget.index]
                                                          ['unlockPrice'],
                                                      widget.comic.chapterList![
                                                          widget.index]['_id'],
                                                    );
                                                    Provider.of<UserProvider>(
                                                            context,
                                                            listen: false)
                                                        .minusCoinPoint(widget
                                                                    .comic
                                                                    .chapterList![
                                                                widget.index]
                                                            ['unlockPrice']);
                                                    Provider.of<NavigatorProvider>(
                                                            context,
                                                            listen: false)
                                                        .setShow(false);
                                                    Navigator.of(context).pop();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ComicChapterDetail(
                                                          comic: widget.comic,
                                                          index: widget.index,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    CustomAlertDialog(
                                                  content:
                                                      "Bạn không đủ skycoin để mở khóa chương này! Vui lòng nạp thêm!",
                                                  title: "Thông báo",
                                                  action: () {},
                                                ),
                                              );
                                            }
                                          },
                                          color: Utils.primaryColor,
                                          text: "Mua ngay",
                                          size: GFSize.LARGE,
                                          type: GFButtonType.solid,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: GradientSquareButton(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 45,
                                      action: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                      },
                                      content: 'Đăng nhập để mua chương',
                                      cornerRadius: 16,
                                    ),
                                  ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          )
        : SafeArea(
            child: Material(color: Colors.black.withOpacity(0), child: null));
  }

  Future<void> _launchUrl() async {
    final Uri _url =
        Uri.parse('https://anime-entertainment-payment.vercel.app/');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
