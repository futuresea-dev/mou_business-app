import 'dart:convert';

import 'package:drift/drift.dart';

class MapConverter extends TypeConverter<Map<String, dynamic>, String> {
  const MapConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) => jsonDecode(fromDb);

  @override
  String toSql(Map<String, dynamic> value) => jsonEncode(value);
}

