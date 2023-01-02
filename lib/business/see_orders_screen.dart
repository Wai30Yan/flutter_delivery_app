import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/models/order_model.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';

class SeeOrdersScreen extends StatelessWidget {
  SeeOrdersScreen({Key? key}) : super(key: key);
  // final CollectionReference _orders =
  //     FirebaseFirestore.instance.collection("orders");

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthFunc>().userModel;
    final orders = FirebaseFirestore.instance
        .collection('business_owners')
        .doc(user!.id)
        .collection('orders');
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Text(
                    'Your Orders',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                  stream: orders.snapshots(),
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final orders = snapshot.data!.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();

                      return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return ListTile(
                            leading: order.approved
                                ? const Icon(Icons.check_box,
                                    color: Colors.green)
                                : const Icon(Icons.check_box_outline_blank),
                            title: Text('${order.toAddress.street} ${order.toAddress.city} ${order.toAddress.state} ${order.toAddress.zip}'),
                            subtitle: Text('Item - ${order.item}'),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
