import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/auth/login.dart';
import 'package:flutter_delivery/truck/search_delivery.dart';
import 'package:flutter_delivery/truck/truck_home.dart';
import 'package:provider/provider.dart';

import '../profile.dart';

class TruckRoot extends StatefulWidget {
  const TruckRoot({Key? key}) : super(key: key);

  @override
  State<TruckRoot> createState() => _TruckRootState();
}

class _TruckRootState extends State<TruckRoot> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    AuthFunc authProvider = Provider.of<AuthFunc>(context, listen: false);
    final user = authProvider.userModel;

    if (user == null) {
      return Login();
    }

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        TruckHome(),
        SearchDelivery(),
        const Profile(),
      ][currentPageIndex],
    );
  }
}
