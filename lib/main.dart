import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/auth/auth_wrapper.dart';
import 'package:flutter_delivery/auth/login.dart';
import 'package:flutter_delivery/business/business_root.dart';
import 'package:flutter_delivery/firebase_options.dart';
import 'package:flutter_delivery/provider/drivers_provider.dart';
import 'package:flutter_delivery/provider/orders_provider.dart';
import 'package:flutter_delivery/truck/truck_root.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthFunc(context)),
      ChangeNotifierProvider(create: (context) => OrdersProvider(context)),
      ChangeNotifierProvider(create: (context) => DriverProvider(context)),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool loggedIn = context.watch<AuthFunc>().loggedIn;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/truck': (context) => const TruckRoot(),
        '/business': (context) => BusinessRoot(),
        '/auth': (context) => Login(),
      },
    );
  }
}


