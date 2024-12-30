import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/injection_container.dart';

class ArticleDetailsView extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleDetailsView({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Builder(
        builder: (blocContext) => Scaffold(
          appBar: _buildAppBar(blocContext),
          body: _buildBody(),
          floatingActionButton: _buildFloatingActionButton(blocContext),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Ionicons.chevron_back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Article Details',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article?.title ?? 'No Title Available',
            style: const TextStyle(
              fontFamily: 'Butler',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                article?.publishedAt ?? 'Unknown Date',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          article?.urlToImage ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.broken_image, size: 50)),
        ),
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
      child: Text(
        '${article?.description ?? 'No Description Available'}\n\n${article?.content ?? 'No Content Available'}',
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onFloatingActionButtonPressed(context),
      child: const Icon(
        Ionicons.bookmark,
        color: Colors.white,
      ),
    );
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully'),
      ),
    );
  }
}
