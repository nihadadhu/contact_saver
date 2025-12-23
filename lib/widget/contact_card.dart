
import 'dart:io';

import 'package:contact_saver/appColor/app_colors.dart';
import 'package:contact_saver/model/contact_model.dart';
import 'package:contact_saver/sceens/contact_details_screen.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onFav;
  final VoidCallback onDelete;
  const ContactCard({
    super.key,
    required this.contact,
    required this.onFav,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Dismissible(
        key: ValueKey(contact.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red.shade500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.delete, color: Colors.white, size: 28),
        ),
        confirmDismiss: (_) async {
          return await _confirmDelete(context);
        },
        onDismissed: (_) {
          onDelete();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Contact deleted")));
        },
        child:  Container(
  decoration: BoxDecoration(
    color: LightColors.bg,
    borderRadius: BorderRadius.circular(50),
    boxShadow: const [
      BoxShadow(
        offset: Offset(1, 1),
        spreadRadius: 1,
        blurRadius: 1,
        color: Colors.grey,
      ),
    ],
  ),
  child: ListTile(
    leading: CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey.shade300,
      backgroundImage: contact.imagePath != null
          ? FileImage(File(contact.imagePath!))
          : null,
      child: contact.imagePath == null
          ? const Icon(Icons.person, size: 30)
          : null,
    ),
    title: Text(
      contact.name,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    subtitle: Text(contact.phone),
    trailing: IconButton(
      icon: Icon(
        contact.isFavorite
            ? Icons.star
            : Icons.star_border,
        color: Colors.deepPurple,
      ),
      onPressed: onFav,
    ),
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProfileViewScreen(contactId: contact.id),
    ),
  );
},

  ),
),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Contact"),
        content: const Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
