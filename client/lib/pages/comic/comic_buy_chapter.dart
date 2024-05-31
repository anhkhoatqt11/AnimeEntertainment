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
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
    if (Provider.of<UserProvider>(context, listen: false)
            .user
            .authentication['sessionToken'] ==
        "") {
      isLoading = true;
      text = "Đăng nhập để mua chương";
    } else {
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
                              ? MediaQuery.of(context).size.height - 375
                              : MediaQuery.of(context).size.height - 330,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: const Color.fromARGB(255, 43, 43, 43),
                        width: MediaQuery.of(context).size.width,
                        height: Provider.of<NavigatorProvider>(context,
                                    listen: false)
                                .isShowNavigator
                            ? 375
                            : 330,
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
                                      color: Colors.white, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 30,
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
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        widget.comic.chapterList![widget.index]
                                            ['coverImage'],
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.comic.comicName!,
                                      style: TextStyle(
                                          color: Utils.primaryColor,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      widget.comic.chapterList![widget.index]
                                          ['chapterName'],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                  width: 15,
                                ),
                                const Text(
                                  'Giá: ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Text(
                                  widget.comic
                                      .chapterList![widget.index]['unlockPrice']
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(width: 5),
                                Image.asset(
                                  "assets/images/skycoin.png",
                                  width: 16,
                                  height: 16,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Provider.of<UserProvider>(context, listen: false)
                                        .user
                                        .authentication['sessionToken'] !=
                                    ""
                                ? Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      FaIcon(
                                        FontAwesomeIcons.wallet,
                                        color: Utils.primaryColor,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Bạn hiện đang có:   ${Provider.of<UserProvider>(context, listen: false).user.coinPoint}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      const SizedBox(width: 5),
                                      Image.asset(
                                        "assets/images/skycoin.png",
                                        width: 16,
                                        height: 16,
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 10,
                            ),
                            Provider.of<UserProvider>(context, listen: false)
                                        .user
                                        .authentication['sessionToken'] !=
                                    ""
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Center(
                                        child: GradientSquareButton(
                                          width: 130,
                                          height: 45,
                                          action: () async {
                                            //forward to payment link
                                          },
                                          content: 'Nạp thêm',
                                          cornerRadius: 16,
                                        ),
                                      ),
                                      Center(
                                        child: GradientSquareButton(
                                          width: 130,
                                          height: 45,
                                          action: () async {
                                            if (Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .user
                                                    .coinPoint >=
                                                widget.comic.chapterList![widget
                                                    .index]['unlockPrice']) {
                                              await UsersApi.paySkycoin(
                                                context,
                                                widget.comic.chapterList![widget
                                                    .index]['unlockPrice'],
                                                widget.comic.chapterList![
                                                    widget.index]['_id'],
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
                                          content: 'Mua ngay',
                                          cornerRadius: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: GradientSquareButton(
                                      width: 230,
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
}
