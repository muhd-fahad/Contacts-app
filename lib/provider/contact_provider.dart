import 'package:contacts/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contact = [];

  List<Contact> get contact => _contact;

  void addContact(Contact contact) {
    _contact.add(contact);
    notifyListeners();
  }
  void updateContact(int index, Contact newContact) {
    _contact[index] = newContact;
    notifyListeners();
  }

  void deleteContact(int index) {
      contact.removeAt(index);
      notifyListeners();
  }
}
