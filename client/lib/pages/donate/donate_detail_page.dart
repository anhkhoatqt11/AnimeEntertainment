import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
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
                alignment: AlignmentDirectional.centerStart,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(102, 56, 56, 56),
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
                      height: 320,
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet_outlined,
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
                                          Provider.of<UserProvider>(context)
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
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GFButton(
                                    onPressed: () {},
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
                                      if (0 < donatePackageCoin) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Bạn không có đủ SkyCoins.'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                        return;
                                      }
                                      bool success = await DonatePackagesApi
                                          .uploadDonateRecord(
                                        context,
                                        donatePackage.id ?? '',
                                        Provider.of<UserProvider>(context)
                                            .user
                                            .id, // Replace with the actual user ID from UserProvider
                                      );
                                      Navigator.pop(
                                          context); // Close the modal bottom sheet

                                      if (success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Cảm ơn bạn đã ủng hộ đội ngũ')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Quá trình bị lỗi. Vui lòng thử lại sau.')),
                                        );
                                      }
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
}

class GFAppbar {}
