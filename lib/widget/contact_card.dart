import 'dart:developer';
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
        child: GestureDetector(
          onTap: () {
            log('message');
          },
          child: Container(
            decoration: BoxDecoration(
              color: LightColors.bg,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: Colors.grey,
                ),
              ],
            ),
            child: ListTile(
              onTap: () {
                // showModalBottomSheet(
                //   context: context,
                //   isScrollControlled: true,
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                //   ),
                //   builder: (_) {
                // return

                ProfileViewScreen(
                  contact: contact,
                  onFav: onFav,
                  onDelete: onDelete,
                );
                // },
                // );
              },
              leading: CircleAvatar(
                backgroundImage: contact.imagePath != null
                    ? FileImage(File(contact.imagePath!))
                    : null,
                child: contact.imagePath == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(
                contact.name,
                style: TextStyle(color: LightColors.text),
              ),
              subtitle: Text(
                contact.phone,
                style: TextStyle(color: LightColors.text),
              ),
              trailing: SizedBox(
                width: 96,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: onFav,
                      icon: Icon(
                        contact.isFavorite ? Icons.star : Icons.star_border,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: onDelete,
                    //   icon: const Icon(Icons.delete_outline),
                    // ),
                  ],
                ),
              ),
            ),
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
            child: const Text(
              "Delete",
              style: TextStyle(color: DarkColors.text),
            ),
          ),
        ],
      ),
    );
  }
}
