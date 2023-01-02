// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_delivery/models/dummy.dart';
import 'package:flutter_delivery/widgets/custom_info_tile.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'auth/login.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthFunc>().userModel!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          CustomInfoTile(title: 'Name', info: user.name),
          CustomInfoTile(title: 'Email', info: user.email),
          CustomInfoTile(title: 'ID', info: user.id),
          CustomInfoTile(title: 'Account Type', info: user.type),
          ElevatedButton(
            onPressed: () => context.read<AuthFunc>().signOut(),
            child: Text('Log Out'),
          ),
          Dummy(),
        ],
      ),
    );
  }
}
