import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/contact_dao.dart';
import 'package:mou_business_app/core/repositories/contact_repository.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class ContactListDialogViewModel extends BaseViewModel {
  ContactRepository contactRepository;
  ContactDao contactDao;

  ContactListDialogViewModel({required this.contactRepository, required this.contactDao});

  var contactsSubject = BehaviorSubject<List<Contact>>();
  var contactsSelectedSubject = BehaviorSubject<List<Contact>>();

  List<Contact>? contactsSelected;
  List<Contact>? contactsData;

  initData(List<Contact> contactsSelected) async {
    await contactRepository.getAllContacts();
    contactsData = await contactDao.getAllContacts();
    if (contactsData == null) contactsData = <Contact>[];
    contactsSubject.add(contactsData ?? []);

    if (this.contactsSelected == null) {
      this.contactsSelected = <Contact>[];
    }
    this.contactsSelected = contactsSelected;
    contactsSelectedSubject.add(contactsSelected);
  }

  void setContactSelected(Contact contact) {
    int? isExist;
    if (contactsSelected == null) {
      contactsSelected = <Contact>[];
    } else {
      isExist = contactsSelected?.indexWhere((item) => item.id == contact.id) ?? 0;
    }

    if (isExist != null && isExist != -1) {
      contactsSelected?.removeWhere((item) => item.id == contact.id);
      contactsSelectedSubject.add(contactsSelected ?? []);
    } else {
      contactsSelected?.add(contact);
      contactsSelectedSubject.add(contactsSelected ?? []);
    }
  }

  bool checkSelected(Contact contact) {
    if (contactsSelected == null) return false;
    return contactsSelected?.lastIndexWhere((item) => item.id == contact.id) != -1;
  }

  search(String text) {
    print("text search $text");
    List<Contact> contactsFilter = contactsData
            ?.where((item) => (item.name?.toLowerCase() ?? "").contains(text.toLowerCase()))
            .toList() ??
        [];
    print("contactsFilter ${contactsFilter.length}");
    contactsSubject.add(contactsFilter);
  }

  @override
  void dispose() {
    contactsSubject.drain();
    contactsSubject.close();

    contactsSelectedSubject.drain();
    contactsSelectedSubject.close();
    super.dispose();
  }
}
