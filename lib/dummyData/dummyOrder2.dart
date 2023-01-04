import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_delivery/models/order_model.dart';

String name = 'bizz2';
String id = 'PZbBSYlU1GhwTyYWryV48CWBZfn2';

OrderModel order1 = OrderModel(
  name: name,
  phone: "+95 987 654 3210",
  item: "Books",
  ownerID: id,
  truckOwnerRef: null,
  deliveryDriver: null,
  approved: true,
  accepted: false,
  toAddress: Address(
    street: "123 Main Street",
    city: "Yangon",
    state: "YGN",
    zip: "11191",
    coordinates: const GeoPoint(16.78466, 96.13557),
  ),
  fromAddress: Address(
    street: "456 Second Street",
    city: "Mandalay",
    state: "MDY",
    zip: "22292",
    coordinates: const GeoPoint(22.01059, 96.48808),
  ),
);

OrderModel order3 = OrderModel(
  name: name,
  phone: "+95 345 678 9012",
  item: "Furniture",
  ownerID: id,
  truckOwnerRef: null,
  deliveryDriver: null,
  approved: true,
  accepted: false,
  toAddress: Address(
    street: "369 Fifth Street",
    city: "Bagan",
    state: "MDY",
    zip: "55595",
    coordinates: const GeoPoint(21.91448, 95.95486),
  ),
  fromAddress: Address(
    street: "159 Sixth Street",
    city: "Sittwe",
    state: "RAK",
    zip: "66696",
    coordinates: const GeoPoint(19.75962, 96.12934),
  ),
);

OrderModel order2 = OrderModel(
  name: name,
  phone: "+95 123 456 7890",
  item: "Clothing",
  ownerID: id,
  truckOwnerRef: null,
  deliveryDriver: null,
  approved: true,
  accepted: false,
  toAddress: Address(
    street: "789 Third Street",
    city: "Naypyidaw",
    state: "MDY",
    zip: "33393",
    coordinates: const GeoPoint(17.99697, 95.65924),
  ),
  fromAddress: Address(
    street: "246 Fourth Street",
    city: "Taunggyi",
    state: "SHN",
    zip: "44494",
    coordinates: const GeoPoint(20.46192, 94.88429),
  ),
);

OrderModel order4 = OrderModel(
  name: name,
  phone: "+95 987 654 3210",
  item: "Books",
  ownerID: id,
  truckOwnerRef: null,
  deliveryDriver: null,
  approved: true,
  accepted: false,
  toAddress: Address(
    street: "Gabar Aye Street",
    city: "Inle",
    state: "SHN",
    zip: "11191",
    coordinates: const GeoPoint(20.53, 96.53),
  ),
  fromAddress: Address(
    street: "Theit Pan Street",
    city: "Mandalay",
    state: "MDY",
    zip: "22292",
    coordinates: const GeoPoint(22.01059, 96.48808),
  ),
);

OrderModel order5 = OrderModel(
  name: name,
  phone: "+95 345 678 9012",
  item: "Furniture",
  ownerID: id,
  truckOwnerRef: null,
  deliveryDriver: null,
  approved: true,
  accepted: false,
  toAddress: Address(
    street: "Anawrahtar Street",
    city: "Mrauk U",
    state: "RAK",
    zip: "55595",
    coordinates: const GeoPoint(20.7, 93.43),
  ),
  fromAddress: Address(
    street: "Thandwe Street",
    city: "Inle",
    state: "SHN",
    zip: "66696",
    coordinates: const GeoPoint(20.53, 96.53),
  ),
);

OrderModel order6 = OrderModel(
  name: name,
  phone: "+95 123 456 7890",
  item: "Clothing",
  ownerID: id,
  truckOwnerRef: null,
  deliveryDriver: null,
  approved: true,
  accepted: false,
  toAddress: Address(
    street: "Pyithu Htutaw Street",
    city: "Hpa-An",
    state: "KYN",
    zip: "33393",
    coordinates: const GeoPoint(16.87, 97.65),
  ),
  fromAddress: Address(
    street: "Lasho Street",
    city: "Taunggyi",
    state: "SHN",
    zip: "44494",
    coordinates: const GeoPoint(20.46192, 94.88429),
  ),
);

List<OrderModel> dummyOrder2 = [order1, order2, order3, order4, order5, order6];