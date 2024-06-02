import 'package:anime_and_comic_entertainment/components/donate/PackageItem.dart';
import 'package:anime_and_comic_entertainment/model/donatepackages.dart';
import 'package:anime_and_comic_entertainment/pages/donate/donate_detail_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/services/donate_packages_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DonatePackageListHome extends StatefulWidget {
  const DonatePackageListHome({super.key});

  @override
  State<DonatePackageListHome> createState() => _DonatePackageListHomeState();
}

class _DonatePackageListHomeState extends State<DonatePackageListHome> {
  List<DonatePackages> packageList = [];
  Future<List<DonatePackages>> getDonatePackageList() async {
    var result = await DonatePackagesApi.getDonatePackageList(context);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getDonatePackageList().then((value) => value.forEach((element) {
          setState(() {
            packageList.add(DonatePackages(
                id: element.id,
                coverImage: element.coverImage,
                title: element.title,
                subTitle: element.subTitle,
                coin: element.coin));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return packageList.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 191,
                        height: 187,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 191,
                        height: 187,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 191,
                        height: 187,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      )),
                ),
              ],
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: packageList.length,
            itemBuilder: (context, index) {
              return PackageItem(
                urlImage: packageList[index].coverImage,
                title: packageList[index].title,
                subTitle: packageList[index].subTitle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DonateDetailPage(donatePackage: packageList[index]),
                    ),
                  );
                },
              );
            });
  }
}
