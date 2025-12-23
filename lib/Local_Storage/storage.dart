
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const keyContact = "contact";
  static Future<void> saveContacts(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyContact, data);
  }

  static Future<String?> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyContact);
  }

  
}
