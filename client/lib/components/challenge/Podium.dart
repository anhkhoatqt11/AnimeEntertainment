import 'package:anime_and_comic_entertainment/model/challenges.dart';
import 'package:anime_and_comic_entertainment/services/challenges_api.dart';
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final userChallenges = snapshot.data ?? [];
          userChallenges.sort((a, b) => b.getMaxWeeklyPoints().compareTo(
              a.getMaxWeeklyPoints())); // Sort based on max weekly points

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (userChallenges.length > 1)
                  buildPodiumUser(
                    context,
                    userChallenges[1],
                    2,
                    'assets/images/flowerring2.png',
                    'assets/images/silvertrophy.png',
                    const Color(0XFFFF9417),
                  ),
                if (userChallenges.isNotEmpty)
                  buildPodiumUser(
                    context,
                    userChallenges[0],
                    1,
                    'assets/images/flowerring1.png',
                    'assets/images/goldtrophy.png',
                    const Color(0XFFEF476F),
                  ),
                if (userChallenges.length > 2)
                  buildPodiumUser(
                    context,
                    userChallenges[2],
                    3,
                    'assets/images/flowerring3.png',
                    'assets/images/trophy.png',
                    const Color(0XFF06D6A0),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildPodiumUser(BuildContext context, UserChallenge userChallenge,
      int position, String ringAsset, String trophyAsset, Color positionColor) {
    return SizedBox(
      height: position == 1
          ? 280
          : position == 2
              ? 260
              : 240,
      width: (MediaQuery.of(context).size.width - 20) * 0.31,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  ringAsset,
                  height: position == 1
                      ? 74
                      : position == 2
                          ? 65
                          : 62,
                  width: position == 1
                      ? 74
                      : position == 2
                          ? 65
                          : 62,
                ),
                GFImageOverlay(
                  height: 50,
                  width: 50,
                  shape: BoxShape.circle,
                  color: Colors.white,
                  colorFilter: const ColorFilter.mode(
                      Colors.transparent, BlendMode.color),
                  image: NetworkImage(userChallenge.avatar),
                  boxFit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Image.asset(
            trophyAsset,
            height: 60,
            width: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: position == 1
                      ? 140
                      : position == 2
                          ? 120
                          : 100,
                  width: double.infinity,
                  color: const Color(0xFF2A2A2A),
                ),
                Column(
                  children: [
                    Text(
                      "$position",
                      style: TextStyle(
                        color: positionColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                      child: Text(
                        userChallenge.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      '${userChallenge.getMaxWeeklyPoints()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
