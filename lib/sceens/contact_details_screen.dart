import 'dart:io';
import 'package:contact_saver/appColor/app_colors.dart';
import 'package:contact_saver/provider/contact_provider.dart';
import 'package:contact_saver/sceens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProfileViewScreen extends StatelessWidget {
  final String contactId;

  const ProfileViewScreen({super.key, required this.contactId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactProvider>();
    
  final contact = provider.contact.where((c) => c.id == contactId).isNotEmpty
      ? provider.contact.firstWhere((c) => c.id == contactId)
      : null;

 
  if (contact == null) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Contact not found",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

    void showDeleteDialog() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Delete Contact"),
          content: const Text("Are you sure you want to delete this contact?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                provider.deleteContact(contactId);
                Navigator.pop(ctx); // close dialog
                Navigator.pop(context); // go back to contact list
              },

              child: const Text(
                "del",
                style: TextStyle(color: DarkColors.text),
              ),
            ),
          ],
        ),
      );
    }

    

    
      return Scaffold(
        body: Container(
          height: 810,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            ),
          ),
          child: Column(
            children: [
              const Gap(20),

              /// TOP ACTION BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => provider.toggleFavorite(contactId),
                    icon: Icon(
                      contact.isFavorite ? Icons.star : Icons.star_border,
                      color: DarkColors.icon,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditScreen(contact: contact),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit_outlined),
                        color: DarkColors.icon,
                      ),
                      IconButton(
                        onPressed: showDeleteDialog,
                        icon: const Icon(Icons.delete_outline),
                        color: DarkColors.icon,
                      ),
                    ],
                  ),
                ],
              ),

              /// PROFILE IMAGE
              CircleAvatar(
                radius: 60,
                backgroundImage: contact.imagePath != null
                    ? FileImage(File(contact.imagePath!))
                    : null,
                child: contact.imagePath == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),

              const Gap(20),

              /// NAME
              Text(
                contact.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: DarkColors.text,
                ),
              ),

              const Gap(8),

              /// PHONE
              Text(
                contact.phone,
                style: const TextStyle(fontSize: 16, color: DarkColors.text),
              ),

              const Gap(30),

              _infoTile(Icons.phone, contact.phone),
              _infoTile(Icons.email, contact.email),
            ],
          ),
        ),
      );
    }
  }


Widget _infoTile(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(text),
      ),
    ),
  );
}
