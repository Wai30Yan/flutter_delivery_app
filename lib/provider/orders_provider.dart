import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/models/user_model.dart';

import '../models/order_model.dart';

class OrdersProvider extends ChangeNotifier {
  final BuildContext context;
  OrdersProvider(this.context);
  String orderID = '';

  List<OrderModel> acceptedOrdersList = [];
  List<OrderModel> get getAcceptedOrderList => acceptedOrdersList;

  List<Map<String, dynamic>> acceptedOrderInfo = [];
  List<Map<String, dynamic>> get getAcceptedOrderInfo => acceptedOrderInfo;

  String get getOrderID => orderID;

  late Stream<OrderModel> acceptedOrder;
  Stream<OrderModel> get getAcceptedOrder => acceptedOrder;

  Future<OrderModel> acceptingTheOrder(
      DocumentReference orderRef, DocumentReference truckOwnerRef) async {
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

    final orderSnapshot = await orderRef.get();
    final truckOwnerSnapshot = await truckOwnerRef.get();
    final order = OrderModel.fromSnapshot(orderSnapshot);
    final truckOwner = truckOwnerSnapshot.data();
    acceptedOrder = Stream.value(order);

    Map.from(truckOwner as Map<String, dynamic>);

    return order;
  }

  StreamSubscription<QuerySnapshot<Object?>> fetchOrders(String? state) {
    final CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');

    final orders = ordersCollection.snapshots().listen((snapshot) {
      snapshot.docs.forEach((doc) => print(doc.data));
    });

    return orders;
  }

  Future<List<dynamic>> getAcceptedOrders(UserModel user) async {
    final truckOwnerDoc = await FirebaseFirestore.instance
        .collection('truck_owners')
        .doc(user.id)
        .get();

    List<dynamic> acceptedOrdersField =
        await truckOwnerDoc.data()!['accepted_orders'];

    List<OrderModel> orders =
        await Future.wait(acceptedOrdersField.map((docRef) async {
      DocumentSnapshot snapshot = await docRef.get();
      orderID = snapshot.id;
      final order = OrderModel.fromSnapshot(snapshot);
      acceptedOrderInfo.add({
        'order': order,
        'orderRef': docRef,
      });
      return order;
    }).toList());

    acceptedOrdersList = orders;
    return acceptedOrdersList;
  }
}
