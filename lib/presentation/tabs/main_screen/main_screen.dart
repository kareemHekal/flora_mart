import 'package:flutter/material.dart';
import 'package:flora_mart/presentation/tabs/home_tab/home_screen.dart';
import 'package:flora_mart/presentation/tabs/categories_tab/categories_screen.dart';
import 'package:flora_mart/presentation/tabs/cart_tab/cart_screen.dart';
import 'package:flora_mart/presentation/tabs/profile_tab/profile_screen.dart';
import 'package:flora_mart/core/utils/colors_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'navigation.home'.tr(), // Using translation key
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: 'navigation.category'.tr(), // Using translation key
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'navigation.cart'.tr(), // Using translation key
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'navigation.profile'.tr(), // Using translation key
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: ColorManager.primaryColor,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      ),
    );
  }
}
