import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

class DateTimeConverter extends TypeConverter<String, DateTime?> {
  const DateTimeConverter();

  @override
  fromSql(DateTime? fromDb) {
    // TODO: implement mapToSql
    print("Date time mapToSql: ${fromDb.toString()}");
    return fromDb != null ? DateFormat("yyyy-MM-dd HH:mm:ss").format(fromDb) : "";
  }

  @override
  DateTime? toSql(value) {
    print("Date time mapToDart: $value");
    return DateTime.parse(value);
  }
}
