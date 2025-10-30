import 'package:contacts/model/contact_model.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];
  bool _isLoading = true;

  List<Contact> get contacts => _contacts;

  bool get isLoading => _isLoading;

  ContactProvider() {
    loadContacts();
  }

  Future<void> loadContacts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final contacts = await DbHelper.instance.getContacts();
      _contacts.clear();
      _contacts.addAll(contacts);
    } catch (e) {
      debugPrint('Error loading contacts from database: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addContact(Contact contact) async {
    final id = await DbHelper.instance.insertContact(contact);
    final newContact = Contact(id: id, name: contact.name, phone: contact.phone, email: contact.email, address: contact.address);
    _contacts.add(newContact);
    notifyListeners();

    debugPrint('\n${'+ '*10} new contact added ${' +'*10}\n');
  }

  Future<void> updateContact(Contact updatedContact) async {
    await DbHelper.instance.updateContact(updatedContact);
    final index = _contacts.indexWhere((c) => c.id == updatedContact.id);
    if (index != -1) {
      _contacts[index] = updatedContact;
      notifyListeners();

      debugPrint('\n${'* '*10} contact updated ${' *'*10}\n');
    }
  }

  Future<void> deleteContact(int id) async {
    await DbHelper.instance.deleteContact(id);
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();

    debugPrint('\n${'- '*10} contact deleted ${' -'*10}\n');
  }
}
