import 'package:anime_and_comic_entertainment/components/notifications/NotiComponent.dart';
import 'package:anime_and_comic_entertainment/model/notification.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/services/notification_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late String userId = '65ec67ad05c5cb2ad67cfb3f';
  late List<Notifications> notifications = [];
  Future<List<Notifications>> getNotification() async {
    if (userId.isEmpty) return [];
    var result = await NotificationApi.getNotification(context, userId);
    return result;
  }

  @override
  void initState() {
    super.initState();
    FirebaseApi().listenEvent(context);
    userId = Provider.of<UserProvider>(context, listen: false).user.id;

    getNotification().then((value) {
      setState(() {
        notifications = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return notifications.isEmpty
        ? Scaffold(
            backgroundColor: const Color(0xFF141414),
            appBar: AppBar(
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
                    Navigator.of(context).pop();
                  },
                  type: GFButtonType.transparent,
                ),
                centerTitle: true,
                title: const Text(
                  "Thông báo",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
            body: Center(
                child: Text(
              'Chưa có thông báo nào!',
              style: TextStyle(
                  color: Utils.primaryColor, fontWeight: FontWeight.w500),
            )))
        : Scaffold(
            backgroundColor: const Color(0xFF141414),
            appBar: AppBar(
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
                    Navigator.of(context).pop();
                  },
                  type: GFButtonType.transparent,
                ),
                centerTitle: true,
                title: const Text(
                  "Thông báo",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
            body: ListView(
              children: [
                SizedBox(
                  height: notifications.length * 120,
                  child: Column(
                    children: List.generate(
                      notifications.length,
                      (index) => NotiComponent(
                        noti: notifications[notifications.length - index - 1],
                        index: notifications.length - index - 1,
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}
