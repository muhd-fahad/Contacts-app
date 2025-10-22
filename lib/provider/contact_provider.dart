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
      print('Error loading contacts from database: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addContact(Contact contact) async {
    final id = await DbHelper.instance.insertContact(contact);
    // Create a copy of the contact with the new database ID
    final newContact = Contact(id: id, name: contact.name, phone: contact.phone);
    _contacts.add(newContact);
    notifyListeners();
  }

  Future<void> updateContact(Contact updatedContact) async {
    await DbHelper.instance.updateContact(updatedContact);

    // Find the contact in the in-memory list and update it
    final index = _contacts.indexWhere((c) => c.id == updatedContact.id);
    if (index != -1) {
      _contacts[index] = updatedContact;
      notifyListeners();
    }
  }

  Future<void> deleteContact(int id) async {
    await DbHelper.instance.deleteContact(id);

    // Remove the contact from the in-memory list
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
