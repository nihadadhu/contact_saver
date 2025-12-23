import 'package:contact_saver/provider/contact_provider.dart';
import 'package:contact_saver/sceens/contact_list_screen.dart';
import 'package:contact_saver/sceens/favorite_screen.dart';
import 'package:contact_saver/sceens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<MainPage> {
  int currentIndex = 0;

  final screens = const [
   
    Center(child:ContactListScreen()),
     Center(child: FavoriteScreen()),
    Center(child: SettingScreen()),
  ];
@override
void initState() {
  super.initState();
  context.read<ContactProvider>().loadContacts();
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
           
            _navItem(Icons.home_outlined, "Home", 0),
            _navItem(Icons.favorite_outline, "Favorite", 1),
            _navItem(Icons.settings_outlined, "Settings", 2),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      label: label,
      icon: AnimatedScale(
        scale: currentIndex == index ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 250),
        child: Icon(icon),
      ),
    );
  }
}
