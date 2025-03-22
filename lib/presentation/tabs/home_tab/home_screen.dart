import 'package:flora_mart/core/resuable_comp/dialogs.dart';
import 'package:flutter/material.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      color: Colors.red,
      child: FilledButton(
          onPressed: () {
            return Dialogs.restrictedAccess(context);
          },
          child: Text("Guest")),
    )));
  }
}
