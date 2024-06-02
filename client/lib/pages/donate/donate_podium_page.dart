import 'package:anime_and_comic_entertainment/components/donate/DonatePodiumItem.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/donate/donate_page.dart';
import 'package:anime_and_comic_entertainment/services/donate_packages_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class DonatePodium extends StatefulWidget {
  const DonatePodium({super.key});

  @override
  State<DonatePodium> createState() => _DonatePodiumState();
}

class _DonatePodiumState extends State<DonatePodium> {
  late Future<List<Map<String, dynamic>>> donatorListFuture;

  Future<List<Map<String, dynamic>>> getDonatorList() async {
    var result = await DonatePackagesApi.getDonatorList(context);
    return result;
  }

  @override
  void initState() {
    super.initState();
    donatorListFuture = getDonatorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
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
        centerTitle: true,
        title: const Text(
          "Bảng xếp hạng đóng góp",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: donatorListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: GFLoader(type: GFLoaderType.circle));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No donators available.'));
                } else {
                  var donatorList = snapshot.data!;
                  return ListView.builder(
                    itemCount: donatorList.length,
                    itemBuilder: (context, index) {
                      var donator = donatorList[index];
                      return DonatePodiumItem(
                        position: index + 1,
                        avatarUrl: donator['avatar'],
                        name: donator['username'],
                        donationCount: donator['donationCount'],
                        totalCoins: donator['totalCoins'],
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: GradientSquareButton(
                cornerRadius: 4,
                content: "DONATE NGAY 💎",
                action: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DonatePage()));
                },
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
              )),
        ],
      ),
    );
  }
}
