import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_delivery/models/order_model.dart';

String name = 'bizz';
String id = 'DOi0Y66NgROYk5hJurVdZ4DbL8J2';

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
    street: "Damasatkyar Street",
    city: "Kalaw",
    state: "SHN",
    zip: "11191",
    coordinates: const GeoPoint(20.6263, 96.5625),
  ),
  fromAddress: Address(
    street: "Mandalar Min Street",
    city: "Meiktila",
    state: "MDY",
    zip: "22292",
    coordinates: const GeoPoint(20.8764, 95.8617),
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
    street: "Myo Shaung Rd",
    city: "Bago",
    state: "BGO",
    zip: "55595",
    coordinates: const GeoPoint(17.3877, 96.5140),
  ),
  fromAddress: Address(
    street: "Dhammna Sarri Street",
    city: "Mawlamyine",
    state: "KYN",
    zip: "66696",
    coordinates: const GeoPoint(16.4810, 97.6385),
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
    street: "Dhammna Sarri Street",
    city: "Mawlamyine",
    state: "KYN",
    zip: "66696",
    coordinates: const GeoPoint(17.3877, 96.5140),
  ),
  fromAddress: Address(
    street: "Pawdawmu Street",
    city: "Myeik",
    state: "TNTR",
    zip: "44494",
    coordinates: const GeoPoint(12.4713, 98.6634),
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
    street: "Munkhrain Rd",
    city: "Myitkyina",
    state: "KCH",
    zip: "11191",
    coordinates: const GeoPoint(25.3863, 97.3983),
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

List<OrderModel> dummyOrder1 = [order1, order2, order3, order4, order5, order6];