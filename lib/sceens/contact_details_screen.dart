import 'dart:io';
import 'package:contact_saver/appColor/app_colors.dart';
import 'package:contact_saver/model/contact_model.dart';
import 'package:contact_saver/sceens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileViewScreen extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onFav;
  final VoidCallback onDelete;

  const ProfileViewScreen({
    super.key,
    required this.contact,
    required this.onFav,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    void showDeleteDialog() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Delete Contact"),
          content: const Text("Are you sure you want to delete this contact?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 231, 105, 96),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
                onDelete();
              },
              child: const Text("OK", style: TextStyle(color: DarkColors.text)),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        height: 850,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          ),
        ),
        child: Column(
          children: [
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: onFav,

                    icon: Icon(
                      contact.isFavorite ? Icons.star : Icons.star_border,
                    ),
                    color: DarkColors.icon,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditScreen(contact: contact,),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit_outlined),
                      color: DarkColors.icon,
                    ),

                    IconButton(
                      onPressed: showDeleteDialog,
                      icon: Icon(Icons.delete_outline_outlined),
                      color: DarkColors.icon,
                    ),
                  ],
                ),
              ],
            ),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.deepPurple.shade100,
              backgroundImage: contact.imagePath != null
                  ? FileImage(File(contact.imagePath!))
                  : null,
              child: contact.imagePath == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
            const SizedBox(height: 20),
            Text(
              contact.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: DarkColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              contact.phone,
              style: const TextStyle(fontSize: 16, color: DarkColors.text),
            ),
            const SizedBox(height: 8),
            Text(
              contact.email,
              style: const TextStyle(fontSize: 16, color: DarkColors.text),
            ),
            const SizedBox(height: 30),
            _infoTile(Icons.phone_outlined, contact.phone),
            _infoTile(Icons.email_outlined, contact.email),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: Icon(icon, color: Colors.deepPurple),
          title: Text(text),
        ),
      ),
    );
  }
}
