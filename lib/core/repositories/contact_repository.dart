import 'package:dio/dio.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/contact_dao.dart';
import 'package:mou_business_app/core/models/user.dart';
import 'package:mou_business_app/core/requests/contact_request.dart';
import 'package:mou_business_app/core/services/api_service.dart';

import '../network_bound_resource.dart';
import '../resource.dart';

class ContactRepository {
  CancelToken _cancelToken = CancelToken();
  final ContactDao contactDao;

  ContactRepository(this.contactDao);

  Future<Resource<List<Contact>>> getAllContacts() async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<List<Contact>, List<Contact>>(
      createCall: () => APIService.getContacts(_cancelToken),
      parsedData: (json) {
        var data = json as List;
        return data.map((contact) => Contact.fromJson(contact)).toList();
      },
      saveCallResult: (contacts) async {
        contactDao.deleteAll();
        for (Contact contact in contacts) {
          await contactDao.insertContact(contact);
        }
      },
      loadFromDb: () => contactDao.getAllContacts(),
    );

    return resource.getAsObservable();
  }

  Future<Resource<List<User>>> searchUsers(String search) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<List<User>, List<User>>(
      createCall: () => APIService.searchUsers(search, _cancelToken),
      parsedData: (json) {
        final users = json as List;
        return users.map((event) => User.fromJson(event)).toList();
      },
      saveCallResult: null,
    );
    return resource.getAsObservable();
  }

  Future<Resource<Contact>> linkContact(int id) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<Contact, Contact>(
      createCall: () => APIService.linkContact(id, _cancelToken),
      parsedData: (json) => Contact.fromJson(json),
      saveCallResult: (contact) => contactDao.insertContact(contact),
    );
    return resource.getAsObservable();
  }

  Future<Resource<Contact>> addContact(ContactRequest contactRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<Contact, Contact>(
      createCall: () => APIService.addContact(contactRequest, _cancelToken),
      parsedData: (json) => Contact.fromJson(json),
      saveCallResult: (contact) => contactDao.insertContact(contact),
    );
    return resource.getAsObservable();
  }

  Future<Resource<Contact>> editContact(int id, ContactRequest contactRequest) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<Contact, Contact>(
      createCall: () => APIService.editContact(id, contactRequest, _cancelToken),
      parsedData: (json) => Contact.fromJson(json),
      saveCallResult: (contact) => contactDao.insertContact(contact),
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> deleteContact(Contact contact) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.deleteContact(contact, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: (c) => contactDao.deleteContactByID(contact.id),
    );
    return resource.getAsObservable();
  }

  Future<Resource<List<User>>> connectContactFacebook(
      String facebookID, List<String> friendIDs) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<List<User>, List<User>>(
      createCall: () => APIService.connectContactFacebook(facebookID, friendIDs, _cancelToken),
      parsedData: (json) {
        final users = json as List;
        return users.map((event) => User.fromJson(event)).toList();
      },
      saveCallResult: null,
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> importContactFacebook(List<String> friendIDs) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.importContactFacebook(friendIDs, _cancelToken),
      parsedData: (json) => json,
      saveCallResult: null,
    );
    return resource.getAsObservable();
  }

  Future<Resource<dynamic>> importContact(List<ContactRequest> contactRequests) {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<dynamic, dynamic>(
      createCall: () => APIService.importContacts(contactRequests, _cancelToken),
      parsedData: (json) => print(json),
      saveCallResult: (c) async => await null,
    );
    return resource.getAsObservable();
  }

  cancel() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }
}
