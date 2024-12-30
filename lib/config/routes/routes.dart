import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:news_app/features/daily_news/presentation/pages/saved_article/saved_article.dart';


class Routes {
  static const String articleDetails = '/ArticleDetails';
  static const String savedArticles = '/SavedArticles';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
     
      case articleDetails:
        final article = settings.arguments as ArticleEntity;
        return MaterialPageRoute(
          builder: (_) => ArticleDetailsView(article: article),
        );
      case savedArticles:
        return MaterialPageRoute(
          builder: (_) => const SavedArticles(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
