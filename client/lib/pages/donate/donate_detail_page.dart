import 'package:anime_and_comic_entertainment/components/ui/AlertChoiceDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/donate_packages_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anime_and_comic_entertainment/model/donatepackages.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateDetailPage extends StatefulWidget {
  final DonatePackages donatePackage;
  const DonateDetailPage({super.key, required this.donatePackage});

  @override
  State<DonateDetailPage> createState() => _DonateDetailPageState();
}

class _DonateDetailPageState extends State<DonateDetailPage> {
  @override
  void initState() {
    super.initState();
    // Uncomment and replace with actual logic to get user's SkyCoins
    // final userSkyCoins =
    //     Provider.of<UserProvider>(context, listen: false).user.coinPoint;
    // userSkyCoinsValue = userSkyCoins;
  }

  @override
  Widget build(BuildContext context) {
    var donatePackage = widget.donatePackage;
    var donatePackageCoin = donatePackage.coin ?? 0;
    var donatePackageImage = donatePackage.coverImage ?? "";
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Column(
        children: [
          Stack(children: [
            Column(
              children: [
                FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loadingcomicimage.png',
                    image: donatePackage.coverImage ?? '',
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.8,
                    fit: BoxFit.cover),
              ],
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                height: 100,
                alignment: AlignmentDirectional.centerStart,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(102, 56, 56, 56),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: GFIconButton(
                      splashColor: Colors.transparent,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      type: GFButtonType.transparent),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Text(
            donatePackage.title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            donatePackage.subTitle ?? '',
            style: TextStyle(
              color: Utils.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          GradientSquareButton(
              content: 'Donate ngay ${donatePackage.coin ?? 0} 💎',
              action: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height:
                          user.authentication['sessionToken'] == "" ? 270 : 320,
                      color: const Color(0xFF2A2A2A),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                            child: Text("Ủng hộ đội ngũ Skylark nhé !",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/images/loadingcomicimage.png',
                                      image: donatePackageImage,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  donatePackage.title ?? '',
                                  style: TextStyle(
                                      color: Utils.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      donatePackage.coin.toString(),
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
                          ),
                          const Divider(
                            color: Color(0xFF686868),
                            thickness: .5,
                          ),
                          Provider.of<UserProvider>(context)
                                      .user
                                      .authentication['sessionToken'] !=
                                  ""
                              ? Container(
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 8.0, 16, 8),
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 36, 16, 8),
                                        child: Row(
                                          children: [
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
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: GFButton(
                                                onPressed: () async {
                                                  if (user.coinPoint <
                                                      donatePackageCoin) {
                                                    Navigator.pop(context);
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            CustomAlertDialog(
                                                              content:
                                                                  "Bạn không có đủ Skycoin để thực hiện giao dịch này.",
                                                              title:
                                                                  "Thông báo",
                                                              action: () {},
                                                            ));
                                                    return;
                                                  }
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        CustomAlertChoiceDialog(
                                                      yesContent: "Đồng ý",
                                                      noContent: "Hủy",
                                                      content:
                                                          'Bạn có chắc chắn muốn donate cho Skylark ${donatePackage.coin.toString()} skycoins!',
                                                      title: "Thông báo",
                                                      action: () async {
                                                        try {
                                                          await DonatePackagesApi
                                                              .uploadDonateRecord(
                                                                  context,
                                                                  donatePackage
                                                                          .id ??
                                                                      '',
                                                                  user.id // Replace with the actual user ID from UserProvider
                                                                  );
                                                          await DonatePackagesApi
                                                              .processDonationPayment(
                                                                  context,
                                                                  donatePackage
                                                                      .coin,
                                                                  user.id // Replace with the actual user ID from UserProvider
                                                                  );
                                                          Navigator.pop(
                                                              context);
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  CustomAlertDialog(
                                                                    content:
                                                                        "Giao dịch thành công. Cảm ơn bạn đã ủng hộ Skylark.",
                                                                    title:
                                                                        "Thông báo",
                                                                    action:
                                                                        () {},
                                                                  ));
                                                          // Close the modal bottom sheet
                                                        } catch (e) {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  CustomAlertDialog(
                                                                    content:
                                                                        "Giao dịch thất bại. Vui lòng thử lại sau.",
                                                                    title:
                                                                        "Thông báo",
                                                                    action:
                                                                        () {},
                                                                  ));
                                                        }
                                                      },
                                                    ),
                                                  );
                                                },
                                                color: Utils.primaryColor,
                                                text: "Donate ngay",
                                                size: GFSize.LARGE,
                                                type: GFButtonType.solid,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  child: Center(
                                    child: GradientSquareButton(
                                      action: () {
                                        Provider.of<NavigatorProvider>(context,
                                                listen: false)
                                            .setShow(false);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                      },
                                      content: "Đăng nhập để tiếp tục",
                                      cornerRadius: 8,
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    );
                  },
                );
              },
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              cornerRadius: 8)
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url =
        Uri.parse('https://anime-entertainment-payment.vercel.app/');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class GFAppbar {}
