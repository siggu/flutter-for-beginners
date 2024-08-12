import 'package:flutter/material.dart';
import 'package:toonflix/models/wetboon_episode_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode;
  // "https:/comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}"

  onButtonTap() async {
    try {
      final url = Uri.parse(
          "https:/comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        // URL을 열 수 없을 때의 처리 (예: 사용자에게 알림 표시)
        print("Could not launch $url");
      }
    } catch (e) {
      print("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(3, 3),
              color: Colors.black.withOpacity(0.2),
            ),
          ],
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: Colors.green.shade400,
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Hero(
                    tag: episode.id,
                    child: Container(
                      width: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.network(episode.thumb),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: screenWidth * 0.45,
                    child: Text(
                      episode.title,
                      style: TextStyle(
                        color: Colors.green.shade400,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.green.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
