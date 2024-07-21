import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/contact_dao.dart';
import 'package:mou_business_app/core/repositories/contact_repository.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class ContactDialogViewModel extends BaseViewModel {
  ContactRepository contactRepository;
  ContactDao contactDao;

  ContactDialogViewModel({required this.contactRepository, required this.contactDao});

  var contactsSubject = BehaviorSubject<List<Contact>>();
  var contactSelectedSubject = BehaviorSubject<Contact?>();
  final mapContactsSubject = BehaviorSubject<Map<String, List<Contact>>>();

  String? textSearch = "";
  Contact? contactSelected;
  List<Contact> contactsData = [];

  initData(Contact? contactSelected) async {
    await contactRepository.getAllContacts();
    contactsData = await contactDao.getAllContacts();
    contactsSubject.add(contactsData);

    this.contactSelected = contactSelected;
    contactSelectedSubject.add(contactSelected);

    final map = convertMapContacts(contactsData);
    mapContactsSubject.add(map);
  }

  void setContactSelected(Contact contact) {
    if (contactSelected?.id != null && contactSelected?.id == contact.id) {
      contactSelected = null;
    } else {
      contactSelected = contact;
    }
    contactSelectedSubject.add(contactSelected);
  }

  bool checkSelected(Contact contact) {
    if (contactSelected == null) return false;
    return contactSelected?.id == contact.id;
  }

  search(String text) {
    List<Contact> contactsFilter;
    if (text != "") {
      print("text search $text");
      contactsFilter = contactsData
          .where((item) => (item.name?.toLowerCase() ?? "").contains(text.toLowerCase()))
          .toList();
      print("contactsFilter ${contactsFilter.length}");
    } else {
      contactsFilter = contactsData;
    }
    this.textSearch = text;
    contactsSubject.add(contactsFilter);

    final map = convertMapContacts(contactsFilter);
    mapContactsSubject.add(map);
  }

  Future<void> onRefresh() async {
    contactsData = [];
    contactsSubject.add(contactsData);
    await this.initData(this.contactSelected);
    search(this.textSearch ?? "");
  }

  Map<String, List<Contact>> convertMapContacts(List<Contact> contacts) {
    Map<String, List<Contact>> mapContact = {};

    for (var contact in contacts) {
      var firstChar = contact.name?[0].toLowerCase() ?? "";

      if (mapContact.containsKey(firstChar)) {
        mapContact[firstChar]!.add(contact);
      } else {
        mapContact[firstChar] = [contact];
      }
    }

    var sortedCharKeys = mapContact.keys
        .where((key) => key != '0' && int.tryParse(key) == null)
        .toList()
      ..sort((a, b) => a.compareTo(b));

    var sortedNumberKeys = mapContact.keys.where((key) => int.tryParse(key) != null).toList()
      ..sort((a, b) {
        int intA = int.parse(a);
        int intB = int.parse(b);
        return intA - intB;
      });

    var sortedKeys = [...sortedCharKeys, ...sortedNumberKeys];

    Map<String, List<Contact>> sortedMap = {};
    for (var key in sortedKeys) {
      sortedMap[key] = mapContact[key]!;
    }

    return sortedMap;
  }

  @override
  void dispose() async {
    await contactsSubject.drain();
    contactsSubject.close();

    await contactSelectedSubject.drain();
    contactSelectedSubject.close();
    super.dispose();
  }
}
