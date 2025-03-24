import 'package:flora_mart/core/resuable_comp/dialogs.dart';
import 'package:flora_mart/presentation/auth/view_model/cubit/auth_cubit.dart';
import 'package:flora_mart/presentation/auth/view_model/cubit/auth_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //📌📌📌 This code explains the process of changing the value of a guest and 📌📌📌
    //📌📌📌 checking whether it is a guest or not.📌📌📌

    AuthCubit.get(context).doIntent(CheckGuestIntent());

    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is CeckGuestState) {
            if (state.isGuest) {
              Dialogs.restrictedAccess(
                context,
                () => Navigator.pop(context),
              );
            }
          }
        },
        child: Center(
          child: Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    AuthCubit.get(context)
                        .doIntent(ChangeGuestIntent(isGuest: false));
                  },
                  child: Text(
                    "login",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    AuthCubit.get(context)
                        .doIntent(ChangeGuestIntent(isGuest: true));
                  },
                  child: Text(
                    "guest",
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                color: Colors.red,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text("user"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
