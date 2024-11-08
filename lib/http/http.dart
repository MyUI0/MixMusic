import 'package:dio/dio.dart';
import 'http_dio.dart';

class Http {
  static void init({required String baseUrl, int? connectTimeout, int? receiveTimeout, List<Interceptor>? interceptors}) {
    HttpDio().init(baseUrl: baseUrl, connectTimeout: connectTimeout, receiveTimeout: receiveTimeout, interceptors: interceptors);
  }

  static void setHeaders(Map<String, dynamic> map) {
    HttpDio().setHeaders(map);
  }

  static void verifyCert(bool verify) {
    HttpDio().verifyCert(verify);
  }

  static void cancelRequests({CancelToken? token}) {
    HttpDio().cancelRequests(token: token);
  }

  static Future get(String path, {Map<String, dynamic>? params, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    try {
      var resp = await HttpDio().get(path, params: params, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
      return Future.value(resp);
    } catch (e) {
      if (e is DioException) {
        return Future.error(e.error ?? "");
      } else {
        return Future.error(e);
      }
    }
  }

  static Future post(String path,
      {Map<String, dynamic>? params, data, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      var resp =
          await HttpDio().post(path, data: data, params: params, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress, onSendProgress: onSendProgress);
      return Future.value(resp);
    } catch (e) {
      if (e is DioException) {
        return Future.error(e.error ?? "");
      } else {
        return Future.error(e);
      }
    }
  }

  static Future put(String path,
      {data, Map<String, dynamic>? params, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      var resp =
          await HttpDio().put(path, data: data, params: params, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
      return Future.value(resp);
    } catch (e) {
      if (e is DioException) {
        return Future.error(e.error ?? "");
      } else {
        return Future.error(e);
      }
    }
  }

  static Future patch(String path,
      {data, Map<String, dynamic>? params, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      var resp =
          await HttpDio().patch(path, data: data, params: params, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress, onSendProgress: onSendProgress);
      return Future.value(resp);
    } catch (e) {
      if (e is DioException) {
        return Future.error(e.error ?? "");
      } else {
        return Future.error(e);
      }
    }
  }

  static Future delete(String path, {data, Map<String, dynamic>? params, Options? options, CancelToken? cancelToken}) async {
    try {
      var resp = await HttpDio().delete(path, data: data, params: params, options: options, cancelToken: cancelToken);
      return Future.value(resp);
    } catch (e) {
      if (e is DioException) {
        return Future.error(e.error ?? "");
      } else {
        return Future.error(e);
      }
    }
  }

  static Future postForm(String path,
      {Map<String, dynamic>? params, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      var resp = await HttpDio().postForm(path, params: params, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
      return Future.value(resp);
    } catch (e) {
      if (e is DioException) {
        return Future.error(e.error ?? "");
      } else {
        return Future.error(e);
      }
    }
  }

  static Future download(String path, savePath,
      {Map<String, dynamic>? params, data, bool deleteOnError = true, ProgressCallback? onReceiveProgress, Options? options, CancelToken? cancelToken}) async {
    try {
      var resp = await HttpDio()
          .download(path, savePath, data: data, params: params, deleteOnError: deleteOnError, onReceiveProgress: onReceiveProgress, options: options, cancelToken: cancelToken);
      return Future.value(resp);
    } catch (e) {
      if (e is DioException) {
        return Future.error(e.error ?? "");
      } else {
        return Future.error(e);
      }
    }
  }
}
