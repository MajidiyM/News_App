import "package:dio/dio.dart";

abstract class DataState<T> {
  final T? data;
  final DioException? error;
  const DataState({this.data, this.error});
}

// Network call response: Data Success
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

// Network call response: Data Failed
class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
