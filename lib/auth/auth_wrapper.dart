import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/auth/login.dart';
import 'package:flutter_delivery/home_wrapper.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authFunc = context.watch<AuthFunc>().authStateChanges;
    return StreamBuilder(
      stream: authFunc,
      builder: ((_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user == null ? Login() : const HomeWrapper();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
