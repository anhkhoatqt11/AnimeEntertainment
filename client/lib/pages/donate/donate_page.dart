import 'package:anime_and_comic_entertainment/pages/donate/donate_detail_page.dart';
import 'package:anime_and_comic_entertainment/services/donate_packages_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anime_and_comic_entertainment/model/donatepackages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  late Future<List<DonatePackages>> futureDonatePackages;

  @override
  void initState() {
    super.initState();
    futureDonatePackages = _fetchDonatePackages();
  }

  Future<List<DonatePackages>> _fetchDonatePackages() async {
    var packages = await DonatePackagesApi.getDonatePackageList(context);
    return packages as List<DonatePackages>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
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
      body: FutureBuilder<List<DonatePackages>>(
        future: futureDonatePackages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading donate packages'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No donate packages found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final donatePackage = snapshot.data![index];
                return DonatePackageItem(
                  donatePackage: donatePackage,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonateDetailPage(donatePackage: donatePackage),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DonatePackageItem extends StatelessWidget {
  final DonatePackages donatePackage;
  final VoidCallback onPressed;

  const DonatePackageItem({
    required this.donatePackage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: const Color(0xFF1E1E1E),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (donatePackage.coverImage != null)
              CachedNetworkImage(
                imageUrl: donatePackage.coverImage!,
                imageBuilder: (context, imageProvider) => Container(
                  width: 80,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[500]!,
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donatePackage.title ?? 'No Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    donatePackage.subTitle ?? 'No Subtitle',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Coins: ${donatePackage.coin ?? 0}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onPressed,
                        child: const Text('Donate Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
