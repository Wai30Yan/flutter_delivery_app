import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/models/order_model.dart';
import 'package:flutter_delivery/provider/orders_provider.dart';
import 'package:flutter_delivery/truck/delivery_info.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';

List<String> states = <String>[
  'KCH',
  'KYR',
  'KYN',
  'CHN',
  'MON',
  'RAK',
  'SHN',
  'MDY',
  'YGN',
  'SAG',
  'TNTR',
];

class SearchDelivery extends StatefulWidget {
  SearchDelivery({Key? key}) : super(key: key);

  @override
  State<SearchDelivery> createState() => _SearchDeliveryState();
}

class _SearchDeliveryState extends State<SearchDelivery> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final orderStream = context.watch<OrdersProvider>().orderModelStream;

    context.read<OrdersProvider>().fetchOrders(dropdownValue);

    void onStateChanged(String? state) {
      context.read<OrdersProvider>().fetchOrders(state);

      setState(() {
        dropdownValue = state;
      });
    }

    final acceptedOrdersList =
        context.read<OrdersProvider>().getAcceptedOrderList;

    bool max = acceptedOrdersList.length == 4 ? true : false;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text('Choose a state where you can pick up items:',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0,
                          )),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue,
                          onChanged: onStateChanged,
                          items: states
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child:
                  //  max
                  //     ? const Center(
                  //         child: Text(
                  //           'You have accepted max number of 4 delivery orders.',
                  //           style: TextStyle(fontSize: 15.0),
                  //         ),
                  //       )
                  //     :
                  StreamBuilder(
                stream: orderStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                            'There are not any delivery requests from that state.'),
                      );
                    }
                    final orders = snapshot.data;
                    return ListView.builder(
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = orders[index];
                        final order = OrderModel.fromSnapshot(doc);
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return DeliveryInfo(
                                orderID: doc.id,
                                order: order,
                              );
                            })));
                          },
                          child: ListTile(
                            title: Text(
                                'From: ${order.fromAddress.city}, ${order.fromAddress.state} - To: ${order.toAddress.city}, ${order.toAddress.state}'),
                            subtitle: Text(
                                'Item - ${order.item} | Posted by - ${order.name}'),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Something went wrong. ${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
