import 'package:contact_saver/appColor/app_colors.dart';

import 'package:contact_saver/provider/contact_provider.dart';
import 'package:contact_saver/sceens/add_edit_screen.dart';

import 'package:contact_saver/widget/contact_card.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 160,
              backgroundColor: Colors.deepPurple,
              title: const Text(
                'Contacts',
                style: TextStyle(
                  color: DarkColors.text,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
      
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _searchBar(context),
                    ),
                  ),
                ),
              ),
            ),
      
            Consumer<ContactProvider>(
              builder: (context, provider, _) {
                final filteredContacts = provider.getFilteredContacts();
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final c = filteredContacts[index];
                    return ContactCard(
                      contact: c,
                      onFav: () => provider.toggleFavorite(c.id),
                      onDelete: () => provider.deleteContact(c.id),
                    );
                  }, childCount: filteredContacts.length),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddEditScreen()),
            );
          },
          shape: CircleBorder(),
          backgroundColor: Colors.deepPurpleAccent,
          child: Icon(Icons.person_add_alt, color: DarkColors.icon),
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<ContactProvider>().setSearchQuery(value);
      },
      decoration: InputDecoration(
        hintText: 'Search contacts...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
