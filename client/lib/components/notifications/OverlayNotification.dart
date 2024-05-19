import 'package:anime_and_comic_entertainment/pages/notification/notification.dart';
import 'package:flutter/material.dart';

class OverlayNotification extends StatefulWidget {
  final String content;
  final int type;

  const OverlayNotification({required this.content, required this.type});

  @override
  State<OverlayNotification> createState() => _OverlayNotificationState();
}

class _OverlayNotificationState extends State<OverlayNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    position = Tween<Offset>(begin: const Offset(0.0, -4.0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 1400), () {
          Navigator.of(context).pop();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SlideTransition(
              position: position,
              child: Container(
                decoration: ShapeDecoration(
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ),
                        );
                      },
                      child: Text(
                        widget.content,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
