import 'package:anime_and_comic_entertainment/components/notifications/NotiComponent.dart';
import 'package:anime_and_comic_entertainment/model/notification.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/services/notification_api.dart';
import 'package:flutter/material.dart';
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

  String text = "";

  @override
  void initState() {
    super.initState();
    FirebaseApi().listenEvent(context);
    if (Provider.of<UserProvider>(context, listen: false)
            .user
            .authentication['sessionToken'] !=
        "") {
      setState(() {
        text = "Chưa có thông báo nào!";
        userId = Provider.of<UserProvider>(context, listen: false).user.id;
      });
    } else {
      text = "Đăng nhập để xem thông báo!";
    }

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
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              centerTitle: true,
              title: const Text('Thông báo'),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF141414),
            ),
            body: Center(
                child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            )))
        : Scaffold(
            backgroundColor: const Color(0xFF141414),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              centerTitle: true,
              title: const Text('Thông báo'),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF141414),
            ),
            body: ListView(
              children: [
                SizedBox(
                  height: notifications.length * 85,
                  child: Column(
                      children: List.generate(
                          notifications.length,
                          (index) => NotiComponent(
                              noti: notifications[
                                  notifications.length - index - 1]))),
                ),
              ],
            ));
  }
}
