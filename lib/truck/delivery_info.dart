import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/models/order_model.dart';
import 'package:flutter_delivery/provider/drivers_provider.dart';
import 'package:flutter_delivery/widgets/assigned_driver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/driver_model.dart';

class DeliveryInfo extends StatelessWidget {
  OrderModel order;
  String orderID;

  DeliveryInfo({required this.order, required this.orderID, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GeoPoint pickUpGeo = order.fromAddress.coordinates;
    GeoPoint dropGeo = order.toAddress.coordinates;
    LatLng pickUpLocation = LatLng(pickUpGeo.latitude, pickUpGeo.longitude);
    LatLng dropOfLocation = LatLng(dropGeo.latitude, dropGeo.longitude);

    CameraPosition kInitialPosition =
        CameraPosition(target: pickUpLocation, zoom: 16.0, tilt: 0, bearing: 0);
    final user = context.read<AuthFunc>().userModel;
    final truckOwnerRef =
        FirebaseFirestore.instance.collection('truck_owners').doc(user?.id);

    DriverProvider driverProvider =
        Provider.of<DriverProvider>(context, listen: false);

    // OrdersProvider ordersProvider =
    //     Provider.of<OrdersProvider>(context, listen: false);

    DocumentReference<Map<String, dynamic>> orderRef =
        FirebaseFirestore.instance.collection('orders').doc(orderID);

    driverProvider.getDrivers(user!);

    List<Map<String, dynamic>> driverInfo = driverProvider.getAllDriversInfo;

    bool hasDriver = order.deliveryDriver == null ? false : true;
    Map<String, dynamic> assignedDriverInfo = {};
    if (hasDriver) {
      for (int i = 0; i < driverInfo.length; i++) {
        if (driverInfo[i]['driverRef'] == order.deliveryDriver) {
          assignedDriverInfo = driverInfo[i];
        }
      }
    }

    final dd = driverInfo
        .where((element) =>
            element['driver'] is DriverModel &&
            element['driver'].status == true)
        .toList();

    print(driverInfo.first);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      'The delivery info',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                // ignore: sized_box_for_whitespace
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: const Text("Order posted by"),
                title: Text(order.name),
              ),
              ListTile(
                // ignore: sized_box_for_whitespace
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.phone,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: const Text("Phone numer"),
                title: Text(order.phone),
              ),
              ListTile(
                // ignore: sized_box_for_whitespace
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.pin_drop_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: const Text("Pick up location"),
                title: Text(
                    '${order.fromAddress.street} ${order.fromAddress.city} ${order.fromAddress.state}'),
              ),
              ListTile(
                // ignore: sized_box_for_whitespace
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.pin_drop_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: const Text("Drop of location"),
                title: Text(
                    '${order.toAddress.street} ${order.toAddress.city} ${order.toAddress.state}'),
              ),
              ListTile(
                // ignore: sized_box_for_whitespace
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.directions_bus,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: const Text("Material"),
                title: Text(order.item),
              ),
              SizedBox(
                height: 500,
                child: Card(
                  elevation: 5,
                  child: GestureDetector(
                    onVerticalDragStart: (start) {},
                    child: GoogleMap(
                      initialCameraPosition: kInitialPosition,
                      gestureRecognizers: Set()
                        ..add(Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer()))
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer()))
                        ..add(Factory<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer()))
                        ..add(Factory<TapGestureRecognizer>(
                            () => TapGestureRecognizer()))
                        ..add(Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer())),
                      markers: <Marker>{
                        Marker(
                          infoWindow: InfoWindow(
                              title: 'Pick up address',
                              snippet:
                                  '${order.fromAddress.street} ${order.fromAddress.city} ${order.fromAddress.state}'),
                          markerId: const MarkerId('marker1'),
                          position: pickUpLocation,
                        ),
                        Marker(
                          infoWindow: InfoWindow(
                              title: 'Drop off address',
                              snippet:
                                  '${order.toAddress.street} ${order.toAddress.city} ${order.toAddress.state}'),
                          markerId: const MarkerId('marker2'),
                          position: dropOfLocation,
                        ),
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              hasDriver
                  ? AssignedDriver(
                      driverInfo: assignedDriverInfo,
                    )
                  : Container(),
              // const SizedBox(
              //   height: 50,
              //   child: Center(
              // child: Text('You have not assign a driver for this order'),
              //   ),
              // ),

              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .doc(orderID)
                    .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case (ConnectionState.waiting):
                      {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                    case (ConnectionState.active):
                      {
                        Map<String, dynamic> doc = Map.from(
                            snapshot.data?.data() as Map<String, dynamic>);
                        final order = OrderModel.fromMap(doc);
                        if (order.accepted) {
                          return ElevatedButton(
                            onPressed: () {},
                            child: const Text('Assign a driver'),
                          );
                        } else {
                          return ElevatedButton(
                            onPressed: () {
                              orderRef.update({
                                'accepted': true,
                                'truck_owner_ref': truckOwnerRef,
                              }).then((value) {
                                truckOwnerRef.update({
                                  'accepted_orders': FieldValue.arrayUnion([
                                    orderRef,
                                  ]),
                                });
                              });
                            },
                            child: const Text('Take this order'),
                          );
                        }
                      }
                    default:
                      {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                  }
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  // if (order.accepted && !hasDriver) {
  //                             showModalBottomSheet(
  //                                 context: context,
  //                                 builder: ((context) {
  //                                   return SizedBox(
  //                                     height: 500,
  //                                     child: ListView.builder(
  //                                       itemCount: driverInfo.length,
  //                                       itemBuilder: (context, index) {
  //                                         DriverModel driver =
  //                                             driverInfo[index]['driver'];

  //                                         return GestureDetector(
  //                                           onTap: driver.status
  //                                               ? null
  //                                               : () async {
  //                                                   DocumentReference
  //                                                       driverRef =
  //                                                       driverInfo[index]
  //                                                           ['driverRef'];
  //                                                   // print(driverRef.id);
  //                                                   try {
  //                                                     await orderRef.update({
  //                                                       'delivery_driver':
  //                                                           driverRef,
  //                                                     }).then((value) {});
  //                                                     await driverRef.update({
  //                                                       'status': true,
  //                                                       'assign_orders':
  //                                                           FieldValue
  //                                                               .arrayUnion(
  //                                                                   [orderRef]),
  //                                                     }).then((value) {});
  //                                                   } catch (error) {
  //                                                     error;
  //                                                   }
  //                                                 },
  //                                           child: ListTile(
  //                                             title:
  //                                                 Text(driver.driverInfo.name),
  //                                             subtitle: Text(
  //                                                 '${driver.carType} - ${driver.carNumber}'),
  //                                           ),
  //                                         );
  //                                       },
  //                                     ),
  //                                   );
  //                                 }));
  //                           }









              // accepted
              //     ? hasDriver
              //         ? AssignedDriver(
              //             driverInfo: assignedDriverInfo,
              //           )
              //         : ElevatedButton(
              //             onPressed: () => showModalBottomSheet(
              //                 context: context,
              //                 builder: (context) {
              // return SizedBox(
              //   height: 500,
              //   child: ListView.builder(
              //     itemCount: driverInfo.length,
              //     itemBuilder: (context, index) {
              //       DriverModel driver =
              //           driverInfo[index]['driver'];

              //         return GestureDetector(
              //           onTap: driver.status
              //               ? null
              //               : () async {
              //                   DocumentReference
              //                       driverRef =
              //                       driverInfo[index]
              //                           ['driverRef'];
              //                   // print(driverRef.id);
              //                   try {
              //                     await orderRef.update({
              //                       'delivery_driver':
              //                           driverRef,
              //                     }).then((value) {});
              //                     await driverRef.update({
              //                       'status': true,
              //                       'assign_orders':
              //                           FieldValue
              //                               .arrayUnion(
              //                                   [orderRef]),
              //                     }).then((value) {});
              //                   } catch (error) {
              //                     error;
              //                   }
              //                 },
              //           child: ListTile(
              //             title:
              //                 Text(driver.driverInfo.name),
              //             subtitle: Text(
              //                 '${driver.carType} - ${driver.carNumber}'),
              //           ),
              //         );

              //     },
              //   ),
              // );
              // }),
              //             child: const Text(
              //                 'Assign a driver to this delivery order'),
              //           )
              //     : ElevatedButton(
              //         onPressed: () async {
              //           var data = <String, dynamic>{
              //             'accepted_orders': FieldValue.arrayUnion([
              //               orderRef,
              //             ]),
              //           };
              //           await truckOwnerRef.update(data).then((value) {});
              //           await orderRef.update({
              //             'accepted': true,
              //             'truck_owner_ref': truckOwnerRef,
              //           }).then((value) {});
              //         },
              //         child: const Text('Accept this delivery order'),
              //       ),