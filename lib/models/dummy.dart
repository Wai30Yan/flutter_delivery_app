import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/dummyData/dummyOrder1.dart';
import 'package:flutter_delivery/dummyData/dummyOrder2.dart';
import 'package:flutter_delivery/models/order_model.dart';

import 'driver_model.dart';

final driver1 = DriverModel(
  carType: 'Truck',
  carNumber: 'ABC123',
  driverInfo: DriverInfo(
    name: 'James Bond',
    phoneNumber: '+1 123 456 7890',
    nrcNumber: 'AMZ/N39485',
  ),
  status: false,
  assignOrders: [],
);

final driver2 = DriverModel(
  carType: 'Van',
  carNumber: 'DEF456',
  driverInfo: DriverInfo(
    name: 'Don Toretto',
    phoneNumber: '+1 234 567 8901',
    nrcNumber: 'THB/D59672',
  ),
  status: false,
  assignOrders: [],
);

final driver3 = DriverModel(
  carType: 'Car',
  carNumber: 'GHI789',
  driverInfo: DriverInfo(
    name: 'Paul Walker',
    phoneNumber: '+1 345 678 9012',
    nrcNumber: 'LIC/K007',
  ),
  status: false,
  assignOrders: [],
);

final driver4 = DriverModel(
  carType: 'SUV',
  carNumber: 'JKL101',
  driverInfo: DriverInfo(
    name: 'The Snail',
    phoneNumber: '+1 456 789 0123',
    nrcNumber: 'ALC/D048503',
  ),
  status: false,
  assignOrders: [],
);

List<DriverModel> dummyDrivers = [driver1, driver2, driver3, driver4];

class Dummy extends StatelessWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            for (var data in dummyOrder1) {
              FirebaseFirestore.instance
                  .collection('orders')
                  .add(data.toJson())
                  .then((DocumentReference doc) {
                debugPrint('DocumentSnapShot added: ${doc.id}');
              });
            }
          },
          child: const Text('BIZZ'),
        ),
        ElevatedButton(
          onPressed: () {
            for (var data in dummyOrder2) {
              FirebaseFirestore.instance
                  .collection('orders')
                  .add(data.toJson())
                  .then((DocumentReference doc) {
                debugPrint('DocumentSnapShot added: ${doc.id}');
              });
            }
          },
          child: const Text('BIZZ2'),
        ),
        ElevatedButton(
          onPressed: () {
            final driverCollection = FirebaseFirestore.instance
                .collection('truck_owners')
                .doc('iFolIsuXOegmEkD8Wu0yeFuAJbw1') // for user name truck
                // .doc('mBYj8pg4adNkt9lg7R5ozOefoM82') // for user name truck2
                .collection('drivers');

            dummyDrivers.forEach((element) {
              driverCollection.add(element.toJson());
            });
          },
          child: const Text('Drivers'),
        )
      ],
    );
  }
}

// business_owners/DOi0Y66NgROYk5hJurVdZ4DbL8J2/orders/JB56Kp8IEmRbcfthkFg7
