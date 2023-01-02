import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/business/make_order.dart';
import 'package:provider/provider.dart';

class BusinessHome extends StatelessWidget {
  BusinessHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Welcome to Business Owner Page",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((context) {
                      return MakeOrder();
                    })));
                  },
                  child: const Text('Create an order'),
                ),
                StreamBuilder(
                  stream: context.watch<AuthFunc>().authStateChanges,
                  builder: (context, snapshot) => ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthFunc>(context, listen: false).signOut();
                      },
                      child: const Text('Log Out')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
