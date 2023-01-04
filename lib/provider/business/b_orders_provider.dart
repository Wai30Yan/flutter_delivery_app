import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BOrdersProvider extends ChangeNotifier {
  BuildContext context;
  BOrdersProvider(this.context);
  List<Map<String, dynamic>> ordersAcceptedByTruckOwners = [];
  List<Map<String, dynamic>> get getOrdersAcceptedByTruckOwners =>
      ordersAcceptedByTruckOwners;

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchOrders(String bizUserID) {
    final orderRefs = FirebaseFirestore.instance
        .collection('business_owners')
        .doc(bizUserID)
        .collection('orders')
        .snapshots();

    print('inside business orderProvider: ${orderRefs.first}');
    print(
        'length inside business orderProvider: ${orderRefs.length.toString()}');

    return orderRefs;
  }
}
