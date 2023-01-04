import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/models/order_model.dart';
import 'package:flutter_delivery/truck/delivery_info.dart';
import 'package:provider/provider.dart';

import 'package:flutter_delivery/provider/business/b_orders_provider.dart';

import '../auth/auth.dart';

class SeeOrdersScreen extends StatelessWidget {
  SeeOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthFunc>().userModel;
    final orders = Provider.of<BOrdersProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Your delivery orders approved by admin',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: orders.fetchOrders(user!.id),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      {
                        if (snapshot.hasData) {
                          final docs = snapshot.data?.docs;
                          print('inside streambuilder: ${snapshot.data?.docs}');
                          return ListView.builder(
                            itemCount: docs?.length,
                            itemBuilder: (context, index) {
                              final order =
                                  OrderModel.fromSnapshot(docs![index]);

                              return ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return DeliveryInfo(
                                        order: order, orderID: docs[index].id);
                                  }));
                                },
                                leading: order.approved
                                    ? const Icon(Icons.check_box,
                                        color: Colors.green)
                                    : const Icon(Icons.check_box_outline_blank),
                                title: Text(
                                    '${order.toAddress.street} ${order.toAddress.city} ${order.toAddress.state} ${order.toAddress.zip}'),
                                subtitle: Text('Item - ${order.item}'),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child:
                                Text('Something went wrong. ${snapshot.error}'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }

                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
