import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final bool? isRemovable;
  final void Function(ArticleEntity article)? onRemove;
  final void Function(ArticleEntity article)? onArticlePressed;

  const ArticleWidget({
    super.key,
    this.article,
    this.isRemovable = false,
    this.onRemove,
    this.onArticlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onArticlePressed?.call(article!),
      child: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 14, end: 14, bottom: 14, top: 10),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            const SizedBox(width: 10),
            Expanded(child: _buildTitleAndDescription(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: 120.0,
        child: CachedNetworkImage(
          imageUrl: article?.urlToImage ?? '',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Container(
            color: Colors.grey.withOpacity(0.2),
            child: const Center(child: CupertinoActivityIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.withOpacity(0.2),
            child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article?.title ?? 'No Title Available',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          article?.description ?? 'No Description Available',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.access_time, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              article?.publishedAt ?? 'Unknown Date',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            if (isRemovable ?? false)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => onRemove?.call(article!),
              ),
          ],
        ),
      ],
    );
  }
}
