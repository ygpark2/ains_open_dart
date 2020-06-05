import 'package:chopper/chopper.dart';
import 'package:ains_open_dart/src/data/network/built_value_serializers.dart';
import 'package:ains_open_dart/src/data/network/services.dart';
import 'package:built_collection/built_collection.dart';
import 'package:ains_open_dart/src/models/repo.dart';

import 'factory_converter.dart';

class GithubRepository {
  static final _instance = GithubRepository();
  static GithubRepository get = _instance;

  GithubService githubService;

  GithubRepository() {
    var chopper = new ChopperClient(
      baseUrl: 'https://api.github.com',
      services: [
        // the generated service
        GithubService.create(),
      ],
      converter: BuiltValueConverter(jsonSerializers),
      errorConverter: BuiltValueConverter(jsonSerializers),
    );
    githubService = GithubService.create(chopper);
  }

  Future<BuiltList<Repo>> getRepo(String path) async {
    try {
      var response = await githubService.getRepositories(path);
      return response.body;
    } catch (ex) {
      return Future.value(BuiltList<Repo>());
    }
  }
}
