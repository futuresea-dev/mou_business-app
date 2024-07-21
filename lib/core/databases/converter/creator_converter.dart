import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mou_business_app/core/models/creator.dart';

class CreatorConverter extends TypeConverter<Creator, String> {
  const CreatorConverter();

  @override
  Creator fromSql(String fromDb) {
    return Creator.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(Creator value) {
    //if (value == null) return null;
    return json.encode(value.toJson());
  }
}
