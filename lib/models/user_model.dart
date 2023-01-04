import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserModel {
  String type;
  String email;
  String id;
  String name;

  UserModel({
    required this.type,
    required this.email,
    required this.id,
    required this.name,
  });

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : type = snapshot['account_type'],
        email = snapshot['email'],
        id = snapshot['id'],
        name = snapshot['name'];

  // static UserModel fromJson(Map<String, dynamic> json) => UserModel(
  //       type: json['account_type'],
  //       email: json['email'],
  //       id: json['id'],
  //       name: json['name'],
  //     );
}

class BusinessOwner extends UserModel {
  BusinessOwner({
        required String type,
    required String email,
    required String id,
    required String name,
  }) : super(type: type, email: email, id: id, name: name);

    factory BusinessOwner.fromSnapshot(DocumentSnapshot snapshot) {
    return BusinessOwner(
      type: snapshot['account_type'],
      email: snapshot['email'],
      id: snapshot['id'],
      name: snapshot['name'],
    );
  }
}

class TruckOwner extends UserModel {
  List<DocumentReference> acceptedOrders;

  TruckOwner({
    required String type,
    required String email,
    required String id,
    required String name,
    required this.acceptedOrders,
  }) : super(type: type, email: email, id: id, name: name);

  factory TruckOwner.fromSnapshot(DocumentSnapshot snapshot) {
    return TruckOwner(
      type: snapshot['account_type'],
      email: snapshot['email'],
      id: snapshot['id'],
      name: snapshot['name'],
      acceptedOrders: List<DocumentReference>.from(snapshot['accepted_orders']),
    );
  }

  factory TruckOwner.fromMap(Map map) {
    return TruckOwner(
      type: map['account_type'],
      email: map['email'],
      id: map['id'],
      name: map['name'],
      acceptedOrders: List<DocumentReference>.from(map['accepted_orders']),
    );
  }
}
