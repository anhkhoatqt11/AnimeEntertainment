import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/donate_packages_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anime_and_comic_entertainment/model/donatepackages.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:provider/provider.dart';

class DonateDetailPage extends StatefulWidget {
  final DonatePackages donatePackage;
  const DonateDetailPage({super.key, required this.donatePackage});

  @override
  State<DonateDetailPage> createState() => _DonateDetailPageState();
}

class _DonateDetailPageState extends State<DonateDetailPage> {
  late int userSkyCoinsValue = 600;

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
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
        backgroundColor: const Color(0xFF141414),
        title: const Text(
          "Donate Ủng Hộ Skylark",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: Image.network(
                donatePackage.coverImage ?? '',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              donatePackage.subTitle ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              donatePackage.title ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: const Color(0xFF141414),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.close, color: Colors.white),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          Text(
                            'Bạn có ${userSkyCoinsValue} Skycoins',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            donatePackage.title ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Bạn có muốn ủng hộ ${donatePackage.coin ?? 0} Skycoins?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              if (userSkyCoinsValue < donatePackageCoin) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Bạn không có đủ SkyCoins.'),
                                  ),
                                );
                                Navigator.pop(context);
                                return;
                              }
                              bool success =
                                  await DonatePackagesApi.uploadDonateRecord(
                                context,
                                donatePackage.id ?? '',
                                '65ec67ad05c5cb2ad67cfb3f', // Replace with the actual user ID from UserProvider
                              );
                              Navigator.pop(
                                  context); // Close the modal bottom sheet

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Donation successful!')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Failed to donate. Please try again.')),
                                );
                              }
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Donate Now'),
                  const SizedBox(width: 8),
                  Text('${donatePackage.coin ?? 0} Coins'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GFAppbar {}
