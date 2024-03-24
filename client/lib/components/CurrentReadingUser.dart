import 'package:anime_and_comic_entertainment/components/CurrentView.dart';
import 'package:anime_and_comic_entertainment/components/LandspaceItem.dart';
import 'package:anime_and_comic_entertainment/components/PortraitItem.dart';
import 'package:anime_and_comic_entertainment/components/CurrentRead.dart';
import 'package:flutter/cupertino.dart';

class CurrentReadingUser extends StatelessWidget {
  const CurrentReadingUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        CurrentRead(
          urlImage:
              'https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/_t_p_m_i_tagline-da6dcb8f74a8-1686305754531-gCwpREbI.png?v=0&maxW=260',
          nameItem: "Detective Conan",
        ),
        CurrentRead(
          urlImage:
              'https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/phim_moi-fdc866c73fd2-1708663384221-h3BlLVOZ.png?v=0&maxW=260',
          nameItem: "Doraemon",
        ),
        CurrentRead(
          urlImage:
              'https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/vertical_poster-6edb1870a631-1708400087928-NOgvY5n0.png?v=0&maxW=260',
          nameItem: "Boruto",
        ),
        CurrentRead(
          urlImage:
              'https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/vertical_poster-128d9c4e3cfc-1708400799846-D1MOGy71.png?v=0&maxW=260',
          nameItem: "Kizuna no Allele",
        )
      ],
    );
  }
}
