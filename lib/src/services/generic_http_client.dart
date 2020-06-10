import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:ains_open_dart/src/utilities/serializer_extension.dart';
import 'package:ains_open_dart/src/models/api/http_client_model.dart';
import 'package:ains_open_dart/src/models/api/http_client_status_code.dart';
import 'package:ains_open_dart/src/models/maps/http_map.dart';
import 'package:ains_open_dart/src/services/base_http_client.dart';
import 'package:ains_open_dart/src/services/connectivity/base_connectivity_service.dart';
import 'package:ains_open_dart/src/services/connectivity/connectivity_service.dart';

class HttpClient implements BaseHttpClient {
  Dio dio;
  List<HttpClientStatusCode> get _success => [
    HttpClientStatusCode.OK,
    HttpClientStatusCode.CREATED,
    HttpClientStatusCode.NO_CONTENT
  ];

  BaseConnectivityService connectivityService;

  HttpClient({BaseConnectivityService connectivityService})
      : this.connectivityService =
      connectivityService ?? ConnectivityService() {
    dio = Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ));
    dio.httpClientAdapter = Http2Adapter(ConnectionManager(idleTimeout: 10000));
  }

  Future<HttpClientStatusCode> _checkConnectivity() async {
    HttpClientStatusCode clientStatusCode;
    try {
      var hasConnection = await connectivityService.hasConnection;
      clientStatusCode = hasConnection
          ? HttpClientStatusCode.NO_INTERNET
          : HttpClientStatusCode.ERROR;
    } catch (e) {
      clientStatusCode = HttpClientStatusCode.ERROR;
    }
    return clientStatusCode;
  }

  FutureOr<HttpClientModel> _onGetError(DioError e) async {
    HttpClientStatusCode errorCode;
    if (e.error.runtimeType == HttpException) {
      errorCode = await _checkConnectivity();
    }
    if (e.error.runtimeType == SocketException) {
      errorCode = HttpClientStatusCode.NO_INTERNET;
    }
    if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorCode = HttpClientStatusCode.SLOW_SERVER;
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      errorCode = HttpClientStatusCode.SLOW_INTERNET;
    }
    errorCode =
        httpErrorVal[e.response?.statusCode] ?? HttpClientStatusCode.ERROR;
    return HttpClientModel(error: errorCode);
  }

  T _parseJson<T>(String data, {bool isArray}) {
    return isArray ? fromJsonArrayString<T>(data) : fromJsonString<T>(data);
  }

  Future<HttpClientModel<T>> _buildClientModel<T>(
      {Future<Response> Function() dioHttpAction, bool isArray = false}
      ) async {
    HttpClientModel<T> _responseModel;
    try {
      var response = await dioHttpAction();
      if (_success.contains(httpErrorVal[response.statusCode])) {
        _responseModel = HttpClientModel<T>(
            error: HttpClientStatusCode.NONE,
            model: await compute<String, T>(
                    (responseData) => _parseJson<T>(responseData, isArray: isArray),
                response.data));
      } else {
        _responseModel = HttpClientModel(
          error: httpErrorVal[response?.statusCode] ?? HttpClientStatusCode.ERROR,
        );
      }
    } on DioError catch (e) {
      _responseModel = _onGetError(e) as HttpClientModel<T>;
    } catch (e) {
      _responseModel = HttpClientModel(error: HttpClientStatusCode.ERROR);
    }
    return _responseModel;
  }

  Future<HttpClientModel<T>> _baseGet<T>(String url, {bool isArray = false}) async {
    return _buildClientModel<T>(
        dioHttpAction: () {
          return dio.get(url);
        },
        isArray: isArray
    );
  }

  @override
  Future<HttpClientModel<T>> get<T>(String url) => _baseGet(url);

  @override
  Future<HttpClientModel<T>> getAll<T>(String url) => _baseGet(url, isArray: true);

  @override
  Future<HttpClientModel<T>> post<T>(T data, String url, {bool isArray = false}) {
    return _buildClientModel<T>(
        dioHttpAction: () {
          return dio.post(url, data: data);
        },
        isArray: isArray);
  }

  Future<HttpClientModel<T>> put<T>(T data, String url, {bool isArray = false}) {
    return _buildClientModel<T>(
        dioHttpAction: () {
          return dio.put(url, data: data);
        },
        isArray: isArray);
  }

  Future<HttpClientModel<T>> delete<T>(T data, String url, {bool isArray = false}) {
    return _buildClientModel<T>(
        dioHttpAction: () {
          return dio.delete(url, data: data);
        },
        isArray: isArray);
  }
}
