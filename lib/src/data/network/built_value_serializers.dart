library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:ains_open_dart/src/models/license.dart';
import 'package:ains_open_dart/src/models/owner.dart';
import 'package:ains_open_dart/src/models/permissions.dart';
import 'package:ains_open_dart/src/models/repo.dart';

part 'built_value_serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
  Repo,
  Owner,
  Permissions,
  License
])
final Serializers serializers = _$serializers;

final jsonSerializers = (serializers.toBuilder()
//response
  ..addPlugin(StandardJsonPlugin()))
    .build();
