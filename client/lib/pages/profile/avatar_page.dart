import 'package:anime_and_comic_entertainment/model/avatar.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  List<Avatar> collectionList = [];

  Future<List<Avatar>> getAvatarList() async {
    var result = await UsersApi.getAvatarList(context);
    return result;
  }

  @override
  void initState() {
    super.initState();

    getAvatarList().then((value) => value.forEach((element) {
          setState(() {
            collectionList.add(Avatar(
                collectionName: element.collectionName,
                avatarList: element.avatarList));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
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
                Provider.of<NavigatorProvider>(context, listen: false)
                    .setShow(true);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              type: GFButtonType.transparent,
            ),
            centerTitle: true,
            title: const Text(
              "Bộ sưu tập avatar xịn xò 😉",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            )),
        body: collectionList.isEmpty
            ? const Center(
                child: GFLoader(type: GFLoaderType.circle),
              )
            : ListView(
                children: List.generate(
                    collectionList.length,
                    (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                collectionList[index].collectionName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: collectionList[index]
                                        .avatarList!
                                        .length,
                                    itemBuilder: (context, index2) {
                                      return GestureDetector(
                                        onTap: () {
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .setUserAvatar(
                                                  collectionList[index]
                                                      .avatarList![index2]);
                                          UsersApi.updateAvatar(
                                              context,
                                              collectionList[index]
                                                  .avatarList![index2]);
                                          Provider.of<NavigatorProvider>(
                                                  context,
                                                  listen: false)
                                              .setShow(true);
                                          Navigator.of(context).pop();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: collectionList[index]
                                                .avatarList![index2],
                                            width: 100,
                                            height: 100,
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                ),
                                              ),
                                            ),
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover)),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    })),
                          ],
                        )),
              ));
  }
}
