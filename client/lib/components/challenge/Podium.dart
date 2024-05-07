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
          userChallenges.sort((a, b) => b
              .getMaxTime()
              .compareTo(a.getMaxTime())); // Sort based on max time
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 260,
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
                              'assets/images/flowerring2.png',
                              height: 65,
                              width: 65,
                            ),
                            GFImageOverlay(
                              height: 50,
                              width: 50,
                              shape: BoxShape.circle,
                              color: Colors.white,
                              colorFilter: const ColorFilter.mode(
                                  Colors.transparent, BlendMode.color),
                              image: NetworkImage(userChallenges[1].avatar),
                              boxFit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/silvertrophy.png',
                        height: 60,
                        width: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              color: const Color(0xFF2A2A2A),
                            ),
                            Column(
                              children: [
                                const Text(
                                  "2",
                                  style: TextStyle(
                                      color: Color(0XFFFF9417),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  child: Text(
                                    userChallenges[1].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Text(
                                  '${userChallenges[1].getMaxTime()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 280,
                  width: (MediaQuery.of(context).size.width - 20) * 0.31,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GFImageOverlay(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              height: 50,
                              width: 50,
                              shape: BoxShape.circle,
                              color: Colors.white,
                              colorFilter: const ColorFilter.mode(
                                  Colors.transparent, BlendMode.color),
                              image: NetworkImage(userChallenges[0].avatar),
                              boxFit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/images/flowerring1.png',
                              height: 74,
                              width: 74,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/goldtrophy.png',
                        height: 60,
                        width: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              color: const Color(0xFF2A2A2A),
                            ),
                            Column(
                              children: [
                                const Text(
                                  "1",
                                  style: TextStyle(
                                      color: Color(0XFFEF476F),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  child: Text(
                                    userChallenges[0].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Text(
                                  '${userChallenges[0].getMaxTime()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 240,
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
                              'assets/images/flowerring3.png',
                              height: 62,
                              width: 62,
                            ),
                            GFImageOverlay(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              height: 50,
                              width: 50,
                              shape: BoxShape.circle,
                              color: Colors.white,
                              colorFilter: const ColorFilter.mode(
                                  Colors.transparent, BlendMode.color),
                              image: NetworkImage(userChallenges[2].avatar),
                              boxFit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/trophy.png',
                        height: 60,
                        width: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              color: const Color(0xFF2A2A2A),
                            ),
                            Column(
                              children: [
                                const Text(
                                  "3",
                                  style: TextStyle(
                                      color: Color(0XFF06D6A0),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  child: Text(
                                    userChallenges[2].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Text(
                                  '${userChallenges[2].getMaxTime()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
