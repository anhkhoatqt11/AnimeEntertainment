import 'dart:convert';
import 'package:anime_and_comic_entertainment/model/challenges.dart';
import 'package:anime_and_comic_entertainment/services/challenges_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

class Podium extends StatefulWidget {
  const Podium({Key? key}) : super(key: key);

  @override
  State<Podium> createState() => _PodiumState();
}

class _PodiumState extends State<Podium> {
  late Future<List<UserChallenge>> _userChallengesFuture;

  @override
  void initState() {
    super.initState();
    _userChallengesFuture = ChallengesApi.getUsersChallengesPoints();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserChallenge>>(
      future: _userChallengesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final userChallenges = snapshot.data ?? [];
          userChallenges.sort((a, b) => b
              .getMaxTime()
              .compareTo(a.getMaxTime())); // Sort based on max time
          return Column(
            children: [
              for (int i = 0; i < 3 && i < userChallenges.length; i++)
                ListTile(
                  leading: GFImageOverlay(
                    height: 40,
                    width: 40,
                    border: Border.all(color: Utils.primaryColor, width: 2),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    colorFilter: const ColorFilter.mode(
                        Colors.transparent, BlendMode.color),
                    image: NetworkImage(userChallenges[i].avatar),
                    boxFit: BoxFit.cover,
                  ),
                  title: Text(
                    userChallenges[i].name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text('Điểm số: ${userChallenges[i].getMaxTime()}'),
                ),
            ],
          );
        }
      },
    );
  }
}
