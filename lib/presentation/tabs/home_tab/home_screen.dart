import 'package:flora_mart/config/theme/app_theme.dart';
import 'package:flora_mart/core/utils/colors_manager.dart';
import 'package:flora_mart/presentation/tabs/cart_tab/cart_screen.dart';
import 'package:flora_mart/presentation/tabs/categories_tab/categories_screen.dart';
import 'package:flora_mart/presentation/tabs/profile_tab/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
