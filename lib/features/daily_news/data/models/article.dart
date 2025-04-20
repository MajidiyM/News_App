import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel(
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  );

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      map['author'] ?? "",
      map['title'] ?? "",
      map['description'] ?? "",
      map['url'] ?? "",
      map['urlToImage'] ?? "",
      map['publishedAt'] ?? "",
      map['content'] ?? "",
    );
  }
}
