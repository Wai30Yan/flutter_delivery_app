import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class AuthFunc extends ChangeNotifier {
  final BuildContext context;
  final _auth = FirebaseAuth.instance;
  final truckRef = FirebaseFirestore.instance.collection('truck_owners');
  final businessRef = FirebaseFirestore.instance.collection('business_owners');
  UserModel? _user;
  bool _loggedIn = false;

  AuthFunc(this.context);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();
  UserModel? get userModel => _user;
  bool get loggedIn => _loggedIn;

  Future<void> getUserDocument(String uid) async {
    truckRef.doc(uid).get().then((snapshot) {
      if (snapshot.exists) {
        _user = TruckOwner.fromSnapshot(snapshot);
        notifyListeners();
        return;
      }
    });

    businessRef.doc(uid).get().then((snapshot) {
      if (snapshot.exists) {
        _user = BusinessOwner.fromSnapshot(snapshot);
        notifyListeners();
        return;
      }
    });
  }

  Future<User?> login(String email, String password) async {
    final credential = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .onError((error, stackTrace) => throw Exception(error));
    _loggedIn = true;
    getUserDocument(credential.user!.uid);
    return credential.user;
  }

  Future<User?> signUp(String email, String password) async {
    final credential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .onError((error, stackTrace) => throw Exception(error));
    _loggedIn = true;
    getUserDocument(credential.user!.uid);
    return credential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _loggedIn = false;
  }
}
