import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/models/user_model.dart';
import 'package:provider/provider.dart';

import '../models/order_model.dart';

class OrdersProvider extends ChangeNotifier {
  final BuildContext context;
  OrdersProvider(this.context);
  String orderID = '';

  init() {
    fetchOrders(null);
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>?
      searchDeliverySnapshot;

  final orderRef =
      FirebaseFirestore.instance.collection('business_owners').snapshots();

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>?
      get orderModelStream => searchDeliverySnapshot;

  List<OrderModel> acceptedOrdersList = [];

  List<OrderModel> get getAcceptedOrderList => acceptedOrdersList;

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

    print(order.item);
    print(truckOwner['accepted_orders']);

    return order;
  }

  void fetchOrders(String? state) async {
    Stream<List<QuerySnapshot<Map<String, dynamic>>>> ordersSnapshots;
    if (state != null) {
      ordersSnapshots = orderRef.asyncMap((snapshot) async {
        return await Future.wait(snapshot.docs.map((docs) async {
          return await docs.reference
              .collection('orders')
              .where('approved', isEqualTo: true)
              .where('accepted', isEqualTo: false)
              .where('to_address.state', isEqualTo: state)
              .get();
        }));
      });
    } else {
      ordersSnapshots = orderRef.asyncMap((snapshot) async {
        return await Future.wait(snapshot.docs.map((docs) async {
          return await docs.reference
              .collection('orders')
              .where('approved', isEqualTo: true)
              .where('accepted', isEqualTo: false)
              .get();
        }));
      });
    }

    searchDeliverySnapshot = ordersSnapshots.map(
        (snapshots) => snapshots.expand((snapshot) => snapshot.docs).toList());
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
      return order;
    }).toList());

    acceptedOrdersList = orders;
    return acceptedOrdersList;
  }
}
