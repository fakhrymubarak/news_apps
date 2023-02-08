import 'package:flutter/material.dart' hide NetworkImage;
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/domain/entities/article.dart';
import 'package:news_apps/themes/themes.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.newsDetails, arguments: article.url),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Source & Date
              Row(
                children: [
                  Expanded(
                    child: Text(Strings.textSource(article.source),
                        style: TextStyles.reg10pt()),
                  ),
                  Text(
                    article.publishedAt,
                    style: TextStyles.reg10pt(),
                    maxLines: 2,
                  )
                ],
              ),
              const SizedBox(height: 4.0),

              // Title, Content & Cover
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          article.title,
                          style: TextStyles.semiBold14pt(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          article.description,
                          style: TextStyles.reg12pt(),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  NetworkImage(url: article.urlToImage, height: 100, width: 100),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
