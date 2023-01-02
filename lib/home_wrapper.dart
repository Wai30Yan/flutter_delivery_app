import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/auth/auth_wrapper.dart';
import 'package:flutter_delivery/business/business_root.dart';
import 'package:flutter_delivery/truck/truck_root.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = context.watch<AuthFunc>().userModel;
    // bool loggedIn = context.watch<AuthFunc>().loggedIn;
    final type = user?.type;
    // if (user == null) return const AuthWrapper();

    return type == 'Business Owner' ? const BusinessRoot() : TruckRoot();
  }
}
