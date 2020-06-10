import 'package:ains_open_dart/src/models/api/http_client_status_code.dart';

class HttpClientModel<T> {
  T model;

  HttpClientStatusCode error;

  String message;

  HttpClientModel({this.model, this.error, this.message});
}
