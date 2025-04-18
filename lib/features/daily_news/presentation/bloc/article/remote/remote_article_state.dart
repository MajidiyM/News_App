part of 'remote_article_bloc.dart';

@immutable
sealed class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;

  const RemoteArticleState({
    this.articles,
    this.error,
  });

  @override
  List<Object?> get props => [articles, error];
}

// Стейт загрузки
class RemoteArticlesLoading extends RemoteArticleState {
  const RemoteArticlesLoading() : super();
}

// Стейт успешной загрузки
class RemoteArticlesDone extends RemoteArticleState {
  const RemoteArticlesDone(List<ArticleEntity> articles)
      : super(articles: articles);
}

// Стейт ошибки
class RemoteArticlesError extends RemoteArticleState {
  const RemoteArticlesError(DioException error) : super(error: error);
}
