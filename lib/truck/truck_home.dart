import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/models/order_model.dart';
import 'package:flutter_delivery/provider/drivers_provider.dart';
import 'package:flutter_delivery/provider/orders_provider.dart';
import 'package:flutter_delivery/truck/add_truck.dart';
import 'package:flutter_delivery/truck/delivery_info.dart';
import 'package:provider/provider.dart';

import '../models/driver_model.dart';

class TruckHome extends StatelessWidget {
  int currentPageIndex = 0;
  List<Widget> children = [];
  TruckHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthFunc>().userModel!;
    DriverProvider driverProvider =
        Provider.of<DriverProvider>(context, listen: false);
    OrdersProvider ordersProvider =
        Provider.of<OrdersProvider>(context, listen: false);

    final numOfDrivers = driverProvider.getAllDriversInfo;
    final orderID = ordersProvider.getOrderID;

    final orderInfo = ordersProvider.getAcceptedOrderInfo;

    for (int i = 0; i < orderInfo.length; i++) {
      OrderModel order = orderInfo[i]['order'];
      if (order.truckOwnerRef != null) {
        print(order);
        print('order is: ${orderInfo[i]['order'].item}');
        print('orderRef is: ${orderInfo[i]['orderRef']}');
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    'Homescreen for Truck Owner, ${user.name}',
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: numOfDrivers.length == 4
                      ? null
                      : () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return AddTruck();
                          })));
                        },
                  child: const Text('Add a driver'),
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
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    'Your Drivers',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: driverProvider.getDrivers(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final driverList = snapshot.data;
                    if (driverList == null || driverList.isEmpty) {
                      return const Center(
                        child: Text('You do not have a driver yet.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: driverList.length,
                      itemBuilder: (context, index) {
                        DriverModel driver = driverList[index]['driver'];
                        DocumentReference driverRef =
                            driverList[index]['driverRef'];
                        bool status = driver.status;
                        return ListTile(
                          // ignore: sized_box_for_whitespace
                          leading: Container(
                            height: double.infinity,
                            child: Icon(
                              Icons.person,
                              color: status ? Colors.green : null,
                            ),
                          ),
                          title: Text(
                            driver.driverInfo.name,
                            style: TextStyle(
                              color: status ? Colors.green : null,
                            ),
                          ),
                          subtitle:
                              Text('${driver.carType} (${driver.carNumber})'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await driverRef
                                      .delete()
                                      .catchError((e) => debugPrint(e));
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[400],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    'Your Accepted Delivery Orders',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: ordersProvider.getAcceptedOrders(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final acceptedOrders = snapshot.data;
                    if (acceptedOrders!.isEmpty) {
                      return const Center(
                          child: Text("You have not accepted any orders."));
                    }
                    return ListView.builder(
                        itemCount: acceptedOrders.length,
                        itemBuilder: (context, index) {
                          OrderModel order = acceptedOrders[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return DeliveryInfo(
                                    orderID: orderID,
                                    order: order,
                                  );
                                }));
                              },
                              child: ListTile(
                                title: Text(
                                    'Drop at: ${order.toAddress.street} ${order.toAddress.city} ${order.toAddress.state}'),
                                subtitle: Text('Item - ${order.item}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red[400],
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return Text("An error occurred: ${snapshot.error}");
                  } else {
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
