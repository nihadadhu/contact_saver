import 'package:contact_saver/model/contact_model.dart';
import 'package:contact_saver/provider/contact_provider.dart';
import 'package:contact_saver/provider/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactFormProvider with ChangeNotifier {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
   ContactModel? editingContact;

  ContactFormProvider() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  String name = '';
  String phone = '';
  String email = '';

  String? nameError;
  String? phoneError;
  String? emailError;

  void loadContact(ContactModel contact) {
    editingContact = contact;

    nameController.text = contact.name;
    phoneController.text = contact.phone;
    emailController.text = contact.email;

    name = contact.name;
    phone = contact.phone;
    email = contact.email;
    notifyListeners();
  }

  bool get isEdit => editingContact != null;

  void save(BuildContext context) {
    final contactProvider = context.read<ContactProvider>();
    final imageProvider = context.read<ImagePickerProvider>();

    if (editingContact == null) {
      contactProvider.addContact(
        ContactModel(
          id: DateTime.now().toString(),
          name: nameController.text,
          phone: phoneController.text,
          email: emailController.text,
          imagePath: imageProvider.image?.path,
          isFavorite: editingContact?.isFavorite ?? false,
        ),
      );
    } else if (editingContact != null) {
     editingContact!
  ..name = nameController.text
  ..phone = phoneController.text
  ..email = emailController.text
  ..imagePath = imageProvider.image?.path;

    }
    clearController();
    editingContact = null;
  }

  void setName(String val) {
    name = val.trim();

    if (name.isEmpty) {
      nameError = 'Name is required!';
    } else {
      nameError = null;
    }

    notifyListeners();
  }

  void setPhone(String val) {
    phone = val.trim();

    if (phone.isEmpty) {
      phoneError = 'Phone number is required!';
    } else if (phone.length != 10) {
      phoneError = 'Enter a valid phone number!';
    } else {
      phoneError = null;
    }

    notifyListeners();
  }

  void setEmail(String val) {
    email = val.trim();

    if (email.isEmpty) {
      emailError = 'Email is required!';
    } else if (!email.contains('@')) {
      emailError = 'Invalid email address!';
    } else {
      emailError = null;
    }

    notifyListeners();
  }

  bool validateForm() {
    setName(name);
    setPhone(phone);
    setEmail(email);

    return nameError == null && phoneError == null && emailError == null;
  }

  void clear() {
    name = '';
    phone = '';
    email = '';
    nameError = null;
    phoneError = null;
    emailError = null;
    notifyListeners();
  }

  // void addContact(BuildContext context) {
  //   final contactprovider = context.read<ContactProvider>();
  //   final imageprovider = context.read<ImagePickerProvider>();
  //   contactprovider.addContact(
  //     ContactModel(
  //       id: DateTime.now().toString(),
  //       name: nameController.text,
  //       phone: phoneController.text,
  //       email: emailController.text,
  //       imagePath: imageprovider.image?.path,
  //     ),
  //   );
  // }

  void clearController() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    clear();
    notifyListeners();
  }

  void reset() {
    name = '';
    phone = '';
    email = '';

    nameError == null;
    phoneError == null;
    emailError == null;
  }
}
