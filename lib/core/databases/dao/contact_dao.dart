import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/table/contacts.dart';

import '../app_database.dart';

part 'contact_dao.g.dart';

@DriftAccessor(tables: [Contacts])
class ContactDao extends DatabaseAccessor<AppDatabase> with _$ContactDaoMixin {
  final AppDatabase db;

  ContactDao(this.db) : super(db);

  Future<List<Contact>> getAllContacts() => (select(contacts)
        ..orderBy(
            [(c) => OrderingTerm(expression: c.name, mode: OrderingMode.asc)]))
      .get();

  Future<List<Contact>> getAllContactByID(int id) =>
      (select(contacts)..where((t) => t.id.equals(id))).get();

  Future<Contact> getContactByID(int id) =>
      (select(contacts)..where((t) => t.id.equals(id))).getSingle();

  Future<int> getCountContactByID(int id) async {
    List<Contact> contacts = await getAllContactByID(id);
    return contacts.isEmpty == true ? 0 : contacts.length;
  }

  Stream<List<Contact>> watchAllContacts() => (select(contacts)
        ..orderBy(
            [(c) => OrderingTerm(expression: c.name, mode: OrderingMode.asc)]))
      .watch();

  Stream<Contact> watchAllContactByID(int id) =>
      (select(contacts)..where((t) => t.id.equals(id))).watchSingle();

  Future insertContact(Contact contact) =>
      into(contacts).insert(contact, mode: InsertMode.insertOrReplace);

  Future updateContact(Contact contact) => update(contacts).replace(contact);

  Future deleteContact(Contact contact) => delete(contacts).delete(contact);

  Future deleteContactByID(int id) =>
      (delete(contacts)..where((c) => c.id.equals(id))).go();

  Future deleteAll() => delete(contacts).go();
}
