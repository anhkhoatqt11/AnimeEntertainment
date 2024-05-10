import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class AnimeBookmarkItem extends StatelessWidget {
  final String landspaceImage;
  final String movieName;
  final bool isBookmarked;

  const AnimeBookmarkItem({
    Key? key,
    required this.landspaceImage,
    required this.movieName,
    required this.isBookmarked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Stack(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(8), // Padding around the content
            title: Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 16 / 9, // Aspect ratio of your image
                    child: CachedNetworkImage(
                      imageUrl: landspaceImage,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit
                                .cover, // Adjust image fit as per requirement
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      movieName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Utils.primaryColor, // Use your primary color here
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isBookmarked ? Icons.check : Icons.check_box_outline_blank,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
