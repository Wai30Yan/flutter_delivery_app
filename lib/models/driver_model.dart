import 'package:cloud_firestore/cloud_firestore.dart';

class DriverModel {
  String carType;
  String carNumber;
  bool status;
  DriverInfo driverInfo;
  List<DocumentReference> assignOrders;

  DriverModel({
    required this.carType,
    required this.carNumber,
    required this.driverInfo,
    required this.status,
    required this.assignOrders,
  });

  DriverModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : carType = snapshot['car_type'],
        carNumber = snapshot['car_number'],
        driverInfo = DriverInfo.fromSnapshot(
            snapshot['driver_info'] as Map<String, dynamic>),
        status = snapshot['status'],
        assignOrders = List<DocumentReference>.from(snapshot['assign_orders']);

  Map<String, dynamic> toJson() {
    return {
      'car_type': carType,
      'car_number': carNumber,
      'driver_info': driverInfo.toJson(),
      'status': status,
      'assign_orders': assignOrders,

      /**
       *    might need this in future, just not sure at that time
       */
      // 'assign_orders': assignOrders.map((order) => order.path).toList(),
    };
  }
}

class DriverInfo {
  String name;
  String phoneNumber;
  String nrcNumber;

  DriverInfo({
    required this.name,
    required this.phoneNumber,
    required this.nrcNumber,
  });

  DriverInfo.fromSnapshot(Map<String, dynamic> snapshot)
      : name = snapshot['name'],
        phoneNumber = snapshot['phone_number'],
        nrcNumber = snapshot['nrc_number'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'nrc_number': nrcNumber,
    };
  }
}
