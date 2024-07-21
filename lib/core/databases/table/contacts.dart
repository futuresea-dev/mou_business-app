import 'package:drift/drift.dart';

class Contacts extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text().nullable()();

  TextColumn get email => text().nullable()();

  @JsonKey("full_address")
  TextColumn get fullAddress => text().named("full_address").nullable()();

  TextColumn get birthday => text().nullable()();

  IntColumn get gender => integer().nullable()();

  @JsonKey("country_code")
  TextColumn get countryCode => text().named("country_code").nullable()();

  TextColumn get city => text().nullable()();

  @JsonKey("phone_number")
  TextColumn get phoneNumber => text().named("phone_number").nullable()();

  @JsonKey("dial_code")
  TextColumn get dialCode => text().named("dial_code").nullable()();

  TextColumn get avatar => text().nullable()();

  IntColumn get page => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}