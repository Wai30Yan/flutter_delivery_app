import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_form_field.dart';

class AddTruck extends StatelessWidget {
  AddTruck({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  TextEditingController carTypeController = TextEditingController();
  TextEditingController carNoController = TextEditingController();
  TextEditingController driverInfoController = TextEditingController();

  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthFunc>().userModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a delivery order here'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            CustomTextFormField(
                labelText: 'Enter Car Type', controller: carTypeController),
            CustomTextFormField(
                labelText: 'Enter Car Number', controller: carNoController),
            CustomTextFormField(
                labelText: 'Enter Driver Info',
                controller: driverInfoController),
            ElevatedButton(
              onPressed: () {
                var data = <String, dynamic>{
                  "car_type": carTypeController.text,
                  "car_number": carNoController.text,
                  "driver_info": driverInfoController.text,
                };
                for (var k in data.keys) {
                  if (data[k] == "") {
                    final snackBar = SnackBar(
                        backgroundColor: Colors.grey[200],
                        content: Text(
                          "$k cannot be empty",
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                }
                var userRef = db.collection('truck_owners').doc(user?.id);
                userRef
                    .collection('drivers')
                    .add(data)
                    .then((DocumentReference doc) {
                  Navigator.of(context).pop();
                  debugPrint('DocumentSnapShot added: ${doc.id}');
                });
              },
              child: const Text('Create Truck Driver'),
            ),
          ],
        ),
      ),
    );
  }
}
