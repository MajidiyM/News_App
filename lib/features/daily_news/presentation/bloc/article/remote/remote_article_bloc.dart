import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';

part 'remote_article_event.dart';
part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;
  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  Future<void> onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    log('[RemoteArticleBloc] GetArticles event received');

    emit(const RemoteArticlesLoading());
    log('[RemoteArticleBloc] Loading state emitted');

    final dataState = await _getArticleUseCase();
    log('[RemoteArticleBloc] DataState received: $dataState');

    if (dataState is DataSuccess &&
        dataState.data != null &&
        dataState.data!.isNotEmpty) {
      log('[RemoteArticleBloc] Success: ${dataState.data!.length} articles loaded');
      emit(RemoteArticlesDone(dataState.data!));
    } else if (dataState is DataFailed) {
      log('[RemoteArticleBloc] Error: ${dataState.error}');
      emit(RemoteArticlesError(dataState.error!));
    } else {
      log('[RemoteArticleBloc] No articles found');
      emit(RemoteArticlesError(
        DioException(
          requestOptions: RequestOptions(path: '/top-headlines'),
          error: 'No articles found',
        ),
      ));
    }
  }
}
