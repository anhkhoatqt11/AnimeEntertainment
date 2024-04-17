import 'package:flutter/cupertino.dart';

class DonateBannerHome extends StatelessWidget {
  final String urlAsset;
  const DonateBannerHome({super.key,required this.urlAsset});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          urlAsset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
