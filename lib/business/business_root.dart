import 'package:flutter/material.dart';
import 'package:flutter_delivery/business/business_home.dart';
import 'package:flutter_delivery/business/see_orders_screen.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';
import '../auth/login.dart';
import '../profile.dart';

class BusinessRoot extends StatefulWidget {
  const BusinessRoot({Key? key}) : super(key: key);

  @override
  State<BusinessRoot> createState() => _BusinessRootState();
}

class _BusinessRootState extends State<BusinessRoot> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    AuthFunc authProvider = Provider.of<AuthFunc>(context, listen: false);
    final loggedIn = authProvider.loggedIn;
    if (loggedIn == false) {
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
            label: 'Your orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        BusinessHome(),
        SeeOrdersScreen(),
        const Profile(),
      ][currentPageIndex],
    );
  }
}
