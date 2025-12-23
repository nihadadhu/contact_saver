
import 'package:contact_saver/provider/contact_provider.dart';
import 'package:contact_saver/widget/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, _) {
          final favList = provider.favoriteContacts;

          if (favList.isEmpty) {
            return const Center(
              child: Text(
                "No favorite contacts ⭐",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: favList.length,
            itemBuilder: (context, index) {
              final contact = favList[index];
              return ContactCard(
                contact: contact,
                onFav: () => provider.toggleFavorite(contact.id),
                onDelete: () => provider.deleteContact(contact.id),
              );
            },
          );
        },
      ),
    );
  }
}
