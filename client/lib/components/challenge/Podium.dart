import 'package:flutter/material.dart';

class Podium extends StatelessWidget {
  const Podium({super.key});
  @override
  Widget build(BuildContext context) {
    List<LeaderboardItem> leaderboard = [
      LeaderboardItem(
        name: 'Alexia 1',
        score: 200,
        avatarUrl: 'assets/images/donate1.png',
      ),
      LeaderboardItem(
        name: 'Alexia 2',
        score: 150,
        avatarUrl: 'assets/images/donate1.png',
      ),
      LeaderboardItem(
        name: 'Alexia 3',
        score: 100,
        avatarUrl: 'assets/images/donate1.png',
      ),
    ];

    return Stack(
      alignment: Alignment.center,
      children: [
        // Third Place
        Positioned(
          right: 50,
          child: PodiumItem(
            position: '3',
            name: leaderboard[2].name,
            score: leaderboard[2].score,
            avatarUrl: leaderboard[2].avatarUrl,
            color: Colors.brown,
          ),
        ),
        // First Place
        PodiumItem(
          position: '1',
          name: leaderboard[0].name,
          score: leaderboard[0].score,
          avatarUrl: leaderboard[0].avatarUrl,
          color: Colors.amber,
        ),
        // Second Place
        Positioned(
          left: 50,
          child: PodiumItem(
            position: '2',
            name: leaderboard[1].name,
            score: leaderboard[1].score,
            avatarUrl: leaderboard[1].avatarUrl,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class PodiumItem extends StatelessWidget {
  final String position;
  final String name;
  final int score;
  final String avatarUrl;
  final Color color;

  const PodiumItem({
    Key? key,
    required this.position,
    required this.name,
    required this.score,
    required this.avatarUrl,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(avatarUrl),
        ),
        const SizedBox(height: 5),
        Icon(
          Icons.emoji_events,
          color: color,
          size: 30,
        ),
        Container(
          width: 100,
          height: 100 + (score * 0.3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                position,
                style: const TextStyle(
                  color: Color.fromARGB(255, 7, 7, 7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeaderboardItem {
  final String name;
  final int score;
  final String avatarUrl;

  LeaderboardItem(
      {required this.name, required this.score, required this.avatarUrl});
}
