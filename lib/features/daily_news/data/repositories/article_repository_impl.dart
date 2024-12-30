import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/datasources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final AppDatabase _appDatabase;
  final NewsApiService _newsApiService;
  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    final httpResponse = await _newsApiService.getNewsArticles(
      apikey: newsAPIKey,
      country: countryQuery,
      category: categoryQuery,
    );
    try {
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions), // DioError
        ); // DataFailed
      }
    } on DioException catch (e) {
      return DataFailed(e); // DataFailed
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async{
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
   return _appDatabase.articleDAO.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
     return _appDatabase.articleDAO.insertArticle(ArticleModel.fromEntity(article));
  }
}
