import 'dart:convert';

String toJsonString<T>(T model) {
  var modelMap = _getModelSerializer<T>().toMap(model);
  return jsonEncode(modelMap);
}

T fromJsonString<T>(String jsonString) {
  var modelMap = jsonDecode(jsonString) as Map<String, dynamic>;
  return _getModelSerializer<T>().fromMap(modelMap) as T;
}

String toJsonArrayString<T>(List<T> models) {
  var modelSerializer = _getModelSerializer<T>();
  var modelsMap = models.map((model) => modelSerializer.toMap(model)).toList();
  return jsonEncode(modelsMap);
}

List<T> fromJsonArrayString<T>(String jsonArrayString) {
  var modelSerializer = _getModelSerializer<T>();
  var jsonArrayStringMap = jsonDecode(jsonArrayString) as Iterable;
  if (jsonArrayStringMap != null) {
    return jsonArrayStringMap.map((d) => modelSerializer.fromMap(d as Map<String, dynamic>) as T).toList();
  }
  return [];
}

Map<String, dynamic> toMap<T>(T model) {
  return _getModelSerializer<T>().toMap(model) as Map<String, dynamic>;
}

T fromMap<T>(Map<String, dynamic> modelmap) {
  return _getModelSerializer<T>().fromMap(modelmap) as T;
}

List<Map<String, dynamic>> toMapArray<T>(List<T> models) {
  var modelSerializer = _getModelSerializer<T>();
  return models.map((model) => modelSerializer.toMap(model) as Map<String, dynamic>).toList();
}

List<T> fromMapArray<T>(List<Map<String, dynamic>> modelmaps) {
  var modelSerializer = _getModelSerializer<T>();
  return modelmaps.map((modelMap) => modelSerializer.fromMap(modelMap) as T).toList();
}

Serializer<T> _getModelSerializer<T>() {
  return Serializer<T>();
}

class Serializer<T> {
  fromMap(Map<String, dynamic> modelmap) {}

  toMap(T model) {}
}
