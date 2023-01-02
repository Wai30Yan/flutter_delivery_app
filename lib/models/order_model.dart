import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String name;
  final String phone;
  final String item;
  final String ownerID;
  final DocumentReference? truckOwnerRef;
  final DocumentReference? deliveryDriver;
  final bool approved;
  final bool accepted;
  final Address toAddress;
  final Address fromAddress;

  OrderModel({
    required this.name,
    required this.phone,
    required this.item,
    required this.ownerID,
    this.truckOwnerRef,
    this.deliveryDriver,
    required this.approved,
    required this.accepted,
    required this.toAddress,
    required this.fromAddress,
  });

  OrderModel.fromMap(Map<String, dynamic> data)
      : name = data['name'],
        phone = data['phone'],
        item = data['item'],
        ownerID = data['owner_id'],
        truckOwnerRef = data['truck_owner_ref'],
        deliveryDriver = data['delivery_driver'],
        approved = data['approved'],
        accepted = data['accepted'],
        toAddress = Address.fromSnapshot(data['to_address']),
        fromAddress = Address.fromSnapshot(data['from_address']);

  OrderModel.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        phone = snapshot['phone'],
        item = snapshot['item'],
        ownerID = snapshot['owner_id'],
        truckOwnerRef = snapshot['truck_owner_ref'],
        deliveryDriver = snapshot['delivery_driver'],
        approved = snapshot['approved'],
        accepted = snapshot['accepted'],
        toAddress = Address.fromSnapshot(snapshot['to_address']),
        fromAddress = Address.fromSnapshot(snapshot['from_address']);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'item': item,
      'owner_id': ownerID,
      'truck_owner_ref': truckOwnerRef?.path,
      'delivery_driver': deliveryDriver?.path,
      'approved': approved,
      'accepted': accepted,
      'to_address': toAddress.toJson(),
      'from_address': fromAddress.toJson(),
    };
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String zip;
  final GeoPoint coordinates;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
    required this.coordinates,
  });

  Address.fromSnapshot(Map<String, dynamic> snapshot)
      : street = snapshot['street'],
        city = snapshot['city'],
        state = snapshot['state'],
        zip = snapshot['zip'],
        coordinates = snapshot['coordinates'];

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'state': state,
      'street': street,
      'zip': zip,
      'coordinates': coordinates,
    };
  }
}
