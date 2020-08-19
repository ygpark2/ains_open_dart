import 'package:ains_open_dart/src/services/base_http_client.dart';
import 'package:ains_open_dart/src/services/http_client.dart';

class SampleService {

  BaseHttpClient httpClient;

  SampleService({BaseHttpClient httpClient})
      : this.httpClient = httpClient ?? HttpClient();

  void getData() {}
}
