import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';

class DonatePodiumItem extends StatelessWidget {
  final int position;
  final String avatarUrl;
  final String name;
  final int donationCount;
  final int totalCoins;

  const DonatePodiumItem({
    Key? key,
    required this.position,
    required this.avatarUrl,
    required this.name,
    required this.donationCount,
    required this.totalCoins,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color positionColor;
    switch (position) {
      case 1:
        positionColor = Utils.primaryColor;
        break;
      case 2:
        positionColor = Utils.greenColor;
        break;
      case 3:
        positionColor = Utils.blueColor;
        break;
      default:
        positionColor = Colors.grey[800]!;
        break;
    }

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            position.toString(),
            style: TextStyle(
              color: positionColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(width: 16), // Padding between position number and avatar
          Container(
            width: screenWidth - 72, // Screen width minus padding and position
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                SizedBox(width: 12), // Padding between avatar and name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4), // Padding between name and donation count
                      Text(
                        'Đã donate $donationCount lần',
                        style: TextStyle(
                          color: Utils.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12), // Padding between text and coin
                Row(
                  children: [
                    Text(
                      "${Utils.formatNumberWithDots(totalCoins)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 4), // Padding between total coins and coin icon
                    Image.asset(
                      "assets/images/skycoin.png",
                      width: 16,
                      height: 16,
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
