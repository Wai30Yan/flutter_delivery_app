import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_delivery/models/driver_model.dart';
import 'package:flutter_delivery/models/user_model.dart';

class DriverProvider extends ChangeNotifier {
  BuildContext buildContext;
  DriverProvider(this.buildContext);



  List<Map<String, dynamic>> allDriversInfo = [];
  List<Map<String, dynamic>> get getAllDriversInfo => allDriversInfo;

  Future<List<Map<String, dynamic>>> getDrivers(UserModel user) async {
    final userRef =
        FirebaseFirestore.instance.collection('truck_owners').doc(user.id);
    final driverCollection = userRef.collection('drivers');
    final driversSnapshot = await driverCollection.get();
   
    final driversList = driversSnapshot.docs
        .map((doc) => DriverModel.fromSnapshot(doc))
        .toList();

    final List<Map<String, dynamic>> driversInfo =
        driversSnapshot.docs.map((doc) {
      final data = <String, dynamic>{
        "driver": DriverModel.fromSnapshot(doc),
        "driverRef": doc.reference,
      };
      return data;
    }).toList();
    allDriversInfo = driversInfo;

    return allDriversInfo;
  }
}
