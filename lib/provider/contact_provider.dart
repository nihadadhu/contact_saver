import 'dart:convert';

import 'package:contact_saver/Local_Storage/storage.dart';
import 'package:contact_saver/model/contact_model.dart';
import 'package:flutter/material.dart';


class ContactProvider with ChangeNotifier {
  List<ContactModel> _contact = [];
  String searchQuery = '';
  List<ContactModel> get contact => _contact;
  List<ContactModel> get favoriteContacts =>
      _contact.where((c) => c.isFavorite).toList();

  List<ContactModel> getFilteredContacts() {
    if (searchQuery.isEmpty) {
      return _contact;
    }
    return _contact
        .where((c) => c.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void setSearchQuery(String value) {
    searchQuery = value;
    notifyListeners();
  }

  void updateContact(ContactModel updateContact) {
    final index = _contact.indexWhere((c) => c.id == updateContact.id);
    if (index != -1) {
      _contact[index] = updateContact;
      save();
      loadContacts();
      notifyListeners();
    }
  }

  void addContact(ContactModel c) {
    _contact.add(c);
    save();
    notifyListeners();
  }

  void deleteContact(String id) {
    _contact.removeWhere((c) => c.id == id);
    save();
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final c = _contact.indexWhere((c) => c.id == id);
    if (c != -1) {
      _contact[c].isFavorite = !_contact[c].isFavorite;
      save();
      notifyListeners();
    }
  }

  void saveContacts() {}

  void save() {
    LocalStorageService.saveContacts(
      jsonEncode(_contact.map((c) => c.toJson()).toList()),
    );
  }

  Future<void> loadContacts() async {
    final data = await LocalStorageService.loadContacts();
    if (data != null) {
      _contact = (jsonDecode(data) as List)
          .map((e) => ContactModel.fromJson(e))
          .toList();
      notifyListeners();
    }
  }
}
